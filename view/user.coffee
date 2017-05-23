extend "layout"

block 'title', ->
  title '用户'

block 'main', ->


  script type:'text/template', id:'group-template', ->
    td ->

  script type:'text/template', id:'groupSelect-template', ->
  script type:'text/template', id:'timeSetting-template', style: 'display: none', ->
  script type:'text/template', id:'box-template', ->
    td ->
      span class:"col-xs-1 ", ->
        input type:"checkbox",value:"{{id}}", class: 'boxChk'
      div class:"col-xs-10", ->
        span class:"name displayName", title:'{{name}}', -> '{{name}}'
    td ->
      span class:"name displayName", title:'{{alias}}', -> '{{alias}}'

  div id:'user', ->
    div class:"modal fade", id:"modalBoxes", 'tabindex':"-1", 'role':"dialog", 'aria-labelledby':"modalBoxesLabel", 'aria-hidden':"true", ->
      div class:"modal-dialog", ->
        div class:"modal-content", ->
          div class:"modal-header", ->
            button type:"button",class:"close",'data-dismiss':"modal",'aria-hidden':"true", ->
              text '&times;'
            h4 class:"modal-title", id:"modalBoxesLabel", ->
              text '授权'
          div class:"modal-body", ->
            div ->
              div class :"row ", id:'box', ->
                div class: 'panel panel-default', ->
                  table class: 'table table-striped', style:"table-layout:fixed;word-wrap:break-word;", id: 'box-list', ->
                    thead class:"thead-color",->
                      tr ->
                        th class :"col-xs-6",->
                          span class:"col-xs-1 ", ->
                            input type: 'checkbox',id:"allBoxes"
                          div class :"col-xs-10 ", ->
                            span class :" col-xs-7", ->
                              text ' 设备名'
                              b class:"caret ",sortColName:"name",style:"display:none",
                        th class :"col-xs-6",->
                          text '名称'
                          b class:"caret", sortColName:"playlist",style:"display:none",
                    tbody ->
              br ->
            div class:"col-xs-offset-9 diabtnfix ", ->
              button type:"button",  class:"btn btn-primary ",id:"btnAuthorize", ->
                text '确定'
              button type:"button", class:"btn btn-default gap", 'data-dismiss':"modal",->
                text '关闭'

    script type:"text/template", id:"userTemplate", style:"display:none", ->
      td class:"col-xs-4 ",->
        div class:'dropdowm', ->
          span class:"col-xs-1", ->
            input type:"checkbox",value:"{{id}}", class: 'chkUserItem'
          span class:"col-xs-10 sp-Username displayName",title:"{{name}}", -> '{{name}}'
          span class:"col-xs-6  userOper", style:'display:none', ->
            a href:'javascript:void(0)', class: 'deleteUser ',title:'删除',  ->'删除'
#              span class:'glyphicon glyphicon-trash', style:'margin-right:8px'
            a href:'javascript:void(0)', class: 'resetPassword gap',title:'重置密码', ->'重置'
#              span class:'glyphicon glyphicon-wrench', style:'margin-right:8px'
            a href:'javascript:void(0)', class: 'activateUser gap',title:'激活', ->'激活'
#              span class:'glyphicon glyphicon-remove-sign', style:'margin-right:8px'
            a href:'javascript:void(0)', class: 'authorize gap',title:'授权', ->'授权'
#              span class:'glyphicon glyphicon-lock'
#      td class:"usertype col-xs-1", -> '{{type}}'
#      td class:"col-xs-3",-> '{{email}}'
      td class:"col-xs-4", ->
        div class:"col-xs-12", ->
          span class:"userDescription displayName", title:"{{description}}",  ->'{{description}}'

    div class:"modal fade ", id:"createUserModal", 'tabindex':"-1", 'role':"dialog", 'aria-labelledby':"createUserModalLabel", 'aria-hidden':"true", ->
      div class:"modal-dialog", ->
        div class:"modal-content", ->
          div class:"modal-header", ->
            button type:"button",class:"close",'data-dismiss':"modal",'aria-hidden':"true", ->
              text '&times;'
            h4 class:"modal-title", id:"createUserModalLabel", ->
              text '创建用户'
          div class:"modal-body   col-xs-offset-1", ->
            form class:"form-horizontal", id: 'password', style: 'margin-top: 10px', ->
              h2 class:"form-signin-heading", ->
              div class:"form-group", ->
                label for:"nameTxt", class:"col-xs-3 control-label", ->'用户名'
                div class:"col-xs-6", ->
                  input type:"text", class:"form-control ", id:'nameTxt', placeholder:'请输入用户名', ->
              div class:"form-group", ->
                label for:"passwordTxt", class:"col-xs-3 control-label", ->'密码'
                div class:"col-xs-6", ->
                  input type:"password", class:"form-control ", id:'passwordTxt', placeholder:'请输入密码', ->
              div class:"form-group", ->
                label for:"confirmTxt", class:"col-xs-3 control-label", ->'确认密码'
                div class:"col-xs-6", ->
                  input type:"password", class:"form-control ", id:'confirmTxt', placeholder:'请再次输入密码', ->
#              div class:"form-group", ->
#                label for:"emailTxt", class:"col-xs-3 control-label", ->'邮箱'
#                div class:"col-xs-6", ->
#                  input type:"text", class:"form-control ", id:'emailTxt', placeholder:'请输入邮箱', ->
              div class:"form-group", ->
                label for:"txtDescription", class:"col-xs-3 control-label", ->'个人注释'
                div class:"col-xs-6", ->
                  textarea  class:"form-control", id:'txtDescription', placeholder:'请输入个人注释', ->
          div class:"modal-footer",->
            button class:"btn btn-primary  col-xs-offset-6", id:"btnCreateUser", type:"button", ->'创建用户'

            button type:"button", class:"btn btn-default", 'data-dismiss':"modal",->
              text '关闭'

    div class:"well well-sm fix-top-2", ->
      div class :"container fixed-width", ->
        button type:"button", id:'btnShowCreateModal', class:"btn btn-default", ->
          span class:"glyphicon glyphicon-user", ->
          text ' 添加'
        button type:"button", class:"btn btn-default gap",  id:'deleteBtn', ->
          span class:"glyphicon glyphicon-trash", ->
          text ' 删除'
#        button type:"button", class:"btn btn-default gap",  id:'btnShowAuthorize', ->
#          span class:"glyphicon glyphicon-lock", ->
#          text ' 授权'
        div class: 'col-xs-3 input-group pull-right searchPanel', ->
          input type:"text", class:"form-control", id:"searchInput", placeholder:"请输入用户名", ->
          span class: 'input-group-btn', ->
            button type:"submit", class:"btn btn-default", id:"searchBtn", -> '搜索'

    div class: 'container fix-top-2-tablelist-default fixed-width', ->
      h3 class: 'pageInfo', ->
        img src: 'images/header.png',class: 'circlePic', ->
        text '&nbsp用户'
      div class: 'panel panel-default', ->
        table class: 'table table-striped', style:"table-layout:fixed;word-wrap:break-word;", id: 'user-list', ->
          thead class:"thead-color",->
            tr ->
              th class:"col-xs-4 sortByName sortBy", style:'cursor:pointer', ->
                div class:'dropdowm', ->
                  span class:"col-xs-1", ->
                    input type:"checkbox", id:'allUser',->
                  span class:"", ->
                    text '用户名'
                    b class:"caret ",sortColName:"name",style:"display:none",
#              th class:"col-xs-1 sortByType sortBy",  style:'cursor:pointer',->
#                text '类型'
#                b class:"caret ",sortColName:"email",style:"display:none",

#              th class:"col-xs-3 sortByEmail sortBy",  style:'cursor:pointer',->
#                text '邮箱'
#                b class:"caret ",sortColName:"type",style:"display:none",
              th class:"col-xs-4", id:"zlxx", ->'个人注释'
          tbody ->


block 'lazyscript', ->
  script src: '/js/box/model/box.js'
  script src: '/js/box/model/group.js'
  script src: '/js/box/view/index.js'
  script src: '/js/user/model/user.js'
  script src: '/js/user/view/index.js'
  script src: '/js/md5.js'

