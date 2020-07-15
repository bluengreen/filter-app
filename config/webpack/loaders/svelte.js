module.exports = {
  test: /\.svelte$/,
  use: [{
    loader: 'svelte-loader',
    options: {
      hotReload: true,
      dev: process.env.NODE_ENV !== 'production'
    }
  }],
}
