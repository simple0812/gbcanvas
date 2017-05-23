var boxes = new Boxes;
var groups = new Groups;

_.templateSettings = {
    interpolate : /\{\{(.+?)\}\}/g
};


GroupView = Backbone.View.extend({
    tagName: 'tr',
    template: _.template($('#group-template').html()),

    initialize: function() {
    },

    render: function() {
        var p = this.model.toJSON();
        this.$el.html(this.template(p));
        return this;
    }
});


GroupListView = Backbone.View.extend({
    el: '#group-list',

    events: {
        'click th input': 'selectAll',
        'click td input': 'selectOne'
    },

    initialize: function() {
        this.listenTo(groups, 'add', this.addOne);
        groups.fetch();
    },

    render: function() {
        // 若做排序，重写此方法。
    },

    addOne: function(group) {
        var view = new GroupView({model:group});
        this.$('tbody').append(view.render().el);
    },

    selectAll: function(e) {
        if(this.$('th input:checked').length > 0) {
            this.$('td input').prop('checked', true);
        } else {
            this.$('td input').prop('checked', false);
        }
        if (e && e.stopPropagation) {
            //支持W3C
            e.stopPropagation();
        } else {
            //IE的方式
            window.event.cancelBubble = true;
        }
    },

    selectOne: function(e) {
        if(this.$('td input:checked').length === this.$('td input').length) {
            this.$('th input').prop('checked', true);
        } else {
            this.$('th input').prop('checked', false);
        }
    }
});


BoxView = Backbone.View.extend({
    tagName: 'tr',
    template: _.template($('#box-template').html()),

    initialize: function() {
    },

    render: function() {
        var p = this.model.toJSON();
        p.ip = p.network.ip || '';
        p.online = (p.online === true ? 'online' : 'offline');
        this.$el.html(this.template(p));
        return this;
    }
});


BoxListView = Backbone.View.extend({
    el: '#box-list',
    events: {
        'click th input': 'selectAll',
        'click td input': 'selectOne'
    },

    initialize: function() {
        this.listenTo(boxes, 'add', this.addOne);
        boxes.fetch();
    },

    render: function() {
        // 若做排序，重写此方法。
    },

    addOne: function(box) {
        var view = new BoxView({model:box});
        this.$('tbody').append(view.render().el);
    },

    selectAll: function(e) {
        if(this.$('th input:checked').length > 0) {
            this.$('td input').prop('checked', true);
        } else {
            this.$('td input').prop('checked', false);
        }
        if (e && e.stopPropagation) {
            //支持W3C
            e.stopPropagation();
        } else {
            //IE的方式
            window.event.cancelBubble = true;
        }
    },

    selectOne: function(e) {
        if(this.$('td input:checked').length === this.$('td input').length) {
            this.$('th input').prop('checked', true);
        } else {
            this.$('th input').prop('checked', false);
        }
    }
});


PublishView = Backbone.View.extend({
    el: '#publishModal',
    events: {
        'click #publishBtn': 'publish'
    },

    initialize: function() {
        var boxListView = new BoxListView;
        var groupListView = new GroupListView;
    },

    publish: function(e) {
        var groups = [],
            boxes = [],
            data = {},
            that = this;
        var schedule = this.$el.attr('schedule');
        this.$('#group-list td input:checked').each(function(index, dom) {
            groups.push(that.$(dom).val());
        });
        this.$('#box-list td input:checked').each(function(index, dom) {
            boxes.push(that.$(dom).val());
        });
        if(groups.length === 0 && boxes.length === 0)  return popBy("#publishBtn", false, '请先选择您要发布到的分组或播放器');
        data.groups = groups, data.boxes = boxes;
        if(confirm("确认发布吗？")) {
            $.ajax({
                type: 'POST',
                url: '/publish/' + schedule,
                data: JSON.stringify(data),
                contentType: 'application/json; charset=utf-8',
                success: function(message, status, jqXHR) {
                    if(jqXHR.status === 200) {
                        window.location.href = '/task';
                    }
                },
                error: function(jqXHR,status,message) {
                    if(jqXHR.status === 400) {
                        alert('未知错误，请联系管理员');
                    } else if(jqXHR.status === 404) {
                        alert('部分资源未找到，发布中断');
                    }
                }
            });
        }
    }
});

var publishView = new PublishView;
