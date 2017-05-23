doctype 5
html ->
  head ->
    meta name:"viewport", content="width=device-width, initial-scale=1.0", charset:'utf-8'
    link href:"/css/bootstrap.min.css", rel:"stylesheet"
    link href:"/css/gbvision.css", rel:"stylesheet"
    block 'title', ->
      title 'GBVISION'
    block 'style', ->
    script src:"/js/jquery-1.10.2.js"
    script src:"/js/bootstrap.min.js"
    script src: '/js/moment.js'
    script src:"/js/zh-cn.js"
    script src:"/js/underscore.js"
    script src:"/js/backbone.js"
    script src:"/js/md5.js"
    script src:"/js/scrollhelp.js"
    script src:"/js/gbvision.js"
    script src:"/js/jquery.cookies.js"
    script src:"/js/user/model/user.js"
    script src:"/js/filesize.min.js"
    block 'script', ->

	
  body ->


    div class:"modal fade", id:"modifyPersonalModal", 'tabindex':"-1", 'role':"dialog", 'aria-labelledby':"modifyPersonalModalLabel", 'aria-hidden':"true", ->
      div class:"modal-dialog", ->
        div class:"modal-content", ->
          div class:"modal-header", ->
            button type:"button",class:"close",'data-dismiss':"modal",'aria-hidden':"true", ->
              text '&times;'
            h4 class:"modal-title", id:"modifyPersonalModalLabel", ->
              text '修改个人信息'
          div class:"modal-body col-sm-offset-1", ->
#            form class:"form-horizontal", id: 'email', ->
#              #        h5 class:"modal-title", style:"margin-bottom:10px;", -> '修改邮箱:'
#              div class:"form-group", ->
#                label for:"originalMailTxt", class:"col-sm-3 control-label", ->'原邮箱'
#                div class:"col-sm-6", ->
#                  input type:"text", class:"form-control ", id:"originalMailTxt", placeholder:"原邮箱", disabled:'true',
##                  value:"#{@userInfo.email if @userInfo?.email?}", ->
#              div class:"form-group", ->
#                label for:"newMailTxt", class:"col-sm-3 control-label", ->'新邮箱'
#                div class:"col-sm-6", ->
#                  input type:"text", class:"form-control ", id:"newMailTxt", placeholder:"请输入新邮箱", ->
#              div class:"form-group", ->
#                div class:"col-sm-6 col-sm-offset-3", ->
#                  button type:"button", id:'modifyEmailBtn', class:"btn btn-primary col-sm-offset-8 formConFix", onclick:"modifyEmail()", ->
#                    text '保存修改'
            form class:"form-horizontal", id: 'password', style: 'margin-top: 10px', ->
              #       h5 class:"modal-title", style:"margin-bottom:10px;", -> '修改密码:'
              div class:"form-group", ->
                label for:"originalPasswordTxt", class:"col-sm-3 control-label", ->'原密码'
                div class:"col-sm-6", ->
                  input type:"password", class:"form-control ", id:"originalPasswordTxt", placeholder:"请输入原密码", ->
              div class:"form-group", ->
                label for:"newPasswordTxt", class:"col-sm-3 control-label", ->'新密码'
                div class:"col-sm-6", ->
                  input type:"password", class:"form-control ", id:"newPasswordTxt", placeholder:"请输入新密码", ->
              div class:"form-group", ->
                label for:"comfirmPasswordTxt", class:"col-sm-3 control-label", ->'确认新密码'
                div class:"col-sm-6", ->
                  input type:"password", class:"form-control ", id:"comfirmPasswordTxt", placeholder:"请再次输入新密码", ->
              div class:"form-group", ->
                div class:"col-sm-6 col-sm-offset-3", ->
                  button type:"button", id:'modifyPasswordBtn', class:"btn btn-primary col-sm-offset-8 formConFix", onclick:"modifyPassword()", ->
                    text '保存修改'
            form class:"form-horizontal", id: 'description', style: 'margin-top: 10px', ->
              #      h5 class:"modal-title", style:"margin-bottom:10px;", -> '修改个人注释:'
              div class:"form-group", ->
                label for:"descriptionTxt", class:"col-sm-3 control-label", ->'个人注释'
                div class:"col-sm-6", ->
                  textarea rows:"3", class:"form-control ", id:"descriptionTxt", placeholder:"请输入个人注释", ->
#                    @userInfo.description if @userInfo?.description?
              div class:"form-group", ->
                div class:"col-sm-6 col-sm-offset-3", ->
                  button type:"button",id:'modifyDescriptionBtn',  class:"btn btn-primary col-sm-offset-8",onclick:"modifyDescription()", ->
                    text '保存修改'
          div class:"modal-footer",->
            button type:"button", class:"btn btn-default", 'data-dismiss':"modal",->
              text '关闭'

    div "navbar navbar-inverse navbar-fixed-top ", role:"navigation", ->
      div class:"container", ->
        div class:"navbar-header", ->
          button type:"button", class:"navbar-toggle", 'data-toggle':"collapse", 'data-target':".navbar-collapse", ->
            span class:"sr-only", -> 'Toggle navigation'
            span class:"icon-bar"
            span class:"icon-bar"
            span class:"icon-bar"
          a class:"navbar-brand", href:"#", ->'GBVISION'
        div class:"collapse navbar-collapse",style:"min-width:794px;", ->
#        div class:"collapse navbar-collapse",->
          ul class:"nav navbar-nav", id:'headNav', ->
            li class:"", -> a href:"/index", -> '首页'
            li class:"", -> a href:"/ML", -> '媒体库'
            li class:"", -> a href:'/playlist', -> '播放列表'
            li class:"", -> a href:'/schedule', -> '排期'
            li class:"", -> a href:'/device', -> '播放器'
            li class:"", -> a href:'/task', -> '任务'
            li class:"", -> a href:'/setting', class:'adminauthor', -> '设置'
            li class:"", -> a href:'/user', class:'adminauthor', -> '用户'
            li class:"", -> a href:'/log', class:'adminauthor', -> '日志'
          ul class:"nav navbar-nav navbar-right", ->
            li class:"dropdown", ->
              a href:'javascript:void(0)', class:"dropdown-toggle", 'data-toggle':"dropdown", ->
                b id: "usertype", style:"display:none", -> 'kk'
                b id: "username", -> 'tt'
                coffeescript ->
                  $('#username').html($.cookie('name') or '')
                  $('#usertype').html($.cookie('type') or '')
                b class:"caret"
              ul class:"dropdown-menu", ->
                li ->
#                    a href:'javascript:void(0)', onclick:"modalIputFocus('#modifyPersonalModal', '#newMailTxt')", -> '修改个人信息'
                  a href:'javascript:void(0)', onclick:"modalIputFocus('#modifyPersonalModal', '#newMailTxt')", -> '修改个人信息'
                li class:'divider', ->
                li ->
                  a href:'/logout', -> '退出'
          coffeescript ->

            loc = window.location.href.split('/')
            actived ="/" + loc.pop()

            type = $.cookie('type')

            #当前用户不是管理员
            if(!type or type is 'normal')
              if(actived is '/user' or actived is '/setting' or actived is '/log')
                window.location.href = '/login'
              else
                $('.adminauthor').hide()

            $.each $('.nav li a'), (i,o) ->
              if actived is $(o).attr('href')
                $(o).parent().addClass('active').siblings('li').removeClass('active')
#          div class:"collapse navbar-collapse", id:"bs-example-navbar-collapse-1", ->
#            ul class:"nav navbar-nav navbar-right", ->
#              li class:"dropdown", ->
#                a href:'javascript:void(0)', class:"dropdown-toggle", 'data-toggle':"dropdown", ->
#                  b id: "usertype", style:"display:none", -> 'kk'
#                  b id: "username", -> 'tt'
#                  coffeescript ->
#                    $('#username').html($.cookie('name') or '')
#                    $('#usertype').html($.cookie('type') or '')
#                  b class:"caret"
#                ul class:"dropdown-menu", ->
#                  li ->
##                    a href:'javascript:void(0)', onclick:"modalIputFocus('#modifyPersonalModal', '#newMailTxt')", -> '修改个人信息'
#                    a href:'javascript:void(0)', onclick:"modalIputFocus('#modifyPersonalModal', '#newMailTxt')", -> '修改个人信息'
#                  li class:'divider', ->
#                  li ->
#                    a href:'/logout', -> '退出'
    block 'main', ->

  block 'lazyscript'


