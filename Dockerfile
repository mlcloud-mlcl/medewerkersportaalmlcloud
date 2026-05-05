# ─── Build stage ─────────────────────────────────────────────────
FROM node:20-alpine AS builder

WORKDIR /app

# Dependencies installeren
COPY package*.json ./
RUN npm ci

# Prisma client genereren
COPY prisma ./prisma
RUN npx prisma generate

# App bouwen
COPY . .
RUN npm run build

# ─── Production stage ─────────────────────────────────────────────
FROM node:20-alpine AS runner

WORKDIR /app

ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1

# Alleen productie dependencies
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

# Prisma runtime
COPY --from=builder /app/node_modules/.prisma ./node_modules/.prisma
COPY --from=builder /app/node_modules/@prisma ./node_modules/@prisma
COPY prisma ./prisma

# Next.js build output
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/public ./public

EXPOSE 3000
ENV PORT=3000
ENV HOSTNAME="0.0.0.0"

CMD ["node", "server.js"]
