/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./src/**/*.{js,ts,jsx,tsx,mdx}'],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Plus Jakarta Sans', 'sans-serif'],
      },
      colors: {
        brand: {
          black:  '#050505',
          white:  '#FFFFFF',
          light:  '#F4F4F5',
          border: '#E5E5E5',
          muted:  '#6B7280',
          blue:   '#0086D6',
          'blue-light': '#E6F3FC',
          'blue-dark':  '#005fa3',
        },
      },
    },
  },
  plugins: [],
}
