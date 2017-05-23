Group = Backbone.Model.extend({
    urlRoot: '/group',

    initialize: function() {
    },

    defaults: {
        id: null,
        name: '',
        boxes: []
    }
});

Groups = Backbone.Collection.extend({
    url: '/groups',
    model: Group
});