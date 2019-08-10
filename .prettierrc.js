module.exports = {
  singleQuote: true,
  trailingComma: 'all',
  arrowParens: 'always',
  overrides: [
    {
      files: '*.md',
      options: {
        singleQuote: false,
        proseWrap: 'always',
      },
    },
  ],
};
