extend "layout"
block 'title', ->
  title '排期'
block 'main', ->
  div class:"modal fade", id:"publishModal", 'tabindex':"-1", 'role':"dialog", 'aria-labelledby':"publishPage", 'aria-hidden':"true", ->
    div class:"modal-dialog", ->
      div class:"modal-content", ->
        div class:"modal-header", ->
          button type:"button",class:"close",'data-dismiss':"modal",'aria-hidden':"true", ->
            text '&times;'
          h4 class:"modal-title", id:"publishPage", class:'h3-head', ->
            text '排期发布'
        div class:"modal-body", ->
          div class: 'panel panel-default', ->
            table id: 'group-list', class: 'table table-striped', style:"table-layout:fixed;word-wrap:break-word;", ->
              thead class:"thead-color",->
                tr ->
                  th ->
                    span class:"col-xs-1", ->
                      input type: 'checkbox'
                    div class :"col-xs-9", ->
                      span ->
                        text ' 分组名'
              tbody ->
          div class: 'panel panel-default', ->
            table id: 'box-list', class: 'table table-striped', style:"table-layout:fixed;word-wrap:break-word;", ->
              thead class:"thead-color",->
                tr ->
                  th class :"col-xs-4",->
                    span class:"col-xs-1", ->
                      input type: 'checkbox'
                    div class :"col-xs-9", ->
                      span class :"", ->
                        text ' 设备名'
                  th class :"col-xs-3",->
                    text '名称'
                    b class:"caret", sortColName:"playlist",style:"display:none",
                  th class :"col-xs-3",->
                    text '地址'
                    b class:"caret", sortColName:"playlist",style:"display:none",
                  th class :"col-xs-2",  ->
                    text '在线状态'
                    b class:"caret", sortColName:"playlist",style:"display:none",
              tbody ->

          div class:"col-xs-offset-9 diabtnfix ", ->
            button type:"button",  class:"btn btn-primary ",id:"publishBtn", ->
              text '确定'
            button type:"button", class:"btn btn-default gap", 'data-dismiss':"modal",->
              text '关闭'

#<!-- Modal -->
  div "modal fade", id:"renameModal", role:"dialog", 'aria-hidden':"true", ->
    div "modal-dialog", ->
      div "modal-content", ->
        div "modal-header", ->
          button class:"close", 'data-dismiss':"modal", 'aria-hidden':"true", -> text '&times;'
          h4 "modal-title", -> text '重命名'
        div "modal-body", ->
          div ->
            input type:"text", class:"form-control", id:"renameInput", placeholder:"请输入排期名称",  ->
        div "modal-footer", ->
          button "btn btn-primary", id: 'renameConfirmBtn', -> '确定'
          button class:"btn btn-default", 'data-dismiss':"modal", -> '关闭'
  div class:"modal fade", id:"removeSchedulesAlert", 'tabindex':"-1", 'role':"dialog", 'aria-labelledby':"createFolderLabel", 'aria-hidden':"true", ->
    div class:"modal-dialog", ->
      div class:"modal-content", ->
        div class:"modal-header", ->
          button type:"button",class:"close",'data-dismiss':"modal",'aria-hidden':"true", ->
            text '&times;'
          h4 class:"modal-title", id:"createFolderLabel", ->
            text '警告'
        div class:"modal-body", ->
          h4 class:"col-xs-offset-1", ->
            text '请先选择您要删除的文件或者文件夹'
          div class:"col-xs-offset-9 diabtnfix", ->
            button type:"button",  class:"btn btn-primary ",'data-dismiss':"modal", ->
              text '确定'
  div class:" well well-sm fix-top-2", ->
    div class :"container fixed-width",id:"operateScheduleArea", ->
      button type: 'button', class: 'btn btn-default', id:'createBtn', onclick:"window.location.href='/schedule/create'", ->
        span class:"glyphicon glyphicon-new-window", ->
        text ' 新建'
#      button type:"button", class:"btn btn-default gap", id:'moveNodesBtn',  ->
#        span class:"glyphicon glyphicon-edit", ->
#        text ' 编辑'
      button type:"button", class:"btn btn-default gap",id:"removeSchedulesBtn",  ->
        span class:"glyphicon glyphicon-trash", ->
        text ' 删除'

      div class: 'input-group col-xs-3 pull-right searchPanel', ->
        input type:"text", class:"form-control", id:"searchInput", placeholder:"请输入排期名称", ->
        span class: 'input-group-btn', ->
          button type:"submit", class:"btn btn-default", id:"searchBtn", -> '搜索'


  div class: 'container fix-top-2-tablelist-default fixed-width', ->
    h3 class: 'pageInfo', ->
      img src: 'images/header.png',class: 'circlePic', ->
      text '&nbsp排期'
    div class: 'panel panel-default', ->
      table class: 'table table-striped',style:"table-layout:fixed;word-wrap:break-word;", id: 'schedules', ->
        thead class:"thead-color", ->
          tr ->
            th class :"col-xs-5 curpointer sortByName sortBy", ->
              span class:"col-xs-1 ", ->
                input type: 'checkbox',id:"allSchedules"
              div class :" ", ->
                span class :" col-xs-10 ", ->
                  text ' 名称'
                  b class:"caret ",sortColName:"name",style:"display:none",
            th class :"col-xs-2 curpointer",->
              text '播放列表'
              b class:"caret", sortColName:"playlist",style:"display:none",
            th class :"col-xs-1 curpointer",->
              text '类型'
              b class:"caret", sortColName:"type",style:"display:none",
            th class :"col-xs-3 curpointer",->
              text '明细'
              b class:"caret", sortColName:"detail",style:"display:none",
            th class :"col-xs-1 curpointer sortByStamp sortBy",->
              text '修改时间'
              b class:"caret", sortColName:"stamp",style:"display:none",
        tbody ->
  script type:"text/template", id:"scheduleTemplate", style:"display:none", ->
    td class:"col-xs-5 ",->
      span class:"col-xs-1 ", ->
        input type:"checkbox",value:"{{id}}", class: 'scheduleChk'
      div class:"col-xs-10", ->
        span class:"col-xs-9 name displayName", title:'{{name}}', -> '{{name}}'
      div class:"col-xs-6 operation", style:'display:none;text-align: right;', ->
        a href:'javascript:void(0)', class: 'edit gap', title:'编辑', 'data-toggle': 'modal', 'data-target':'#myModal', ->
          span -> '编辑'#class:'glyphicon glyphicon-edit',
        a href:'javascript:void(0)', class: 'publish gap',title:'发布', ->
          span -> '发布'#class:'glyphicon glyphicon-plus-sign',
        a href:'javascript:void(0)', class: 'rename gap',title:'重命名', ->
          span -> '重命名'#class:'glyphicon glyphicon-chevron-down',
        a href:'javascript:void(0)', class: 'clear gap',title:'删除', ->
          span -> '删除'#class:'glyphicon glyphicon-trash',
    td  class:"col-xs-2 ", ->
      span class:'displayName td-playlist',title:"{{title}}", ->'{{children}}'
    td  class:"col-xs-1 ",-> '{{scheduleType}}'
    td  class:"col-xs-3 ",-> '{{scheduleDetail}}'
    td  class:"col-xs-1 ",-> '{{stamp}}'

  script type:'text/template', id:'box-template', style: 'display: none', ->
    td class:"col-xs-3",   ->
      span class:"col-xs-1 ", ->
        input type:"checkbox",value:"{{id}}"
      div ->
        span class:"name displayName",  title:'{{name}}', style:'width:100px;', -> '{{name}}'
    td class:"col-xs-3", ->
      span class:'td-alias displayName',title:'{{alias}}', -> '{{alias}}'
    td class:"col-xs-3", -> '{{ip}}'
    td class:"col-xs-3", ->
      span class: '{{online}}'

  script type:'text/template', id: 'group-template', style: 'display: none', ->
    td ->
      span class: 'col-xs-1', ->
        input type: 'checkbox', value: "{{id}}"
      div ->
        span class: 'name displayName', title:"{{name}}", -> "{{name}}"

  script type:'text/template', id:'timeSetting-template', style: 'display: none', ->
    div class :"row text-center",id:'week{{id}}',  ->
      div class :"weekItem", ->
        button class:"btn {{btnClass1}} gap weekday",onclick:"weekday(this)", 'day':"1", ->'周一'
        button class:"btn {{btnClass2}} gap weekday",onclick:"weekday(this)", 'day':"2",  ->'周二'
        button class:"btn {{btnClass3}} gap weekday",onclick:"weekday(this)", 'day':"3", ->'周三'
        button class:"btn {{btnClass4}} gap weekday",onclick:"weekday(this)", 'day':"4",  ->'周四'
        button class:"btn {{btnClass5}} gap weekday",onclick:"weekday(this)", 'day':"5",  ->'周五'
        button class:"btn {{btnClass6}} gap weekday",onclick:"weekday(this)", 'day':"6",  ->'周六'
        button class:"btn {{btnClass7}} gap weekday",onclick:"weekday(this)", 'day':"7",  ->'周日'
      br ->

block 'lazyscript', ->
  script src: '/js/schedule/model/schedule.js'
  script src: '/js/gbvision.js'
  script src: '/js/box/model/box.js'
  script src: '/js/box/model/group.js'
  script src: '/js/schedule/view/publish.js'
  script src: '/js/schedule/view/index.js'
