const { environment } = require('@rails/webpacker')
const svelte = require('./loaders/svelte')
const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)
environment.splitChunks()
environment.loaders.prepend('svelte', svelte)
module.exports = environment
