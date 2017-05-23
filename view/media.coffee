extend 'layout'

block 'title', ->
  title '媒体库'

block 'style', ->
  link href: 'css/jquery.fileupload.css', rel: 'stylesheet'

block 'script', ->
  coffeescript ->
    $ -> fileUpload()
    $ -> compressAndUpload()

    @isSave = true;
    window.onbeforeunload = ->
      return ('正在上传文件，重新加载或关闭此网页将取消上传，是否确定重新加载或关闭此网页') unless(isSave)

block 'main', ->
  div id:"operateMediaArea", ->
    div class:"modal fade", id:"createFolder", 'tabindex':"-1", 'role':"dialog", 'aria-labelledby':"createFolderLabel", 'aria-hidden':"true", ->
      div class:"modal-dialog", ->
        div class:"modal-content", ->
          div class:"modal-header", ->
            button type:"button",class:"close",'data-dismiss':"modal",'aria-hidden':"true", ->
              text '&times;'
            h4 class:"modal-title", id:"createFolderLabel", ->
              text '新建文件夹'
          div class:"modal-body", ->
            input type:"text", class:"form-control", id:"createFolderTxt", placeholder:"请输入文件夹名", ->
            div class:"col-xs-offset-9 diabtnfix", ->
              button type:"button",  class:"btn btn-primary ",id:"createFolderConfirmBtn", ->
                text '确定'
              button type:"button", class:"btn btn-default gap", 'data-dismiss':"modal",->
                text '关闭'
    div class:"modal fade", id:"moveFolderAlert", 'tabindex':"-1", 'role':"dialog", 'aria-labelledby':"createFolderLabel", 'aria-hidden':"true", ->
      div class:"modal-dialog", ->
        div class:"modal-content", ->
          div class:"modal-header", ->
            button type:"button",class:"close",'data-dismiss':"modal",'aria-hidden':"true", ->
              text '&times;'
            h4 class:"modal-title", id:"createFolderLabel", ->
              text '警告'
          div class:"modal-body", ->
            h4 class:"col-xs-offset-1", ->
              text '请先选择您要移动的文件或者文件夹'
            div class:"col-xs-offset-9 diabtnfix", ->
              button type:"button",  class:"btn btn-primary ",'data-dismiss':"modal", ->
                text '确定'
    div class:"modal fade", id:"deleteFolderAlert", 'tabindex':"-1", 'role':"dialog", 'aria-labelledby':"createFolderLabel", 'aria-hidden':"true", ->
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
    div class:"modal fade", id:"createWedStream", 'tabindex':"-1", 'role':"dialog", 'aria-labelledby':"createWedStreamLabel", 'aria-hidden':"true", ->
      div class:"modal-dialog", ->
        div class:"modal-content", ->
          div class:"modal-header", ->
            button type:"button",class:"close",'data-dismiss':"modal",'aria-hidden':"true", ->
              text '&times;'
            h4 class:"modal-title", id:"createWedStreamLabel", ->
              text '添加网页'
          div class:"modal-body", ->
            div class:"input-group gapHorizontal", ->
              span class:"input-group-addon",id:"otherMediaName", ->'网页名称：'
              input type:"text", class:"form-control", id:"createWedStreamTxt", placeholder:"请输入网页名称", ->
            div class:"input-group ", ->
              span class:"input-group-addon",id:"urlName", ->'网页地址：'
              input type:"text", class:"form-control", id:"createWedStreamUrlTxt", placeholder:"请输入网络地址", ->
            div class:"col-xs-offset-9 diabtnfix", ->
              button type:"button",  class:"btn btn-primary ",id:"createWedStreamConfirmBtn", ->
                text '确定'
              button type:"button", class:"btn btn-default gap", 'data-dismiss':"modal",->
                text '关闭'
    div class:"modal fade", id:"moveMedia", 'tabindex':"-1", 'role':"dialog", 'aria-labelledby':"moveMediaLabel", 'aria-hidden':"true", ->
      div class:"modal-dialog", onselectstart:'return false', ->
        div class:"modal-content", style:'position:relative', ->
          div class:"modal-header", ->
            button type:"button",class:"close",'data-dismiss':"modal",'aria-hidden':"true", ->
              text '&times;'
            h4 class:"modal-title ", id:"moveMediaLabel",  ->
              text '移动媒体文件'
          div class:"modal-body", ->
            ul class:'nav', id:"dirList", style:' overflow: hidden', ->
          div class:"modal-footer",->
            #    button type:"button", id:'moveNodeConfirmBtn', class:"btn btn-primary ",onclick:"moveNode()", ->
            button type:"button", class:"btn btn-primary ",id:"moveMediaConfirmBtn", ->
              text '确定'
            button type:"button", class:"btn btn-default ", 'data-dismiss':"modal",->
              text '关闭'
    div class:"modal fade", id:"renameMedia", 'tabindex':"-1", 'role':"dialog", 'aria-labelledby':"renameMediaLabel", 'aria-hidden':"true", ->
      div class:"modal-dialog", ->
        div class:"modal-content", ->
          div class:"modal-header", ->
            button type:"button",class:"close",'data-dismiss':"modal",'aria-hidden':"true", ->
              text '&times;'
            h4 class:"modal-title ", id:"renameMediaLabel", ->
              text '重命名'
          div class:"modal-body", ->
            div class:"input-group ", ->
              span class:"input-group-addon", ->'文件(夹)名：'
              input type:"text", class:"form-control", id:"renameMediaTxt", placeholder:"请输入文件(夹)名",  ->
              span class:"input-group-addon",id:"postifx", ->
            div class:"col-sm-offset-9 diabtnfix", ->
              button type:"button",  class:"btn btn-primary ",id:"renameMediaConfirmBtn", ->
                text '确定'
              button type:"button", class:"btn btn-default gap", 'data-dismiss':"modal",->
                text '关闭'
    div class:"modal fade", id:"uploadFilesModal", 'tabindex':"-1", 'role':"dialog", 'aria-labelledby':"uploadFiles", 'aria-hidden':"true", ->
      div class:"modal-dialog", ->
        div class:"modal-content", ->
          div class:"modal-header", ->
            button id:'compressModalClose', type:"button",class:"close",'data-dismiss':"modal",'aria-hidden':"true", ->
              text '&times;'
            h4 class:"modal-title", id:"uploadFiles", ->
              text '上传并打包图片'
          div class:"modal-body", ->
            div class:'alert alert-info form-inline', id:'compressNameDiv', style:'display:none', ->
              label -> '请先输入压缩包名'
              input type:"text", class:"form-control", id:"compressName", placeholder:"压缩包名", style:'display:inline-block;', ->
            div class:'alert alert-warning fade in', id:'compressNameAlert', style:'display:none;', ->
              strong -> '未输入压缩包名'
            div class:'alert alert-warning fade in', id:'compressTypeAlert', style:'display:none;', ->
              strong -> '请选择图片'
            span class: 'col-xs-offset-4 btn btn-primary fileinput-button', id:'addFilesBtn', ->
              i class: 'glyphicon glyphicon-plus'
              span -> ' 选择需上传的图片'
              input id: 'compressAndUpload', type: 'file', name: 'files[]', multiple: 'multiple'
            br ->
            br ->
            table class:'table table-striped', ->
              tbody id:'filelist', class:'files', ->
            div class:"col-xs-offset-9 diabtnfix", ->
              button type:"button",  class:"btn btn-primary ",id:"compressUploadBtn", ->
                text '上传'
              button type:"button", class:"btn btn-default gap", id:'compressCancelBtn', 'data-dismiss':"modal",->
                text '关闭'
    div class: 'well well-sm', ->
      form class:'container fixed-width', id: 'uploadForm ', ->
        span class: 'btn btn-default fileinput-button', ->
          i class: 'glyphicon glyphicon-upload'
          span -> ' 上传文件'
          input id: 'uploadInput', type: 'file', name: 'files[]', multiple: 'multiple', style: 'width: 100px; height: 30px'
        button type: 'button', class: 'btn btn-default gap', id:'uploadFilesBtn', ->
          span class: 'glyphicon glyphicon-compressed', ->
          text ' 打包上传图片'
        button type: 'button', class: 'btn btn-default gap', id:'createFolderBtn', ->
          span class: 'glyphicon glyphicon-folder-close', ->
          text ' 新建文件夹'
        button type: 'button', class: 'btn btn-default gap', id:'moveBtn', ->
          span class: 'glyphicon glyphicon-move', ->
          text ' 移动'
        button type: 'button', class: 'btn btn-default gap', id:'deleteBtn', ->
          span class: 'glyphicon glyphicon-trash', ->
          text ' 删除'
        div class: 'btn-group gap', ->
          button type: 'button', class: 'btn btn-default dropdown-toggle', id:'moreBtn', 'data-toggle': "dropdown", ->
            span class: 'glyphicon glyphicon-globe', ->
            text ' 其他'
            span class: "caret ", ->
          ul class: "dropdown-menu", role: "menu", ->
            li ->
              a href: "#",id:"addWebPage", -> '添加网页'
            li ->
              a href: "#",id:"addMediaStream", -> '添加流媒体'

        div class: 'input-group col-xs-3 pull-right searchPanel', ->
          input type:"text", class:"form-control", id:"searchInput", placeholder:"请输入文件名", ->
          span class: 'input-group-btn', ->
            button type:"button", class:"btn btn-default", id:"searchBtn", -> '搜索'

  #上传文件的进度条
  div class: 'container fixed-width', ->
#    div class: 'progress progress-striped active', id: 'progress',style:"display:none",  ->
    div class: 'progress progress-striped active', id: 'progress',style:"position:relative; display: none", ->
      div class:"progress-bar progress-bar-primary",style:"width: 0%;"
#      p id:'progresspercent', style:'width:100%; text-align:center;position:absolute;top:0;left:0;', -> '12%'
      p id:'progresspercent', style:'width:100%; text-align:center;position:absolute;top:0;left:0;color:orange', -> '0%'
    div class: 'progress progress-striped active', id: 'cprogress',style:"position:relative; display: none", ->
      div class:"progress-bar progress-bar-primary",style:"width: 0%;"
      p id:'cprogresspercent', style:'width:100%; text-align:center;position:absolute;top:0;left:0;color:orange', -> '0%'

  div class: 'container fixed-width', ->
    ol class:"breadcrumb", id: 'mediaNav',currentId:'', ->

  div class: 'container fixed-width ', ->
    h3 class: 'pageInfo', ->
      img src: 'images/header.png',class: 'circlePic', ->
      text '&nbsp媒体库'
    div class: 'panel panel-default', ->
      table class: 'table table-striped',style:"table-layout:fixed;word-wrap:break-word;", id: 'mediaList', ->
        thead class:"thead-color",->
          tr ->
            th class :"col-xs-5 curpointer sortByName sortBy", ->
              span class:"col-xs-1 ", ->
                input type: 'checkbox',id:"allMedias"
              div class :"col-xs-10 ", ->
                b class:"col-xs-2 typepic tyblank", ->
                span class :" col-xs-10", ->
                  text ' 名称'
                  b class:"caret ",sortColName:"name",style:"display:none",
            th class :"col-xs-1 curpointer sortByType sortBy",->
              text '类型'
              b class:"caret type",sortColName:"type",style:"display:none",
            th class :"col-xs-1 curpointer sortBySize sortBy",->
              text '大小'
              b class:"caret size",sortColName:"size",style:"display:none",
            th class :"col-xs-2 curpointer sortByDuration sortBy",->
              text '时长'
              b class:"caret duration",sortColName:"duration",style:"display:none",
            th class :"col-xs-1 curpointer sortByMtime sortBy",->
              text '修改时间'
              b class:"caret mtime ",sortColName:"mtime",style:"display:none",
            th style:'display:none',class:"mediaParent ", -> '所在目录'
        tbody ->
  #媒体库table的tr的模版
  script type:"text/template", id:"mediaTemplate", style:"display:none", ->
    td ->
      span class:"col-xs-1 ", ->
        input type:"checkbox",value:"{{id}}", class: 'mediaItemChk'
      div class:"col-xs-10 ", ->
        b class:"col-xs-2 typepic ty{{type}}", ->
        span class:"col-xs-9 mediaName ", mediaType:'{{type}}', title:'{{name}}', -> '{{name}}'
      div class:"col-xs-5 mediaOper  ", style:'display:none;text-align: right;', ->
        a href:'javascript:void(0)', class: 'moveMedia gap',title:'移动', ->
          span -> '移动'#class:'glyphicon glyphicon-move',
        a href:'/downloadfile/{{id}}.{{extName}}?filename={{name}}', class: 'downloadMedia gap',title:'下载', ->
          span -> '下载'
        a href:'javascript:void(0)', class: 'renameMedia gap',title:'{{oprateName}}', ->
          span -> '{{oprateName}}'#class:'glyphicon glyphicon-chevron-down',
        a href:'javascript:void(0)', class: 'deleteMedia gap',title:'删除', ->
          span -> '删除'#class:'glyphicon glyphicon-trash',

    td  -> '{{displayType}}'
    td  -> '{{size}}'
    td -> '{{duration}}'
    td -> '{{mtime}}'
    td class:'mediaParent ',style:'display:none', ->
      b class:"col-xs-2 typepic tyfolder", ->
      span class:"col-xs-9 mediaParent displayName-parent", mediaType:'{{type}}', title:'{{mediaParentName}}', -> '{{mediaParentName}}'
  #顶部面包屑导航栏的模版
  script type:"text/template", id:"mediaNavTemplate", style:"display:none", ->
    a href:'',currentId:'{{id}}', class :"curpointer", title:"{{name}}", -> '{{displayName}}'
  #移动用的目录的所有文件夹的模版
  script type:"text/template", id:"folderTemplate", style:"display:none", ->
    div title:'{{name}}', ->
      span class:' col-sm-offset-1  selectedFolder {{mark}} '
      img src:'/images/folder.png', class:'moveNodeImg moveTo ', ->
      a href:'javascript:void(0)', 'mediaId':"{{id}}", 'nodepath':"{{path}}", class:'moveTo',->'{{name}}'
block 'lazyscript', ->
  script src:"/js/vendor/jquery.ui.widget.js"
  script src:"/js/jquery.fileupload.js"
  script src: '/js/gbvision.js'
  script src: '/js/media.js'
