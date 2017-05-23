extend 'layout'

block 'title', ->
  title '播放器'

block 'style', ->

block 'script', ->
  #script src: 'js/box.js'
  coffeescript ->

block 'main', ->
  div class: 'well well-sm fix-top-2', ->
    div class: 'container', ->
      button type: 'button', class: 'btn btn-default col-xs-6 col-sm-2 col-md-1 col-lg-1', id:'createBtn', ->
        span class: 'glyphicon glyphicon-new-window', ->
        text ' 新建'
      button type: 'button', class: 'btn btn-default col-xs-6 col-sm-2 col-md-1 col-lg-1', id:'deleteBtn', ->
        span class: 'glyphicon glyphicon-trash', ->
        text ' 删除'
      div class: 'btn-group zero-padding col-sm-2 col-md-2 col-lg-1 hidden-xs', ->
        button type: 'button', class: 'btn btn-default dropdown-toggle col-sm-12', id:'groupBtn', 'data-toggle': "dropdown", ->
          text ' 分组管理'
          span class: "caret", ->
        ul class: "dropdown-menu", role: "menu", ->
          li ->
            a href: "#", -> '设置分组'
          li class: "divider", ->
          li ->
            a href: "#", -> '编辑分组'
      button type: 'button', class: 'btn btn-default col-xs-6 visible-xs', ->
        span class: 'glyphicon glyphicon-new-window', ->
        text ' 设置分组'
      button type: 'button', class: 'btn btn-default col-xs-6 visible-xs', ->
        span class: 'glyphicon glyphicon-trash', ->
        text ' 编辑分组'
      div class: 'btn-group zero-padding col-sm-2 col-md-2 col-lg-1 hidden-xs', ->
        button type: 'button', class: 'btn btn-default dropdown-toggle col-sm-12', id:'setBoxBtn', 'data-toggle': "dropdown", ->
          text ' 播放器设置'
          span class: "caret", ->
        ul class: "dropdown-menu", role: "menu", ->
          li ->
            a href: "#", -> '基本设置'
          li class: "divider", ->
          li ->
            a href: "#", -> '网络设置'
      button type: 'button', class: 'btn btn-default col-xs-6 visible-xs', ->
        span class: 'glyphicon glyphicon-new-window', ->
        text ' 基本设置'
      button type: 'button', class: 'btn btn-default col-xs-6 visible-xs', ->
        span class: 'glyphicon glyphicon-trash', ->
        text ' 网络设置'
      div class: 'btn-group zero-padding col-sm-2 col-md-1 col-lg-1 hidden-xs', ->
        button type: 'button', class: 'btn btn-default dropdown-toggle col-sm-12', id:'commandBtn', 'data-toggle': "dropdown", ->
          text ' 控制'
          span class: "caret", ->
        ul class: "dropdown-menu", role: "menu", ->
          li ->
            a href: "#", -> '截屏'
          li class: "divider", ->
          li ->
            a href: "#", -> '开屏'
          li class: "divider", ->
          li ->
            a href: "#", -> '关屏'
          li class: "divider", ->
          li ->
            a href: "#", -> '开机'
          li class: "divider", ->
          li ->
            a href: "#", -> '关机'
          li class: "divider", ->
          li ->
            a href: "#", -> '重启'
          li class: "divider", ->
          li ->
            a href: "#", -> '重置'
      button type: 'button', class: 'btn btn-default col-xs-6 visible-xs', ->
        span class: 'glyphicon glyphicon-new-window', ->
        text ' 截屏'
      button type: 'button', class: 'btn btn-default col-xs-6 visible-xs', ->
        span class: 'glyphicon glyphicon-new-window', ->
        text ' 开屏'
      button type: 'button', class: 'btn btn-default col-xs-6 visible-xs', ->
        span class: 'glyphicon glyphicon-new-window', ->
        text ' 关屏'
      button type: 'button', class: 'btn btn-default col-xs-6 visible-xs', ->
        span class: 'glyphicon glyphicon-new-window', ->
        text ' 开机'
      button type: 'button', class: 'btn btn-default col-xs-6 visible-xs', ->
        span class: 'glyphicon glyphicon-new-window', ->
        text ' 重启'
      button type: 'button', class: 'btn btn-default col-xs-6 visible-xs', ->
        span class: 'glyphicon glyphicon-new-window', ->
        text ' 重置'

      div class: 'input-group col-lg-offset-4 col-lg-3 zero-padding visible-lg', ->
        input type:"text", class:"form-control col-lg-6", id:"searchInput", placeholder:"请输入播放器名称", ->
        span class: 'input-group-btn  zero-padding', ->
          button type:"submit", class:"btn btn-default", id:"searchBtn", -> '搜索'

      div class: 'input-group col-md-4 zero-padding visible-md', ->
        input type:"text", class:"form-control col-md-4", id:"searchInput", placeholder:"请输入播放器名称", ->
        span class: 'input-group-btn col-md-2', ->
          button type:"submit", class:"btn btn-default", id:"searchBtn", -> '搜索'

      div class: 'input-group col-sm-12 zero-padding visible-sm', ->
        input type:"text", class:"form-control col-sm-4", id:"searchInput", placeholder:"请输入播放器名称", ->
        span class: 'input-group-btn col-sm-2', ->
          button type:"submit", class:"btn btn-default", id:"searchBtn", -> '搜索'

      div class: 'input-group col-xs-12 zero-padding visible-xs', ->
        input type:"text", class:"form-control col-xs-8", id:"searchInput", placeholder:"请输入播放器名称", ->
        span class: 'input-group-btn', ->
          button type:"submit", class:"btn btn-default col-xs-4", id:"searchBtn", -> '搜索'
      hr ->
      div class: 'col-sm-4 input-group', ->
        span class: 'input-group-addon input-group-addon-format', -> '当前分组：'
        select class: "form-control", ->
          option -> '1'
          option -> '2'
          option -> '3'
          option -> '4'
          option -> '5'
      div class: "btn-group col-sm-offset-6 col-sm-2", ->
        button type:"button", class: "btn btn-default", id:'boxListBtn', -> '列表'
        button type:"button", class: "btn btn-default", id: 'boxViewBtn', -> '视图'

  div class: 'container fix-top-2-tablelist-box', ->
    h3 -> "@ &nbsp播放器"
    div class: 'panel panel-default', ->
      table class: 'table table-striped', id: 'mediaArea', ->
        thead style:'background-color: #00bfff', ->
          tr ->
            th ->
              div ->
                span ->
                  input type: 'checkbox'
                span -> ' 名称'
            th -> '类型'
            th -> '大小'
            th -> '时长'
            th -> '上传时间'

        tbody ->
          tr ->
            td ->
              div ->
                span ->
                  input type: 'checkbox'
                span -> ' 1'
            td -> 'Mark'
            td -> 'Otto'
            td -> '@mdo'
            td -> '@mdo'
          tr ->
            td ->
              div ->
                span ->
                  input type: 'checkbox'
                span -> ' 2'
            td -> 'Jacob'
            td -> 'Thornton'
            td -> '@fat'
            td -> '@mdo'
          tr ->
            td ->
              div ->
                span ->
                  input type: 'checkbox'
                span -> ' 3'
            td -> 'Larry'
            td -> 'the Bird'
            td -> '@twitter'
            td -> '@mdo'
          tr ->
            td ->
              div ->
                span ->
                  input type: 'checkbox'
                span -> ' 1'
            td -> 'Mark'
            td -> 'Otto'
            td -> '@mdo'
            td -> '@mdo'
          tr ->
            td ->
              div ->
                span ->
                  input type: 'checkbox'
                span -> ' 2'
            td -> 'Jacob'
            td -> 'Thornton'
            td -> '@mdo'
            td -> '@fat'
          tr ->
            td ->
              div ->
                span ->
                  input type: 'checkbox'
                span -> ' 3'
            td -> 'Larry'
            td -> 'the Bird'
            td -> '@twitter'
            td -> '@mdo'
          tr ->
            td ->
              div ->
                span ->
                  input type: 'checkbox'
                span -> ' 1'
            td -> 'Mark'
            td -> 'Otto'
            td -> '@mdo'
            td -> '@mdo'
          tr ->
            td ->
              div ->
                span ->
                  input type: 'checkbox'
                span -> ' 2'
            td -> 'Jacob'
            td -> 'Thornton'
            td -> '@mdo'
            td -> '@fat'
          tr ->
            td ->
              div ->
                span ->
                  input type: 'checkbox'
                span -> ' 3'
            td -> 'Larry'
            td -> 'the Bird'
            td -> '@mdo'
            td -> '@twitter'
          tr ->
            td ->
              div ->
                span ->
                  input type: 'checkbox'
                span -> ' 1'
            td -> 'Mark'
            td -> 'Otto'
            td -> '@mdo'
            td -> '@mdo'
          tr ->
            td ->
              div ->
                span ->
                  input type: 'checkbox'
                span -> ' 2'
            td -> 'Jacob'
            td -> '@mdo'
            td -> 'Thornton'
            td -> '@fat'
          tr ->
            td ->
              div ->
                span ->
                  input type: 'checkbox'
                span -> ' 3'
            td -> 'Larry'
            td -> '@mdo'
            td -> 'the Bird'
            td -> '@twitter'
          tr ->
            td ->
              div ->
                span ->
                  input type: 'checkbox'
                span -> ' 1'
            td -> 'Mark'
            td -> 'Otto'
            td -> '@mdo'
            td -> '@mdo'
          tr ->
            td ->
              div ->
                span ->
                  input type: 'checkbox'
                span -> ' 2'
            td -> 'Jacob'
            td -> '@mdo'
            td -> 'Thornton'
            td -> '@fat'
          tr ->
            td ->
              div ->
                span ->
                  input type: 'checkbox'
                span -> ' 3'
            td -> 'Larry'
            td -> 'the Bird'
            td -> '@twitter'
            td -> '@mdo'
          tr ->
            td ->
              div ->
                span ->
                  input type: 'checkbox'
                span -> ' 1'
            td -> 'Mark'
            td -> '@mdo'
            td -> 'Otto'
            td -> '@mdo'
          tr ->
            td ->
              div ->
                span ->
                  input type: 'checkbox'
                span -> ' 2'
            td -> 'Jacob'
            td -> 'Thornton'
            td -> '@fat'
            td -> '@mdo'
          tr ->
            td ->
              div ->
                span ->
                  input type: 'checkbox'
                span -> ' 3'
            td -> 'Larry'
            td -> 'the Bird'
            td -> '@mdo'
            td -> '@twitter'
          tr ->
            td ->
              div ->
                span ->
                  input type: 'checkbox'
                span -> ' 1'
            td -> 'Mark'
            td -> 'Otto'
            td -> '@mdo'
            td -> '@mdo'
          tr ->
            td ->
              div ->
                span ->
                  input type: 'checkbox'
                span -> ' 2'
            td -> 'Jacob'
            td -> 'Thornton'
            td -> '@fat'
            td -> '@mdo'
          tr ->
            td ->
              div ->
                span ->
                  input type: 'checkbox'
                span -> ' 3'
            td -> 'Larry'
            td -> '@mdo'
            td -> 'the Bird'
            td -> '@twitter'
