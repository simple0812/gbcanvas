extend "layout"
block 'title', ->
  title '任务'

block 'script', ->
  #script src: 'js/box.js'

block 'main', ->
  script type:'text/template', id:'box-template', ->
    tr ->
      td ->
        #span class:"col-xs-1 ", ->
          #input type:"checkbox",value:"{0}", class: 'boxChk'
        div class:"col-xs-10", ->
          span class:"name displayName", title:'{1}', -> '{1}'
      td ->
        span class:"displayName", style:"width:250px;", -> '{2}'
  div class:"modal fade", id:"tastDetailModal", 'tabindex':"-1", 'role':"dialog", 'aria-labelledby':"tastDetailModalLabel", 'aria-hidden':"true", ->
    div class:"modal-dialog", ->
      div class:"modal-content", ->
        div class:"modal-header", ->
          button type:"button",class:"close",'data-dismiss':"modal",'aria-hidden':"true", ->
            text '&times;'
          h4 class:"modal-title", id:"tastDetailModalLabel", ->
            text '任务详情'
        div class:"modal-body", ->
          div ->
            div class :"row ", id:'box', ->
              div class: 'panel panel-default', ->
                table class: 'table table-striped', style:"table-layout:fixed;word-wrap:break-word;", id: 'box-list', ->
                  thead class:"thead-color",->
                    tr ->
                      th class :"col-xs-6",->
#                        span class:"col-xs-1 ", ->
#                          input type: 'checkbox',id:"allBoxes"
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
            button type:"button", class:"btn btn-default gap", 'data-dismiss':"modal",->
              text '关闭'
  div class:"modal fade", id:"taskDeleteAlert", 'tabindex':"-1", 'role':"dialog", 'aria-labelledby':"createFolderLabel", 'aria-hidden':"true", ->
    div class:"modal-dialog", ->
      div class:"modal-content", ->
        div class:"modal-header", ->
          button type:"button",class:"close",'data-dismiss':"modal",'aria-hidden':"true", ->
            text '&times;'
          h4 class:"modal-title", id:"taskDeleteAlertLabel", ->
            text '警告'
        div class:"modal-body", ->
          h4 class:"col-xs-offset-1", ->
            text '请先选择您要删除的任务'
          div class:"col-xs-offset-9 diabtnfix", ->
            button type:"button",  class:"btn btn-primary ",'data-dismiss':"modal", ->
              text '确定'
  div id:"task", ->
    div class:"well well-sm fix-top-2 ", ->
      div class :"container fixed-width", ->
        button type:"button", class:"btn btn-default ",  id:'deleteTasksBtn', ->
          span class:"glyphicon glyphicon-trash", ->
          text ' 删除'
        div class: 'col-xs-3 input-group pull-right searchPanel', ->
          input type:"text", class:"form-control", id:"searchInput", placeholder:"请输入排期名", ->
          span class: 'input-group-btn', ->
            button type:"submit", class:"btn btn-default", id:"searchBtn", -> '搜索'

    div class: 'container fix-top-2-tablelist-default fixed-width', ->
      h3 class: 'pageInfo', ->
        img src: 'images/header.png',class: 'circlePic', ->
        text '&nbsp任务'
      div class: 'panel panel-default', ->
        table class: 'table table-striped', style:"table-layout:fixed;word-wrap:break-word;", id: 'tasks', ->
          thead class:"thead-color",->
            tr ->
              th class :"col-xs-6 curpointer sortByStamp sortBy",->
                span class:"col-xs-1 ", ->
                  input type: 'checkbox',id:"allTasks"
                div class :"col-xs-10 ", ->
                  span class :" col-xs-7", ->
                    text ' 发布时间'
                    b class:"caret ",sortColName:"stamp",style:"display:none",
              th class :"col-xs-5 curpointer sortByScheduleName sortBy",->
                text '排期名称'
                b class:"caret", sortColName:"ScheduleName",style:"display:none",
              th class :"col-xs-1 curpointer sortByStatus sortBy",->
                text '状态'
                b class:"caret", sortColName:"status",style:"display:none",

          tbody ->

  script type:"text/template", id:"task-Template", style:"display:none", ->
    td ->
      span class:"col-xs-1 ", ->
        input type:"checkbox",value:"{{id}}", class: 'task'
      div class:"col-xs-10", ->
        span class:"col-xs-9 stamp", title:'{{stamp}}', -> '{{stamp}}'
      div class:"col-xs-4 operation", style:'display:none;text-align: right;', ->
        a href:'javascript:void(0)', class: 'cancel gap', title:'取消', ->
          span -> '取消'#class:'glyphicon glyphicon-edit',
        a href:'javascript:void(0)', class: 'detail gap',title:'详细', ->
          span -> '详细'#class:'glyphicon glyphicon-chevron-down',
        a href:'javascript:void(0)', class: 'clear gap',title:'删除', ->
          span -> '删除'#class:'glyphicon glyphicon-trash',
    td  ->
      span class:'displayName td-schedule', -> '{{scheduleName}}'
    td  -> '{{isCancelled}}'
block 'lazyscript', ->
  script src: '/js/task.js'
