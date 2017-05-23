doctype 5
html ->
  head ->
    meta name:"viewport", content="width=device-width, initial-scale=1.0", charset:'utf-8'
    link href:"css/bootstrap.min.css", rel:"stylesheet"
    link href:"css/gbvision.css", rel:"stylesheet"
    title 'GBVISION'
    script src:"/js/jquery-1.10.2.js"
    script src:"/js/bootstrap.min.js"
    script src:"/js/underscore.js"
    script src:"/js/backbone.js"
    script src:"/js/md5.js"
    script src:"/js/gbvision.js"


  body style:"height:100%; background-color: #428bca;",->
    div class:"container fixed-width center-block", id:'createUserModal', style:'margin-top:80px;',  ->
      div class:"well center-block", id:"loginPanel", ->
        p class:"text-center", id:'loginLogo', ->'GBVISION'
        div class:"form-horizontal", 'role':"form", ->
          div class:"form-group", ->
            label for:"nameTxt", class:"col-xs-3 control-label", ->'用户名'
            div class:"col-xs-6", ->
              input type:"text", class:"form-control", id:'nameTxt', placeholder:'请输入用户名', ->
          coffeescript ->
            $('#nameTxt').focus()
          div class:"form-group", ->
            label for:"passwordTxt", class:"col-xs-3 control-label", ->'密码'
            div class:"col-xs-6", ->
              input type:"password", class:"form-control ", id:'passwordTxt', placeholder:'请输入密码', ->
          div class:"form-group", ->
            div class:"col-xs-6 col-xs-offset-3", ->
              button class:"btn btn-lg btn-primary col-xs-12 ", id:"loginBtn", onclick:'login()', type:"button", ->'登录'

    div class:"navbar navbar-default  input-group-addon-format navbar-fixed-bottom ", role:"navigation", ->
      div class:"container fixed-width", ->
        a class:"center-block text-center", id:"loginNav", href:"#", ->'© 上海金桥信息股份有限公司 2014'

  coffeescript ->

    @login = ->
      name = $('#nameTxt').val().trim()
      pwd = $('#passwordTxt').val().trim()

      return popBy('#nameTxt', false, '用户名不能为空') if(name == '' )
      return popBy('#nameTxt', false, '用户名长度只能为4－16位') if(name.length > 16 || name.length < 4  )
      return popBy('#passwordTxt', false, '密码不能为空') if(pwd == '')
      return popBy('#passwordTxt', false, '密码长度只能为4－16位') if(pwd.length > 16 || pwd.length < 4 )


      $.ajax
        type: "POST",
        url: "/login"
        data: JSON.stringify({name: name, password: hex_md5(pwd) }),
        contentType: "application/json; charset=utf-8"
      .done (json) ->
        if(json && json.status == 'success') then window.location.href = '/index'
        else popBy('#loginBtn', false, json.result)
      .fail (a,b,c) ->
          console.log('error',a,b,c)

    window.document.onkeydown = (e)->
      e = e || window.event;

      login() if e.keyCode is 13




