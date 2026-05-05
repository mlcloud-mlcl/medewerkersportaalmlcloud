#!/bin/sh
# docker-entrypoint.sh
# Voer database migraties uit voor het starten van de app

echo "🔄 Database migraties uitvoeren..."
npx prisma migrate deploy

echo "🚀 App starten..."
exec node server.js
