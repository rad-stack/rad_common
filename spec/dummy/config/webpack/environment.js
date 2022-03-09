const { environment } = require('@rails/webpacker')

environment.config.merge({
    externals: {
        jquery: 'jQuery'
    }
})

module.exports = environment
