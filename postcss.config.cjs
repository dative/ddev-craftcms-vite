module.exports = {
  plugins: {
    'postcss-import': {},

    'tailwindcss/nesting': {},

    tailwindcss: {},

    ...(process.env.NODE_ENV === 'production' ? { autoprefixer: {} } : {}),

    ...(process.env.NODE_ENV === 'production'
      ? {
          cssnano: {
            preset: ['default', { discardComments: { removeAll: true } }],
          },
        }
      : {}),
  },
};
