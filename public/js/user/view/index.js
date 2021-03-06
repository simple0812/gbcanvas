var users = new Users;
_.templateSettings = {
    interpolate: /\{\{(.+?)\}\}/g
};

UserView = Backbone.View.extend({
    tagName: 'tr',

    template: _.template($('#userTemplate').html()),

    events: {
        'click .deleteUser': 'deleteUser',
        'mouseover' : 'showOperation',
        'mouseout' : 'hideOperation',
        'click .activateUser':'activate',
        'click .authorize': 'showAuthorizeModal',
        'click .resetPassword': 'resetPassword'
    },

    initialize: function() {
        this.listenTo(this.model, 'destroy', this.remove);var validateName = validatePublicName(name);
        if(!validateName.status) return popBy('#txtRelativePlaylistName', false, '播放列表名称'+validateName.message)
        this.listenTo(this.model, 'remove', this.remove);
        this.listenTo(this.model, 'change', this.render);
    },

    render: function() {
        var data = this.model.toJSON();
        this.$el.html(this.template({id: data.id , name: data.name, type: data.type,
            description: data.description}));

        if(data.activated) {
            this.$el.find('.activateUser').attr('title', '冻结').html('冻结');
//            this.$el.find('.activateUser').attr('title', '冻结').children('span').addClass('glyphicon-remove-sign').removeClass('glyphicon-ok-sign');
        } else {
            this.$el.find('.activateUser').attr('title', '激活').html('激活');
//            this.$el.find('.activateUser').attr('title', '激活').children('span').addClass('glyphicon-ok-sign').removeClass('glyphicon-remove-sign');
        }

        return this;
    },
    showOperation: function() {
        $(this.el).find('.sp-Username').removeClass("col-xs-10").addClass("col-xs-4");
        $(this.el).find('.userOper').show();
    },
    hideOperation: function() {
        $(this.el).find('.sp-Username').removeClass("col-xs-4").addClass("col-xs-10");
        $(this.el).find('.userOper').hide();
    },

    deleteUser:function() {
        var xUser = this.model;
        if(confirm('确认删除吗?')) {
            xUser.destroy().done(function() {
//                this.$el.remove();
                users.remove(xUser);
            }).error(function() {
                alert('未知的错误');
            });
        }
    },

    activate:function() {
        var p = this.$el.find('.activateUser').html()
        if(confirm('确定' + p + '？')) {
            var user = this.model;
            user.set('activated', !(user.get('activated')));
            user.save().done(function() {

            }).error(function() {
                alert('未知的错误');
            })
        }

    },
    showAuthorizeModal:function() {
        var xUser = this.model;
        $('#btnAuthorize').attr('uid', xUser.get('id'));
        if(!xUser.get('activated')) return alert('该用户被禁用，请先激活');

        var promise = $.get('/user/boxes/'+ xUser.get('id'))
            .done(function(boxes) {
                $(".boxChk").prop('checked', false);
                $("#allBoxes").prop('checked', false);


                $(boxes).each(function(i, o) {
                    $(".boxChk[value='" + o.boxId +  "']").prop('checked', true);
                })

                $('#modalBoxes').modal('show');
            })
            .fail(function() {
                alert('未知的错误');
            })
        //var boxes = users.get(xUser.get('id')).get('boxes');

    },

    resetPassword:function() {
        if(confirm('确认重置？')) {
            var pwd = hex_md5('1111');
            var xUser = this.model;

            xUser.set('password', pwd);

            xUser.save()
                .done(function() {
                    alert('重置成功');
                })
                .error(function() {
                    alert('未知错误');
                })
        }
    }
});

UsersView = Backbone.View.extend({
    el: '#user',
    events: {
        'click .sortByName': 'sortByName',
        'click .sortByType': 'sortByType',
        'click #btnShowCreateModal': 'showCreateModal',
        'click #btnCreateUser':'createUser',
        'click #allUser':'selectAllUser',
        'click .chkUserItem': 'selectUserItem',
        'click #deleteBtn':'deleteUsers',
        'click #btnAuthorize':'authorize',
        'input #searchInput': 'searchUsers',
        'prototypechange #searchInput': 'searchUsers'
    },
    sortByName: function() {
        this.sortBy('Name');
    },

    sortByType: function() {
        this.sortBy('Type');
    },
    searchUsers: function() {

        var query = $('#searchInput').val().trim();
        var sortColNname = $('#user').find('.caret:visible').attr('sortColName') ?
            $('#user').find('.caret:visible').attr('sortColName') : 'mtime';
        var xUsers = users.sortBy(function (user) {
            return user.get(sortColNname);
        });

        if(query !== '') {
            xUsers = xUsers.filter(function(user) {
                return user.get('name').indexOf(query) > -1;
            });
            userView.render(xUsers);
        } else {
            xUsers = xUsers.filter(function(user) {
                return true
            });
            userView.render(xUsers);
        }

        $('#allMedias').prop('checked', false);
    },

    showCreateModal: function() {
        $('#createUserModal').modal('show');
    },

    selectAllUser: function(e) {
        $(".chkUserItem").prop('checked', $('#allUser').prop('checked'))
        if (e && e.stopPropagation) {
            //支持W3C
            e.stopPropagation();
        }
        else {
            //IE的方式
            window.event.cancelBubble = true;
        }
    },

    selectUserItem:function() {
        if($(".chkUserItem:checked").length === $('.chkUserItem').length) {
            $('#allUser').prop('checked', true);
        } else {
            $('#allUser').prop('checked', false);
        }
    },

    deleteUsers: function() {
        var ids = []
        $(".chkUserItem:checked").each(function(i, o) {
            ids.push($(o).val());
        });

        if(ids.length == 0) return popBy("#deleteBtn", false, '请先选择需要删除的用户');

        var xUsers = [];
        $.each(ids,function(i, o) {
            xUsers.push(users.get(o));
        });

        if(confirm("确认删除吗？")) {
            $.ajax({
                type: "DELETE",
                url: "/users",
                data: JSON.stringify(ids),
                contentType: "application/json; charset=utf-8"
            }).done(function (jqXHR) {
                    users.remove(xUsers);
                    $(".chkUserItem:checked").parents('tr').remove();
                    $('#allUser').prop('checked', false);
                }).fail(function(a,b,c) {
                    console.log('error',a,b,c);
                });
        }
    },

    createUser: function() {

        var xUser = {};
        var name = $("#nameTxt").val().trim();
        var password = $("#passwordTxt").val().trim();
        var description = $("#txtDescription").val().trim();

        var reg = /[<>]/ig;

        if(!this.validateName() || !this.validatePassword() || !this.confirmPassword() )
            return false;

        if(reg.test(description)) return popBy('#txtDescription', false, '个人描述含有特殊字符<、>');

        xUser.name = name;
        xUser.password = hex_md5(password);
        xUser.description = description;
        xUser.boxes = [];
        xUser.type = 'normal';

        users.create(xUser, {
                wait:true,
                success:function(model, json, jqXHR) {
                    $('#createUserModal').modal('hide');
                    $("#nameTxt").val('');
                    $("#passwordTxt").val('');
                    $("#confirmTxt").val('');
                    $("#txtDescription").val('');
                },
                error: function(model, jqXHR, o) {
                    console.log(jqXHR)
                    if(jqXHR.status === 409) {
                        return popBy('#nameTxt', false, '用户名已存在');
                    }else {
                        alert('未知错误');
                    }

                }
            }
        )
    },

    initialize: function() {
        this.listenTo(users, 'add', this.addOne);
        users.fetch();
    },
    render: function(users) {
        $('#user-list').children('tbody').empty();

        var $sortFlag = $('#user').find('.caret:visible').parents('.sortBy').hasClass('dropup');
        if(!$sortFlag) {
            this.renderDesc(users);
        } else {
            this.renderAsc(users);
        }

    },

    renderAsc:function(users) {
        $.each(users, function(i, o) {
            var view = new UserView({model: o});
            $('#user-list').children('tbody').append(view.render().el);

        })
    },
    renderDesc:function(users) {
        $.each(users, function(i, o) {
            var view = new UserView({model: o});
            $('#user-list').children('tbody').prepend(view.render().el);

        })
    },

    addOne: function(model, collection) {
        var view = new UserView({model:model});
        $('#user-list').children('tbody').append(view.render().el);
    },


    authorize: function() {
        var bids = [];
        var uid = $('#btnAuthorize').attr('uid');

        $('.boxChk:checked').each(function(i, o) {
            bids.push($(o).val());
        });

//        if(bids.length == 0) return popBy('#btnAuthorize', false, '请先选择您要授权的播放器');



        if(confirm('授权用户管理播放器'))
            $.ajax({
                type: "POST",
                url: "/authorize/" + uid,
                data: JSON.stringify(bids),
                contentType: "application/json; charset=utf-8"
            }).done(function (jqXHR) {
                    $('#allUser, .chkUserItem').prop('checked', false);
                    $('#modalBoxes').modal('hide');
                }).fail(function(a,b,c) {
                    console.log('error',a,b,c);
                });
    },

    validateName: function() {
        var $name = $("#nameTxt").val().trim();
        var reg = /^[a-zA-Z0-9_\-]+$/ig;
//        var validateName = validatePublicName($name);
        var $message="";
        var $flag=true;
        if($name === '') {
            $message="用户名不能为空";
            $flag=false;
        }else if($name.getRealLength() < 4 || $name.getRealLength() > 18)
        {
            $message="用户名长度只能为4-18位";
            $flag=false;
        }else if(!$name.match(reg)) {
            $message="用户名只能为英文、数字、下划线和减号"
            $flag=false;
        }
        if(!popBy("#nameTxt",$flag,$message)) return false;
        return true;
    },

    validatePassword: function() {
        var $password = $("#passwordTxt").val().trim();
        var $message="";
        var $flag=true;
        if($password === '') {
            $message="密码不能为空";
            $flag=false;
        }
        else if($password.getRealLength() < 4 || $password.getRealLength() > 18)
        {
            $message="密码长度只能为4-18位";
            $flag=false;
        }

        if(!popBy('#passwordTxt', $flag,$message)) return false;
        return true;

    },

    confirmPassword: function() {
        var $password = $("#passwordTxt").val().trim();
        var $confirm = $("#confirmTxt").val().trim();
        var $message="";
        var $flag=true;
        if($confirm.length == 0) {
            $message="再次输入密码不能为空";
            $flag=false;
        }
        else if($password != $confirm ) {
            $message="两次输入的密码不匹配";
            $flag=false;
        }
        if(!popBy("#confirmTxt",$flag,$message)) return false;
        return true;
    },
    sortBy: function(sortColName) {
        var target ='.sortBy'+sortColName;
        $(target).find('.caret').show();
        $(target).siblings().removeClass('dropup').find('.caret').hide();
        if(!$(target).hasClass('dropup')) {
            $(target).addClass('dropup');
        } else {
            $(target).removeClass('dropup');
        }

        var xUsers = users.sortBy(function (user) {
            return user.get(sortColName.toLowerCase());
        });

        var query = $('#searchInput').val().trim();

        if(query !== '') {
            xUsers = xUsers.filter(function(user) {
                return user.get('name').indexOf(query) > -1;
            });
        } else {
            xUsers = xUsers.filter(function() {
                return true;
            });
        }

        $('#allUser').prop('checked', false);
        this.render(xUsers);
    }
});

userView = new UsersView;


