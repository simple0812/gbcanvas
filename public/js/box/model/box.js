Box = Backbone.Model.extend({
    urlRoot: '/device',

    initialize: function() {
    },

    defaults: {
        // persistent attributes
        id: null,
        name: '',
        alias: '',
        auto_screen: [],
        auto_snapshot: '60',
        debug: '0',
        network: {},
        service: '',
        interval: '30',
        // normal attributes
        os: '',
        version: {},
        dsmversion: {},
        cpu: '',
        memory: '',
        disk: '',
        boot: '',
        schedule: [],
        snapshot: '',
        pixel: '',
        client_info: '',
        publish: [],
        commands: [],
        screen: 'off',
        online: false
    },

    update: function(arg) {
        this.save({
            alias: arg.alias || this.get('alias'),
            auto_screen: arg.auto_screen || this.get('auto_screen'),
            auto_snapshot: arg.auto_snapshot || this.get('auto_snapshot'),
            debug: arg.debug || this.get('debug'),
            network: arg.network || this.get('network'),
            service: arg.service || this.get('service'),
            interval: arg.interval || this.get('interval')
        });
    }
});

Boxes = Backbone.Collection.extend({
    url: '/devices',
    model: Box
});