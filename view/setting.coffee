extend 'layout'

block 'title', ->
  title '设置'

block 'style', ->
  link href: 'css/jquery.fileupload.css', rel: 'stylesheet'

block 'script', ->
  #script src: 'js/setting.js'

block 'main', ->
  div class: 'well well-sm fix-top-2', ->
    div class: 'container fixed-width', ->
      span class:'btn', -> '&nbsp'
#      button type: 'button', class: 'btn btn-default', id:'saveBtn', ->
#        span class: 'glyphicon glyphicon-floppy-disk', ->
#        text ' 保存'

  div class: 'container fix-top-2-tablelist-default fixed-width', ->
#    div class: 'panel panel-default', ->
#      div class: 'panel-heading', ->
#        h3 class:'panel-title', -> '通用设置'
#      div class: 'panel-body', ->
#        div class: 'form-horizontal col-xs-5', ->
#          div class: 'form-group', ->
#            label class: 'col-xs-4 control-label', -> '超时时间设置: '
#            div class: "col-xs-2", ->
#              input type: "text", class: "form-control", placeholder: "0"
#            label class: 'col-xs-1 control-label', -> '分'
#            div class: "col-xs-2", ->
#              input type: "text", class: "form-control", placeholder: "0"
#            label class: 'col-xs-1 control-label', -> '秒'


    div class: 'panel panel-default', ->
      div class: 'panel-heading', ->
        h3 class:'panel-title', -> 'Android播放器升级'
      div class: 'panel-body', ->
        div ->
          label class:'control-label', -> '播放软件升级'
          div class: 'panel-body', ->
            label class:'control-label pull-left', -> '当前版本号: &nbsp&nbsp'
            label class: 'control-label pull-left', id: 'ANDVersion', -> "#{@version.android.code}"
          div class: 'progress progress-striped active', id: 'ANDProgress',style:"display:none",  ->
            div class:"progress-bar progress-bar-primary",style:"width: 0%;"
            p id:'ANDProgresspercent', style:'width:100%; text-align:center;position:absolute;top:0;left:0;', -> '0%'
          div class: 'panel-body', ->
            form id: 'ANDForm', ->
              span class: 'btn btn-primary fileinput-button', ->
                i class: 'glyphicon glyphicon-upload'
                span -> ' 升级'
                input id: 'ANDUploadInput', type: 'file', name: 'file', style: 'width: 90px; height: 30px'


        hr ->

        div ->
          label class:'control-label', -> '控制软件升级'
          div class: 'panel-body', ->
            label class:'control-label pull-left', -> '当前版本号: &nbsp&nbsp'
            label class: 'control-label pull-left', id: 'D4AVersion', -> "#{@version.deamon4android.code}"
          div class: 'progress progress-striped active', id: 'D4AProgress',style:"display:none",  ->
            div class:"progress-bar progress-bar-primary" ,style:"width: 0%;"
            p id:'D4AProgresspercent', style:'width:100%; text-align:center;position:absolute;top:0;left:0;', -> '0%'
          div class: 'panel-body', ->
            form id: 'D4AForm', ->
              span class: 'btn btn-primary fileinput-button', ->
                i class: 'glyphicon glyphicon-upload'
                span -> ' 升级'
                input id: 'D4AUploadInput', type: 'file', name: 'file', style: 'width: 90px; height: 30px'

    div class: 'panel panel-default', ->
      div class: 'panel-heading', ->
        h3 class:'panel-title', -> 'Windows播放器升级'
      div class: 'panel-body', ->
        div ->
          label class:'control-label', -> '播放软件升级'
          div class: 'panel-body', ->
            label class:'control-label pull-left', -> '当前版本号: &nbsp&nbsp'
            label class: 'control-label pull-left', id: 'WINVersion', -> "#{@version.windows.code}"
          div class: 'progress progress-striped active', id: 'WINProgress',style:"display:none",  ->
            div class:"progress-bar progress-bar-primary",style:"width: 0%;"
            p id:'WINProgresspercent', style:'width:100%; text-align:center;position:absolute;top:0;left:0;', -> '0%'
          div class: 'panel-body', ->
            form id: 'WINForm', ->
              span class: 'btn btn-primary fileinput-button', ->
                i class: 'glyphicon glyphicon-upload'
                span -> ' 升级'
                input id: 'WINUploadInput', type: 'file', name: 'file', style: 'width: 90px; height: 30px'

block 'lazyscript', ->
  script src:"/js/vendor/jquery.ui.widget.js"
  script src:"/js/jquery.fileupload.js"
  script src:"/js/setting.js"
  coffeescript ->
    $ -> fileUpload()