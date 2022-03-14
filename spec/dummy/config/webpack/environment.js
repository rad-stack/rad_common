const { environment } = require('@rails/webpacker');

environment.config.merge({
    externals: {
        jquery: 'jQuery',
        moment: 'moment'
    }
});

module.exports = environment;
