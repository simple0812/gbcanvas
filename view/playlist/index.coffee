extend 'layout'

block 'title', ->
  title '播放列表'

block 'style', ->

block 'script', ->


  coffeescript ->

block 'main', ->
  div class:"modal fade", id:"deletePlaylistAlert", 'tabindex':"-1", 'role':"dialog", 'aria-labelledby':"createFolderLabel", 'aria-hidden':"true", ->
    div class:"modal-dialog", ->
      div class:"modal-content", ->
        div class:"modal-header", ->
          button type:"button",class:"close",'data-dismiss':"modal",'aria-hidden':"true", ->
            text '&times;'
          h4 class:"modal-title", id:"createFolderLabel", ->
            text '警告'
        div class:"modal-body", ->
          h4 class:"col-xs-offset-1", ->
            text '请先选择您要删除的播放列表'
          div class:"col-xs-offset-9 diabtnfix", ->
            button type:"button",  class:"btn btn-primary ",'data-dismiss':"modal", ->
              text '确定'
  div class: 'well well-sm fix-top-2', ->
    div class: 'container fixed-width', ->
      button type: 'button', class: 'btn btn-default', id:'createBtn', onclick:"window.location.href='/playlist/create'", ->
        span class: 'glyphicon glyphicon-new-window', ->
        text ' 新建'
      button type: 'button', class: 'btn btn-default gap', id:'deleteBtn',  onclick:'delPlaylists()', ->
        span class: 'glyphicon glyphicon-trash', ->
        text ' 删除'

      div class: 'col-xs-3 input-group pull-right searchPanel', ->
        input type:"text", class:"form-control", id:"searchInput", placeholder:"请输入播放列表名称",oninput:"searchPlaylists()", ->
        span class: 'input-group-btn', ->
          button type:"submit", class:"btn btn-default", id:"searchBtn",onclick:"searchPlaylists()", -> '搜索'


  div class: 'container fix-top-2-tablelist-default fixed-width', ->
    h3 class: 'pageInfo', ->
      img src: 'images/header.png',class: 'circlePic', ->
      text '&nbsp播放列表'
    div class: 'panel panel-default', ->
      table class: 'table table-striped', style:"table-layout:fixed;word-wrap:break-word;", id: 'mediaArea', ->
        thead class:"thead-color",->
          tr ->
            th class :"col-xs-4 curpointer sortByName sortBy", ->
              span class:"col-xs-1 ", ->
                input type: 'checkbox',id:"chkAllItem"
              div class :"col-xs-10 ", style:'padding-left:0', ->
                span class :" col-xs-10", ->
                  text ' 名称'
                  b class:"caret ",sortColName:"name",style:"display:none",
            th class :"col-xs-2 curpointer sortByStamp sortBy text-center",->
              text '修改时间'
              b class:"caret", sortColName:"stamp",style:"display:none",
        tbody ->
  script type:'text/template', id:'tmplPlaylist', ->
      td ->
        span class:"col-xs-1 ", ->
          input type:"checkbox",value:"{{id}}", class: 'chkMediaItem'
        div class:"col-xs-10 ", ->
          span class:"col-xs-9 playlistName displayName",  title:'{{name}}', -> '{{name}}'
        div class:"col-xs-4 playlistOper  ", style:'display:none;text-align: right;', ->
          a href:'/playlist/edit?id={{id}}', class: ' gap',title:'编辑', ->
            span -> '编辑'#class:'glyphicon glyphicon-edit',
          a href:'javascript:void(0)', class: 'tdCopyItem gap',title:'复制', ->
            span -> '复制'#class:'glyphicon glyphicon-file',
          a href:'javascript:void(0)', class: 'tdRemoveItem gap',title:'删除', ->
            span -> '删除'#class:'glyphicon glyphicon-trash',
      td class:'text-center',-> '{{stamp}}'

block 'lazyscript', ->
  script src:"/js/playlist/model/playlist.js"
  script src: '/js/playlist/view/playlist.js'
