extend "layout"
block 'title', ->
  title '日志'
block 'main', ->
#  div class:"",   ->
  div id:"log", ->
    div class:"well well-sm fix-top-2 ", ->
      div class :"container fixed-width", ->
        button type:"button",  class:"btn btn-default", id:'deleteLogs', ->  #等待修改
          span class:"glyphicon glyphicon-folder-close", ->
          text ' 删除'

        div class: 'col-xs-3 input-group pull-right searchPanel', ->
          input type:"text", class:"form-control", id:"searchInput", placeholder:"请输入日志文件名", ->
          span class: 'input-group-btn', ->
            button type:"submit", class:"btn btn-default", id:"searchBtn", -> '搜索'

    div class: 'container fix-top-2-tablelist-default fixed-width', ->
      h3 class: 'pageInfo', ->
        img src: 'images/header.png',class: 'circlePic', ->
        text '&nbsp日志'
      div class: 'panel panel-default', ->
        table class: 'table table-striped', style:"table-layout:fixed;word-wrap:break-word;", id: 'log-list', ->
          thead class:"thead-color",->
            tr ->

              th class :"col-xs-6 curpointer sortByName sortBy",->
                span class:"col-xs-1 ", ->
                  input type: 'checkbox',id:"allLogs"
                div class :"col-xs-10 ", ->
                  span class :" col-xs-7", ->
                    text '名称'
                    b class:"caret ",sortColName:"name",style:"display:none",
#              th class :"col-xs-6 curpointer sortByName sortBy", ->
#                text '名称'
#                b class:"caret", sortColName:"name",style:"display:none",
              th class :"col-xs-2 curpointer sortBySize sortBy", ->
                text '大小'
                b class:"caret", sortColName:"size",style:"display:none",

              th class :"col-xs-4 curpointer sortByMtime sortBy", ->
                text '修改时间'
                b class:"caret", sortColName:"mtime",style:"display:none",


          tbody ->

  script type:'text/template', id:'log-template', style: 'display: none', ->
    td ->
      span class:"col-xs-1 ", ->
        input type:"checkbox",value:"{{name}}", class: 'log'
      div class:"col-xs-10", ->
        span class:"col-xs-9 name", title:'{{name}}', -> '{{name}}'
      div class:"col-xs-4 operation", style:'display:none;text-align: right;', ->
        a href:'/logfile/{{name}}', class: 'download gap',title:'下载', ->
          span -> '下载'#class:'glyphicon glyphicon-chevron-down',
        a href:'javascript:void(0)', class: 'clear gap',title:'删除', ->
          span -> '删除'#class:'glyphicon glyphicon-trash',
    td -> '{{size}}'
    td -> '{{mtime}}'
block 'lazyscript', ->
  script src: '/js/log/model/log.js'
  script src: '/js/log/view/log.js'

