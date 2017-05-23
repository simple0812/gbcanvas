var boxes = new Boxes;
var groups = new Groups;

_.templateSettings = {
    interpolate: /\{\{(.+?)\}\}/g
};

/** boxView **/
BoxScheduleView = Backbone.View.extend({
    tagName: 'div',
    events:{

    },
    initialize:function() {
        this.$el.addClass('row alert alert-info');
        this.$el.css('padding-bottom','0px');
        this.$el.css('padding-top','0px');
    },
    render:function() {
        var data = this.model;
        var that = this;
        this.$el.html(that.format($('#boxSchedule-template').html(),data.name, that.showPlayStatus(data.playStatus), that.showDownloadStatus(data.downloadStatus), data.download));
        return this;
    },
    showDownloadStatus:function(downloadStatus) {
        var message = '';
        switch (downloadStatus) {
            case 1:message = '下载中';break;
            case 2:message = '下载完成';break;
            case 9:message = '<font color="red">下载异常</font>';break;
            default :message ='<font color="red">异常</font>';break;
        }
        return message;
    },
    showPlayStatus:function(playStatus) {
        var message = '';
        switch (playStatus) {
            case 1:message = '待播放';break;
            case 2:message = '播放中';break;
            case 9:message = '<font color="red">播放异常</font>';break;
            default :message ='<font color="red">异常</font>';break;
        }
        return message;
    },
    format:function() {
        if (arguments.length == 0)
            return null;

        var str = arguments[0];
        for (var i = 1; i < arguments.length; i++) {
            var re = new RegExp('\\{' + (i - 1) + '\\}', 'gm');
            str = str.replace(re, arguments[i]);
        }

        return str;
    }
});


/** boxView **/
BoxView = Backbone.View.extend({
    tagName: 'tr',

    template: _.template($('#box-template').html()),

    events: {
        'mouseover': 'showOperation',
        'mouseout': 'hideOperation',
        'click .loadBasicSetting' : 'loadBasicSetting',
        'click .loadNetSetting'   : 'loadNetSetting',
        'click .detail'    : 'detail',
        'click .delete'    : 'clear',
        'click .outOfGroup'   : 'outOfGroup'

    },

    initialize: function() {
        this.listenTo(this.model, 'destroy', this.remove);
        this.listenTo(this.model, 'remove', this.remove);
        this.listenTo(this.model, 'change', this.render);
    },

    render: function() {
      if($('#boxViewBtn').hasClass('btn-primary')) {
          this.renderView();
      } else {
          var data = this.model.toJSON();
          this.$el.html(this.template({id: data.id , name: data.name, alias: data.alias,
              ip: data.network.ip || '', online: (data.online === true ? 'online' : 'offline'), screen: (data.screen === 'on' ? 'screenOn': 'screenOff')}));
          this.input = this.$('.rename');

          var width = $('.h3-head').width()/5 || 120;
          if($.cookie('type') === 'normal') this.$el.find('.delbox-li').hide();
          this.$el.find('.td-alias').css('width',width)
      }
      return this;
    },
    renderView:function() {
        var viewtemplate = _.template($('#boxView-template').html());
        var that = this;
        this.$el.addClass('col-xs-4');
        var data = this.model.toJSON();
        this.$el.html(viewtemplate({id: data.id , name: data.name, alias: data.alias,
            ip: data.network.ip || '', online: (data.online === true ? 'online' : 'offline'), screen: (data.screen === 'on' ? 'screenOn': 'screenOff'),snapshot:data.snapshot}));
        var image = new Image();
        image.onload = function() {
            if(image.width > image.height) {
                that.$el.find('.imageBox').children().attr('width','100%');
            } else {
                that.$el.find('.imageBox').children().attr('height','100%');
            }
        }
        image.onerror = function() {
            that.$el.find('.imageBox').children().attr('width','100%');
            that.$el.find('.imageBox').children().attr('height','100%');
        }
        image.src = 'data:image/png;base64,' + data.snapshot;
        return this;
    },
    showOperation: function() {
        if($('#boxListBtn').hasClass('btn-primary')) {
            $(this.el).find('.name').parent().removeClass("col-xs-10").addClass("col-xs-5");
            $(this.el).find('.operation').show();
        }

    },

    hideOperation: function() {
        if($('#boxListBtn').hasClass('btn-primary')) {
            $(this.el).find('.name').parent().removeClass("col-xs-5").addClass("col-xs-10");
            $(this.el).find('.operation').hide();
        }

    },

    loadBasicSetting: function() {
        var data = this.model.toJSON();
        timeSettings.reset();
        $('.nameSettingDiv').show();
        $('#nameSettingInput').val(data.name);
        $('#aliasSettingInput').val(data.alias);
        $('#debugSetting').val(data.debug);
        $('#timeSetting').empty();
        for(var i = 0; i < data.auto_screen.length ; i++) {
            var obj = {from:data.auto_screen[i].from,
                to:data.auto_screen[i].to,
                week:data.auto_screen[i].week
            }
            var timeSetting = new TimeSetting(obj);
            timeSetting.set({id:timeSetting.cid});
            timeSettings.add(timeSetting);
            var timeSettingItemView = new TimeSettingItemView({model:timeSetting});
            $('#timeSetting').append(timeSettingItemView.render().el);

        }
        $('#auto_snapshot').val(data.auto_snapshot);
        $('#interval').val(data.interval);
        $('#basicSettingModal').attr('boxId',data.id);
        $('#basicSettingModal').prop('isBoxes',false);
        $('#basicSettingModal').modal('show');
    },

    loadNetSetting: function() {
        var data = this.model.toJSON();
        $('#serviceInput').val(data.service);
        $('#maskInput').val(data.network.mask);
        $('#ipInput').val(data.network.ip);
        $('#gwInput').val(data.network.gw);
        // ToDo load data
        $('#netSettingModal').attr('boxId',data.id);
        $('#netSettingModal').prop('isBoxes',false);
        $('.netBoxes').show();
        $('#netSettingModal').modal('show');
    },

    detail: function() {
        var data = this.model.toJSON();
        $('#boxSchedule').empty();
        $('#boxSchedule').hide();
        $('#boxName').html(data.name.cutString(15,true)).attr('title',data.name);
        $('#boxAlias').html(data.alias.cutString(15,true)).attr('title',data.alias);
        $('#boxOs').html(data.os.cutString(15,true)).attr('title',data.os);
        $('#boxVersionCode').html(data.version.code || '');//.cutString(15,true)).attr('title',(data.version.code || ''));
        $('#boxVersionName').html((data.version.name || '').cutString(15,true)).attr('title',(data.version.code || ''));;
        $('#boxDsmversionCode').html(data.dsmversion.code || '');//.cutString(15,true)).attr('title',(data.dsmversion.code || ''));
        $('#boxDsmversionName').html((data.dsmversion.name || '').cutString(15,true)).attr('title',(data.dsmversion.name || ''));
        $('#boxBoot').html(data.boot.cutString(15,true)).attr('title',data.boot);
        $('#boxService').html(data.service.cutString(15,true)).attr('title',data.service);
        $('#boxIP').html((data.network.ip || '').cutString(15,true)).attr('title',(data.network.ip || ''));
        $('#boxMAC').html((data.network.mac || '').cutString(15,true)).attr('title',(data.network.mac || ''));
        $('#boxMASK').html((data.network.mask || '').cutString(15,true)).attr('title',(data.network.mask || ''));;
        $('#boxGW').html((data.network.gw || '').cutString(15,true)).attr('title',(data.network.gw || ''));;;
        $('#boxInterval').html(data.interval.cutString(15,true)).attr('title',data.interval);
        $('#boxAuto_snapshot').html(data.auto_snapshot.cutString(15,true)).attr('title',data.auto_snapshot);
        $('#boxDisk').html(data.disk.cutString(15,true)).attr('title',data.disk);
        $('#boxPixel').html(data.pixel.cutString(15,true)).attr('title',data.pixel);
        $('#boxCpu').html(data.cpu.cutString(15,true)).attr('title',data.cpu);
        $('#boxMemory').html(data.memory.cutString(15,true)).attr('title',data.memory);
        $('#boxScreen').html(data.screen.cutString(15,true)).attr('title',data.screen);
        $('#snapshot').attr('src','data:image/png;base64,' + data.snapshot);
//        $('#snapshot').attr('src','/images/test1.jpg' );
        var image = new Image();
        image.onload = function() {
            if(image.width > image.height) {
                $('#snapshot').attr('width','100%');
                $('#snapshot').attr('height','');
            } else {
                $('#snapshot').attr('width','');
                $('#snapshot').attr('height','100%');
            }
        }
        image.onerror = function() {
            $('#snapshot').attr('width','100%');
            $('#snapshot').attr('height','100%');
        }
//        image.src = '/images/test1.jpg';
        image.src = 'data:image/png;base64,' + data.snapshot;
        if(data.os.toLowerCase().indexOf('android') > -1 ) {
            $(".boxDsmversion").show();
        } else {
            $(".boxDsmversion").hide();
        }
//        var tmpBoxSchedule = {id:111,name:'333',download:80,downloadStatus:9,playStatus:9};
//        data.schedule.push(tmpBoxSchedule);  //-
////        alert(data.schedule.length) //-
        if(data.schedule.length > 0) {
            $("#boxScheduleBtn").show();
            for(var i =0;i<data.schedule.length;i++) {
                var boxScheduleView = new BoxScheduleView({model:data.schedule[i]});
                $('#boxSchedule').append(boxScheduleView.render().el);
            }
        } else {
            $("#boxScheduleBtn").hide();
        }
        $('#boxDetail').modal('show');
    },


    clear: function() {
        if(confirm("确认删除吗？")) {
            this.model.destroy();
            return this;
        }

    },

    outOfGroup: function() {
        var groupId = $('#group-list-index').val();

        if(groupId === 'all') return;
        else {
            var that = this;
            var boxId = $(this.el).find('.boxChk').val();
            var tmpGroup = groups.get(groupId);
            var data = tmpGroup.toJSON();
            data.boxes = _.without(data.boxes,boxId);
            tmpGroup.save(data).done(function(a,b,c){
                that.$el.remove();
            }).error(function(model, jqXHR, o){
                    if(jqXHR.status === 400) {
                        alert('未知错误，请联系管理员')
                    }

                });
        }
        // ToDo remove this box out of group
    }
});


/** boxesView **/
BoxesView = Backbone.View.extend({
    el: '#box',
//    selectTemplate:_.template($('#groupSelect-template').html()),
    events: {
        'click #createBtn': function() {$('#boxCreate').modal('show');},
        'click #createBox': 'createBox',
        'click #deleteBoxes': 'deleteBoxes',
        'click #createGroupModal': 'createGroupModal',
        'click #createGroup': 'createGroup',
        'click #deleteGroupModal': 'deleteGroupModal',
        'click #deleteGroups': 'deleteGroups',
        'click #addToGroupModal': 'addToGroupModal',
        'click #addToGroup': 'addToGroup',
        'click #boxesOutOfGroup': 'boxesOutOfGroup',
        'click #nameBtnGroupEdit': 'nameGroupEdit',
        'click #loadBasicSettings': 'loadBasicSettings',
        'click #saveBasicSetting': 'saveBasicSetting',
        'click #loadNetSettings': 'loadNetSettings',
        'click #saveNetSetting': 'saveNetSetting',
        'click #boxScheduleBtn': 'showBoxSchedule',
        'click #allBoxes': 'selectAll',
        'click .boxChk': 'selectOne',
        'click #allGroups': 'selectAllGroups',
        'change #group-list-index':'renderGroupBoxes',
        'click .groupChk': 'selectOneGroup',
        'click .sortByName': 'sortByName',
        'click .sortByAlias': 'sortByAlias',
        'click .sortByOnline': 'sortByOnline',
        'click .sortByScreen': 'sortByScreen',
        'input #searchInput': 'searchBoxes',
        'prototypechange #searchInput': 'searchBoxes',
        'click #boxListBtn': 'boxList',
        'click #boxViewBtn': 'boxView',
        'click #snapshotCommand': 'sendSnapshot',
        'click #screenOnCommand': 'sendScreenOn',
        'click #screenOffCommand': 'sendScreenOff',
        'click #powerOnCommand': 'sendPowerOn',
        'click #powerOffCommand': 'sendPowerOff',
        'click #rebootCommand': 'sendReboot',
        'click #resetCommand': 'sendReset'
    },
    boxList:function() {
        if(!$('#boxListBtn').hasClass('btn-primary')) {
            $('.showOnList').show();
            $('#searchInput').val('');
            $('#boxListBtn').removeClass('btn-default').addClass('btn-primary')
        }
        $('#boxViewBtn').removeClass('btn-primary').addClass('btn-default');
        this.renderToggle();
    },
    boxView:function() {
        if(!$('#boxViewBtn').hasClass('btn-primary')) {
            $('.showOnList').hide();
            $('#searchInput').val('');
            $('#boxViewBtn').removeClass('btn-default').addClass('btn-primary');
        }
        $('#boxListBtn').removeClass('btn-primary').addClass('btn-default');
        this.renderToggle();
    },
    renderToggle:function() {

        var query = $('#searchInput').val().trim();
        var sortColNname = $('#box-list').find('.caret:visible').attr('sortColName') ?
            $('#box-list').find('.caret:visible').attr('sortColName') : 'name';
        var tmpBoxes = boxes.sortBy(function (box) {
            return box.get(sortColNname);
        });
        if(query !== '') {
            tmpBoxes = tmpBoxes.filter(function(box) {
                return box.toJSON().name.indexOf(query) > -1 || box.toJSON().alias.indexOf(query) > -1;
            });
        } else {
            tmpBoxes = tmpBoxes.filter(function(box) {
                return true;
            });
        }
        var groupId = $('#group-list-index').val();
        if(groupId !== 'all') {
            var tmpGroup = groups.get(groupId);
            var tmpBoxIds = tmpGroup.toJSON().boxes;
            var tmpBoxes = boxes.filter(function(box){
                return _.contains(tmpBoxIds,box.toJSON().id);
            });
        } else {
            var tmpBoxes = boxes.filter(function(){
                return true;
            });
        }
        this.render(tmpBoxes);
    },
    initialize: function() {

        this.listenTo(boxes, 'add', this.addOne);
        this.listenTo(groups, 'remove', this.renderGroupBoxes);
        var that = this;
        boxes.fetch();
        if($("#group-list-index").length>0) {
            groups.fetch().done(function() {
                var tmpGroups = groups.filter(function(){
                    return true;
                });
                that.renderGroup(tmpGroups);
            });
        }

    },
    sortByName:function() {
        this.sortBy('Name');
    },
    sortByAlias:function() {
        this.sortBy('Alias');
    },

    sortByOnline:function() {
        this.sortBy('Online');
    },
    sortByScreen:function() {
        this.sortBy('Screen');
    },
    sortBy: function(sortColNname) {
        var taget ='.sortBy'+sortColNname;
        $(taget).find('.caret').show();
        $(taget).siblings().removeClass('dropup').find('.caret').hide();
        if(!$(taget).hasClass('dropup')) {
            $(taget).addClass('dropup');
        } else {
            $(taget).removeClass('dropup');
        }
        var tmpBoxes = boxes.sortBy(function (box) {
            return box.get(sortColNname.toLowerCase());
        });



        var query = $('#searchInput').val().trim();
        if(query !== '') {
            tmpBoxes = tmpBoxes.filter(function(box) {
                return box.toJSON().name.indexOf(query) > -1 || box.toJSON().alias.indexOf(query) > -1;
            });
        } else {
            tmpBoxes = tmpBoxes.filter(function() {
                return true;
            });
        }
        var groupId = $('#group-list-index').val();
        if(groupId !== 'all') {
            var tmpGroup = groups.get(groupId);
            var tmpBoxIds = tmpGroup.toJSON().boxes;
            tmpBoxes = tmpBoxes.filter(function(box){
                return _.contains(tmpBoxIds,box.toJSON().id);
            });
        } else {
            tmpBoxes = tmpBoxes.filter(function(){
                return true;
            });
        }

        this.render(tmpBoxes);
        $('#allBoxes').prop('checked',false);
    },
    searchBoxes:function() {
        var query = $('#searchInput').val().trim();
        var sortColNname = $('#box-list').find('.caret:visible').attr('sortColName') ?
            $('#box-list').find('.caret:visible').attr('sortColName') : 'name';
        var tmpBoxes = boxes.sortBy(function (box) {
            return box.get(sortColNname);
        });
        if(query !== '') {
            tmpBoxes = tmpBoxes.filter(function(box) {
                return box.toJSON().name.indexOf(query) > -1 || box.toJSON().alias.indexOf(query) > -1;
//                    || box.toJSON().network.ip.indexOf(query) > -1;;
//                return box.toJSON().name.indexOf(query) > -1 || box.toJSON().children[0].name.indexOf(query) > -1;
            });
        } else {
//            $('#group-list-index').val('all');
            tmpBoxes = tmpBoxes.filter(function(box) {
                return true;
            });
        }

        var groupId = $('#group-list-index').val();
        if(groupId !== 'all') {
            var tmpGroup = groups.get(groupId);
            var tmpBoxIds = tmpGroup.toJSON().boxes;
            tmpBoxes = tmpBoxes.filter(function(box){
                return _.contains(tmpBoxIds,box.toJSON().id);
            });
        } else {
            tmpBoxes = tmpBoxes.filter(function(){
                return true;
            });
        }
        this.render(tmpBoxes);
        $('#allBoxes').prop('checked',false);

    },

    render: function(tmpBoxes) {
        $('#box-list').children('tbody').empty();
        $('#box-view').empty();
        var $sortFlag = $('#box-list').find('.caret:visible').parents('.sortBy').hasClass('dropup');
        if(!$sortFlag) {
            this.renderDesc(tmpBoxes);
        } else {
            this.renderAsc(tmpBoxes);
        }
        var groupId = $('#group-list-index').val();
        if(groupId === 'all') {
            $('.outOfGroup').hide();
            $('.boxesOutOfGroup').hide();
        } else {
            $('.outOfGroup').show();
            $('.boxesOutOfGroup').show();
        }
        $('#allBoxes').prop('checked', false);

    },
    renderAsc:function(tmpBoxes) {
        if($('#boxListBtn').hasClass('btn-primary')) {
            $.each(tmpBoxes, function(i, o) {
                var view = new BoxView({model: o});
                $('#box-list').children('tbody').append(view.render().el);

            })
        } else {
            $.each(tmpBoxes, function(i, o) {
                var view = new BoxView({model: o});
                $('#box-view').append(view.renderView().el);

            })
        }

    },
    renderDesc:function(tmpBoxes) {
        if($('#boxListBtn').hasClass('btn-primary')) {
            $.each(tmpBoxes, function(i, o) {
                var view = new BoxView({model: o});
                $('#box-list').children('tbody').prepend(view.render().el);
            })
        } else {
            $.each(tmpBoxes, function(i, o) {
                var view = new BoxView({model: o});
                $('#box-view').prepend(view.renderView().el);
            })

        }

    },
    renderGroupBoxes:function() {
      var groupId = $('#group-list-index').val();
      $('#searchInput').val('');
      if(groupId !== 'all') {
          var tmpGroup = groups.get(groupId);
          var tmpBoxIds = tmpGroup.toJSON().boxes;
          var tmpBoxes = boxes.filter(function(box){
              return _.contains(tmpBoxIds,box.toJSON().id);
          });
      } else {
          var tmpBoxes = boxes.filter(function(){
              return true;
          });
      }
      this.render(tmpBoxes);
//      $('#allBoxes').prop('checked', false);
    },
    renderGroup:function(tmpGroups) {
        var that = this;
        $.each(tmpGroups, function(i, o) {
            var view = new GroupView({model:o});
            var groupSelectViewIndex = new GroupSelectView({model:o});
            var groupSelectViewAdd = new GroupSelectView({model:o});
            $('#group-list').children('tbody').append(view.render().el);
            $("#group-list-index").append(groupSelectViewIndex.render().el);
            $("#group-list-add").append(groupSelectViewAdd.render().el);
        })
    },
    addOne: function(model, collection) {
        var boxView = new BoxView({model: model});
        this.$("#box-list").prepend(boxView.render().el);
    },
    createBox: function() {
        var that  = this;
        var data = {};
        var createName = $('#nameInputCreate'),
            createAlias = $('#aliasInputCreate');
        data.name = createName.val().trim();
        data.alias = createAlias.val().trim();
        if(data.name === '') return popBy('#nameInputCreate',false,'设备ID不能为空');
        else if(data.name.getRealLength() > 40) return popBy('#nameInputCreate',false,'设备ID长度不能超过40字节');
        var reg = /^[a-zA-Z0-9\_\-]+$/ig;
        if(!data.name.match(reg)) return popBy('#nameInputCreate',false,'设备ID只能为数字、英文、下划线和减号');
        var validateName = validatePublicName(data.alias);
        var message = '名称' +  validateName.message;
        if(!validateName.status) return popBy('#aliasInputCreate',false,message);
        boxes.create(data, {
            success: function(model, json, jqXHR) {
                $("#group-list-index").val('all');
                that.renderGroupBoxes();
                $('#boxCreate').modal('hide');
                createName.val('');
                createAlias.val('');
            },
            error: function(model, jqXHR, o) {
                boxes.remove(model);
                if(jqXHR.status === 409) {
                    return popBy('#createBox',false,'设备已存在，创建失败');
//                    alert('创建失败，相同设备ID的播放器已存在')
                } else {
                    alert('未知错误，请联系管理员');
                }
            }
        });
        return this;
    },

    deleteBoxes: function() {
        // ToDo get selected boxes and delete them

        var $ids = [];
        $(".boxChk:checked").each(function(i, o) {
            $ids.push($(o).val());
        })
        if($ids.length == 0) return popBy("#deleteBoxes", false, '请先选择您要删除的播放器');
        models = [];
        $.each($ids,function(i,o) {
            models.push(boxes.get(o));
        });
        if(confirm("确认删除吗？")) {
            $.ajax({
                type: "DELETE",
                url: "/devices",
                data: JSON.stringify($ids),
                contentType: "application/json; charset=utf-8"
            }).done(function (jqXHR) {
                boxes.remove(models);
                $(".boxChk:checked").parents('tr').remove();
                $('#allBoxes').prop('checked',false);
            }).fail(function(a,b,c) {
                console.log('error',a,b,c);
            });
        }
    },

    createGroupModal: function() {
        var $ids = [];
        $(".boxChk:checked").each(function(i, o) {
            $ids.push($(o).val());
        })
        if($ids.length == 0) return popBy("#createGroupModal", false, '请先选择您要加入分组的播放器');
        $('#groupCreateModal').modal('show');

        // ToDo get the group name and validate it to be unique, then post /group
    },
    createGroup:function() {
        var that = this;
        var data = {};
        var $ids = [];
        $(".boxChk:checked").each(function(i, o) {
            $ids.push($(o).val());
        })
        data.name = $('#groupInputCreate').val().trim();
        data.boxes = $ids;
        data.owner = $.cookie('token');
        if(data.name === '') return popBy('#groupInputCreate',false,'分组名不能为空');
        var validateName = validatePublicName(data.name);
        var message = '组名' +  validateName.message;
        if(!validateName.status) return popBy('#groupInputCreate',false,message);
        groups.create(data, {
            success: function(model, json, jqXHR) {
                $('#groupCreateModal').modal('hide');
                var view = new GroupView({model:model});
                var groupSelectViewIndex = new GroupSelectView({model:model});
                var groupSelectViewAdd = new GroupSelectView({model:model});
                $('#group-list').children('tbody').append(view.render().el);
                $("#group-list-index").append(groupSelectViewIndex.render().el);
                $("#group-list-add").append(groupSelectViewAdd.render().el);
                $('#groupInputCreate').val('');
                $('#group-list-index').val(model.toJSON().id);
                that.renderGroupBoxes();
            },
            error: function(model, jqXHR, o) {
                boxes.remove(model);
                if(jqXHR.status === 409) {
                    return popBy("#groupInputCreate",false,"分组名已存在");
                } else {
                    alert('未知错误，请联系管理员');
                }
            }
        });
    },
    deleteGroupModal:function() {

        $('#groupDeleteModal').modal('show');
    },
    deleteGroups:function() {
        var that = this;
        var $ids = [];
        $(".groupChk:checked").each(function(i, o) {
            $ids.push($(o).val());
        })
        if($ids.length == 0) return  $('#groupDeleteModal').modal('hide');
        models = [];
        $.each($ids,function(i,o) {
            models.push(groups.get(o));
        });
        if(confirm("确认删除吗？")) {
            $.ajax({
                type: "DELETE",
                url: "/groups",
                data: JSON.stringify($ids),
                contentType: "application/json; charset=utf-8"
            }).done(function (jqXHR) {
                    groups.remove(models);
//                    $('#groupDeleteModal').modal('hide');
                    $('#allGroups').prop('checked',false);
                    that.renderGroupBoxes();

                }).fail(function(a,b,c) {
                    console.log('error',a,b,c);
                });
        }

    },
    addToGroupModal:function() {
        var $ids = [];
        $(".boxChk:checked").each(function(i, o) {
            $ids.push($(o).val());
        })
        if($ids.length == 0) return popBy("#addToGroupModal", false, '请先选择您要加入分组的播放器');
        models = [];
        $.each($ids,function(i,o) {
            models.push(boxes.get(o));
        });
        $('#groupAddModal').modal('show');
    },
    addToGroup:function() {
        var that = this;
        var groupid = $('#group-list-add').val();
        var tmpGroup = groups.get(groupid);
        var data = tmpGroup.toJSON();
        var $ids = [];
        $(".boxChk:checked").each(function(i, o) {
            $ids.push($(o).val());

        })
        data.boxes = _.union($ids, data.boxes);
        tmpGroup.save(data).done(function(a,b,c){
            $('#groupAddModal').modal('hide');
            $('#group-list-index').val(groupid);
            that.renderGroupBoxes();
        }).error(function(model, jqXHR, o){
                if(jqXHR.status === 400) {
                    alert('未知错误，请联系管理员')
                }

            });
    },
    boxesOutOfGroup:function() {
        var groupId = $('#group-list-index').val();
        if(groupId === 'all') return;
        else {
            var ids = [];
            $(".boxChk:checked").each(function(i, o) {
                ids.push($(o).val());
            })
            if(ids.length == 0) return popBy("#boxesOutOfGroup", false, '请先选择您要移出分组的播放器');
            else {
                var that = this;
                var tmpGroup = groups.get(groupId);
                var data = tmpGroup.toJSON();
                data.boxes = _.difference(data.boxes,ids);
                tmpGroup.save(data).done(function(a,b,c){
                    $('.boxChk:checked').parent().parent().parent().remove();
                }).error(function(model, jqXHR, o){
                        if(jqXHR.status === 400) {
                            alert('未知错误，请联系管理员')
                        }

                    });
            }
        }
    },
    nameGroupEdit:function() {
        var id = $('#groupNameEditModal').prop('groupId');
        var tmpGroupName = $('#nameInputGroupEdit').val().trim();
        var oldName = $('#groupNameEditModal').prop('oldName');
        if(oldName === tmpGroupName) return $('#groupNameEditModal').modal('hide');
        if(tmpGroupName === '') return popBy('#nameInputGroupEdit',false,'分组名不能为空');
//        var reg = /^[a-zA-Z0-9_\-\u4e00-\u9fa5]+$/ig;
        var validateName = validatePublicName(tmpGroupName);
        var message = '分组名' +  validateName.message;
        if(!validateName.status) return popBy('#nameInputGroupEdit',false,message);
//        if(!tmpGroupName.match(reg)) return popBy('#nameInputGroupEdit',false,'组名只能为数字、中英文、下划线和中划线');
        var tmpGroup = groups.get(id);
        tmpGroup.save({name:tmpGroupName}).done(function(a,b,c){
            $('#groupNameEditModal').modal('hide');
        }).error(function(jqXHR,o, status){
                tmpGroup.set({name:oldName});
                if(jqXHR.status === 409) {
                    return popBy("#nameInputGroupEdit",false,"分组名已存在");
                } else {
                        alert('未知错误，请联系管理员')
                    }

                });
    },
    loadBasicSettings: function() {
        var $ids = [];
        $(".boxChk:checked").each(function(i, o) {
            $ids.push($(o).val());
        })
        if($ids.length == 0) return popBy("#loadBasicSettings", false, '请先选择您要设置的播放器');
        timeSettings.reset();
        $('.nameSettingDiv').hide();
        $('#aliasSettingInput').val('');
        $('#debugSetting').val('0');
        $('#timeSetting').empty();
        $('#auto_snapshot').val('60');
        $('#interval').val('30');
        $('#basicSettingModal').prop('isBoxes',true);


        $('#basicSettingModal').modal('show');
    },

    saveBasicSetting: function() {
        var isBoxes =  $("#basicSettingModal").prop('isBoxes');
        var data = {};
        var tmpauto_screen = [];
        var weekdays =$("#timeSetting").children('div');
        var flag = true;
        $.each(weekdays,function(i,o) {
            var tmpauto_screenItem = {};
            var tmpweek = '0'
            var count = 0;
            var weekItem = $(o).find('.weekItem').children('.weekday');
            var timeItem = $(o).find('.timeItem');
            $.each(weekItem,function(i,o){
                if($(o).hasClass('btn-primary')) {
                    tmpweek = tmpweek + '1';
                    count ++;
                } else {
                    tmpweek = tmpweek + '0';
                }
            });
            if(timeItem.children('input').first().val() === '' ||
                timeItem.children('input').last().val() === '' ||
                tmpweek === '00000000') return flag = false;
            tmpauto_screenItem.from = timeItem.children('input').first().val();
            tmpauto_screenItem.to = timeItem.children('input').last().val();
            tmpauto_screenItem.week = tmpweek;
            tmpauto_screen.push(tmpauto_screenItem);
        });
        if(!flag) return popBy('#saveBasicSetting',flag,'显示时间设置不完整');
        data.alias = $('#aliasSettingInput').val().trim();
        var validateName = validatePublicName(data.alias);
        var message = '名称' +  validateName.message;
        if(!validateName.status) return popBy('#saveBasicSetting',false,message);
        data.debug = $('#debugSetting').val();
        data.auto_snapshot = $('#auto_snapshot').val().trim();
        data.interval = $('#interval').val().trim();
        data.auto_screen = tmpauto_screen;
        var int_auto_snapshot = parseInt(data.auto_snapshot);
        var int_interval = parseInt(data.interval);
        var regNumber = /^\d+$/
        if(!regNumber.test(data.auto_snapshot)) return popBy('#auto_snapshot',false,'截屏周期格式不对');
        else if(!(int_auto_snapshot >= 60 && int_auto_snapshot <= 300) && !(int_auto_snapshot === 0)) return popBy('#auto_snapshot',false,'截屏周期必须大于60小于300秒或等于0(不截屏)');
        if(!regNumber.test(data.interval)) return popBy('#interval',false,'更新周期格式不对');
        else if(int_interval < 30 || int_interval > 150) return popBy('#interval',false,'更新周期必须大于30小于150秒');
        if(isBoxes) {
            putDate = _.pick(data, 'debug', 'auto_snapshot', 'interval', 'auto_screen');
            var $ids = [];
            $(".boxChk:checked").each(function(i, o) {
                $ids.push($(o).val());
            })
            if(confirm("确认批量修改吗？")) {
                $.ajax({
                    type: "put",
                    url: "/devices",
                    data: JSON.stringify({ids:$ids,data:putDate}),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (json) {
                        if(json.status === 'success') {
                            $.each($ids,function(i,o) {
                                boxes.get(o).set(putDate);
                            })
                            $('#basicSettingModal').modal('hide');
                            $('#allBoxes').prop('checked', false);
                            $(".boxChk:checked").prop('checked', false);
                        }
                    },
                    error: function (err) {
                        alert(err.responseText)
                    }
                });
            }

        } else {
            var id = $("#basicSettingModal").attr('boxId');
            boxes.get(id).save(data).done(function(json,status,jqXHR) {
                $('#basicSettingModal').modal('hide');
                $('#allBoxes').prop('checked', false);
                $(".boxChk:checked").prop('checked', false);
            }).fail(function() {
                    alert('xxxx');
                });
        }
    },

    loadNetSettings: function() {
        var $ids = [];
        $(".boxChk:checked").each(function(i, o) {
            $ids.push($(o).val());
        })
        if($ids.length == 0) return popBy("#loadNetSettings", false, '请先选择您要设置的播放器');
        $('#serviceInput').val('');
        $('#maskInput').val('');
        $('#ipInput').val('');
        $('#gwInput').val('');
        $('.netBoxes').hide();
        $('#netSettingModal').prop('isBoxes',true);
        $('#netSettingModal').modal('show');
    },

    saveNetSetting: function() {

        var isBoxes =  $("#netSettingModal").prop('isBoxes');
        var data = {},
            network = {};
        data.service = $('#serviceInput').val().trim();


        var regNet = /^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])$/;
        if( data.service === '')  return popBy('#serviceInput',false,'服务器地址不能为空');
        var strRegex = "^((https|http|ftp|rtsp|mms)?://)"
            + "?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?" //ftp的user@
            + "(([0-9]{1,3}.){3}[0-9]{1,3}" // IP形式的URL- 199.194.52.184
            + "|" // 允许IP和DOMAIN（域名）
            + "([0-9a-z_!~*'()-]+.)*" // 域名- www.
            + "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]." // 二级域名
            + "[a-z]{2,6})" // first level domain- .com or .museum
            + "(:[0-9]{1,5})?" // 端口- :80
            + "((/?)|" // a slash isn't required if there is no file name
            + "(/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+/?)$";
        var re=new RegExp(strRegex);
        if(!re.test(data.service)) return popBy('#serviceInput',false,'服务器地址格式错误');
        if(isBoxes) {
            var $ids = [];
            $(".boxChk:checked").each(function(i, o) {
                $ids.push($(o).val());
            })
            if(confirm("确认批量修改吗？")) {
                $.ajax({
                    type: "put",
                    url: "/devices",
                    data: JSON.stringify({ids:$ids,data:data}),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (json) {
                        if(json.status === 'success') {
                            $.each($ids,function(i,o) {
                                boxes.get(o).set(data);
                            })
                            $('#netSettingModal').modal('hide');
                            $('#allBoxes').prop('checked', false);
                            $(".boxChk:checked").prop('checked', false);
                        }
                    },
                    error: function (err) {
                        alert(err.responseText)
                    }
                });
            }

        } else {
            data.network = network;
            network.ip = $('#ipInput').val().trim();
            network.mask = $('#maskInput').val().trim();
            network.gw = $('#gwInput').val().trim();
            if(!regNet.test(network.ip) || network.ip === '')  return popBy('#ipInput',false,'IP地址格式错误');
            if(!regNet.test(network.mask ) || network.mask === '')  return popBy('#maskInput',false,'子网掩码格式错误');
            if(!regNet.test(network.gw) || network.gw === '')  return popBy('#gwInput',false,'网关格式错误');
            var id = $("#netSettingModal").attr('boxId');
            boxes.get(id).save(data).done(function(json, status, jqXHR) {
                $('#netSettingModal').modal('hide');
                $('#allBoxes').prop('checked', false);
                $(".boxChk:checked").prop('checked', false);
                // ToDo clear the data of this modal
            }).fail(function(a,b,c) {
                    console.log(a,b,c);
                });
        }
    },
    showBoxSchedule:function() {
        $('#boxSchedule').show();
        $('#boxScheduleBtn').hide();
    },

    selectAll: function(e) {
        if($('#allBoxes:checked').length > 0) {
            $('.boxChk').prop('checked', true);
        } else {
            $('.boxChk').prop('checked', false);
        }
        if (e && e.stopPropagation) {
            //支持W3C
            e.stopPropagation();
        }
        else {
            //IE的方式
            window.event.cancelBubble = true;
        }
    },

    selectOne: function(e) {
        if($(".boxChk:checked").length === $('.boxChk').length) {
            $('#allBoxes').prop('checked', true);
        } else {
            $('#allBoxes').prop('checked', false);
        }
    },
    selectAllGroups:function(e) {
        if($('#allGroups:checked').length > 0) {
            $('.groupChk').prop('checked', true);
        } else {
            $('.groupChk').prop('checked', false);
        }
        if (e && e.stopPropagation) {
            //支持W3C
            e.stopPropagation();
        }
        else {
            //IE的方式
            window.event.cancelBubble = true;
        }
    },
    selectOneGroup:function(e) {
        if($(".groupChk:checked").length === $('.groupChk').length) {
            $('#allGroups').prop('checked', true);
        } else {
            $('#allGroups').prop('checked', false);
        }
    },
    sendCommand: function(command) {
        var ids = [];
        var content = {};
        $(".boxChk:checked").each(function(i, o) {
            ids.push($(o).val());
        })
        content = {command: command, boxes: ids};
        var msg = command == 'startup'?'开机命令仅适用于windows播放器，确认发送命令吗？':'确认发送命令吗？';
        if(confirm(msg)) {
            $.ajax({
                type: "PUT",
                url: "/command",
                data: JSON.stringify(content),
                contentType: "text/html; charset=utf-8"
            }).done(function (jqXHR) {
                $(".boxChk:checked").prop('checked', false);
                $('#allBoxes').prop('checked',false);
                alert('命令已发送');
            }).fail(function(a,b,c) {
                console.log('error',a,b,c);
            });
        }
    },

    sendSnapshot: function(e) {
        if($(".boxChk:checked").length == 0) return popBy("#snapshotCommand", false, '请先选择您要控制的播放器');
        this.sendCommand('snapshot');
    },
    sendScreenOn: function(e) {
        if($(".boxChk:checked").length == 0) return popBy("#screenOnCommand", false, '请先选择您要控制的播放器');
        this.sendCommand('screenon');
    },
    sendScreenOff: function(e) {
        if($(".boxChk:checked").length == 0) return popBy("#screenOffCommand", false, '请先选择您要控制的播放器');
        this.sendCommand('screenoff');
    },
    sendPowerOn: function(e) {
        if($(".boxChk:checked").length == 0) return popBy("#powerOnCommand", false, '请先选择您要控制的播放器');
        this.sendCommand('startup');
    },
    sendPowerOff: function(e) {
        if($(".boxChk:checked").length == 0) return popBy("#powerOffCommand", false, '请先选择您要控制的播放器');
        this.sendCommand('shutdown');
    },
    sendReboot: function(e) {
        if($(".boxChk:checked").length == 0) return popBy("#rebootCommand", false, '请先选择您要控制的播放器');
        this.sendCommand('reboot');
    },
    sendReset: function(e) {
        if($(".boxChk:checked").length == 0) return popBy("#resetCommand", false, '请先选择您要控制的播放器');
        this.sendCommand('reset');
    }

});
var boxesView = new BoxesView;
/** groupView **/

/** groupsView **/

function displaySetting() {
    var timeSetting = new TimeSetting();
    timeSetting.set({id:timeSetting.cid});
    timeSettings.add(timeSetting);
    var timeSettingItemView = new TimeSettingItemView({model:timeSetting});
    $('#timeSetting').append(timeSettingItemView.render().el);

}


/** TimeSetting Model**/
TimeSetting = Backbone.Model.extend({
    defaults: {
        from: '',
        to: '',
        week:"00000000"
    }
});
/** TimeSetting Collection**/
TimeSettings = Backbone.Collection.extend({
    model: TimeSetting
});
var timeSettings = new TimeSettings;
/** TimeSetting View**/
TimeSettingItemView = Backbone.View.extend({
    tagName:'div',
    template: _.template($('#timeSetting-template').html()),
    events:{
        'click .removeTimeSetting': 'removeTimeSetting'

    },
    initialize:function() {

    },
    render:function() {
        var data = this.model.toJSON();
        var btnCLass =[];
        for(var i =1; i < 8;i++) {
            if(data.week[i] === '0') {
                btnCLass[i] = "btn-default";
            } else {
                btnCLass[i] = "btn-primary";
            }
        }
        this.$el.addClass('alert alert-info')
        this.$el.html(this.template({id: data.id , from: data.from, to: data.to,
            btnClass1:btnCLass[1], btnClass2:btnCLass[2], btnClass3:btnCLass[3],
            btnClass4:btnCLass[4], btnClass5:btnCLass[5],btnClass6:btnCLass[6],
            btnClass7:btnCLass[7]}));
        return this;
    },
    
    removeTimeSetting:function() {
        timeSettings.remove(this.model);
        $(this.el).remove();
    }
});


