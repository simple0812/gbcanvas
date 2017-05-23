extend "layout"
block 'title', ->
  title '编辑'
block 'style', ->
  link href:"/css/canvas.css", rel:"stylesheet"
  link rel: 'stylesheet', href: '/spectrum/spectrum.css'
block 'script', ->
  script src:"/js/playlist/edit/common.js"
  script src:"/js/playlist/edit/extension.js"
  script src:"/js/playlist/edit/pattern.js"
  script src: '/spectrum/spectrum.js'
  script src: '/js/location.js'
  script src: '/js/YiChinaArea.js'
  script src:"/js/guid.js"
  script src:"/js/async.js"
  script src:"/js/jquery.nicescroll.js"
  script src:"/js/jquery.mousewheel.min.js"
  script src:"/js/playlist/edit/model/rect.js"
  script src:"/js/playlist/edit/model/imagerect.js"
  script src:"/js/playlist/edit/model/clock.js"
  script src:"/js/playlist/edit/model/weatherimage.js"
  script src:"/js/playlist/edit/model/textrect.js"
  script src:"/js/playlist/edit/model/scene.js"
  script src:"/js/playlist/edit/model/groupzone.js"
  script src:"/js/playlist/edit/model/mediazone.js"
  script src:"/js/playlist/edit/model/imagecache.js"
  script src:"/js/playlist/edit/model/media.js"
  script src:"/js/playlist/edit/model/datetime.js"
  script src:"/js/playlist/edit/model/airquality.js"
  script src:"/js/playlist/edit/model/marquee.js"
  script src:"/js/playlist/edit/model/temprature.js"
  script src:"/js/playlist/edit/model/weathertext.js"
  script src:"/js/playlist/edit/keyboard.js"
  script src:"/js/playlist/edit/service.js"
  script src:"/js/playlist/model/playlist.js"

  coffeescript ->
    @isSave = false
    window.onbeforeunload = ->
      console.log typeof isSave
      return ('确定要离开?未保存的数据将丢失') unless(isSave)

    @playlistId = getQueryString 'id'
    @rgbToHex = (color) ->
      alpha = color.toString().split(',')[3]
      if alpha?
        alpha = alpha.slice 0, -1
        alphaHex = parseInt(alpha * 255).toString(16)
        if alphaHex.length is 1
          return "#0" + alphaHex + color.toHex()
        else
          return "#" + alphaHex + color.toHex()
      else
        return "#ff" + color.toHex()

    @hexToRgb = (color) ->
      #color = color.splice(1, 0, 'f', 'f') if()
      a =parseInt(color.substr(1,2), 16) / 255;
      r = parseInt(color.substr(3,2), 16)
      g = parseInt(color.substr(5,2), 16)
      b = parseInt(color.substr(7,2), 16)
      return  'rgba({0},{1},{2},{3})'.format r, g, b, a.toFixed(2)

    @palettes = [["#000","#444","#666","#999","#ccc","#eee","#f3f3f3","#fff"],
                ["#f00","#f90","#ff0","#0f0","#0ff","#00f","#90f","#f0f"],
                ["#f4cccc","#fce5cd","#fff2cc","#d9ead3","#d0e0e3","#cfe2f3","#d9d2e9","#ead1dc"],
                ["#ea9999","#f9cb9c","#ffe599","#b6d7a8","#a2c4c9","#9fc5e8","#b4a7d6","#d5a6bd"],
                ["#e06666","#f6b26b","#ffd966","#93c47d","#76a5af","#6fa8dc","#8e7cc3","#c27ba0"],
                ["#c00","#e69138","#f1c232","#6aa84f","#45818e","#3d85c6","#674ea7","#a64d79"],
                ["#900","#b45f06","#bf9000","#38761d","#134f5c","#0b5394","#351c75","#741b47"],
                ["#600","#783f04","#7f6000","#274e13","#0c343d","#073763","#20124d","#4c1130"]]


    @initScroll = ->
      $(" #leftside, #rightside, #compnentindex").niceScroll
        touchbehavior : false, # 是否在触摸屏下使用
        cursorcolor : "#866550", # 滚动条颜色
        cursoropacitymax : 1, # 滚动条是否透明
        cursorwidth : 7, # 滚动条宽度
        horizrailenabled : true, # 是否水平滚动
        cursorborderradius : 3, # 滚动条是否圆角大小
        autohidemode : true, # 是否隐藏滚动条
        cursorborder : 0 # 滚动条边框大小
        zIndex: 9999

    @initColorPicker = (obj)->
      $(obj).spectrum({
        color:"rgba(255,255,255,0)",
        showInput: true,
        chooseText: "选取",
        cancelText: "取消",
        showPalette:true,
        showInitial: false,
        preferredFormat: "rgb",
        showAlpha:true,
        palette:palettes,
        change: (color) ->
          $("#txtSceneBg").val(rgbToHex color).css("background-color",color.toString())
      })


    $ ->
      $("#txtColorPicker").spectrum({
        color:"rgba(255,255,255,0)",
        showInput: true,
        chooseText: "选取",
        cancelText: "取消",
        showPalette:true,
        showInitial: false,
        preferredFormat: "rgb",
        showAlpha:true,
        palette:palettes,
        change: (color) ->
          $("#txtSceneBg").val(rgbToHex color).css("background-color",color.toString())
      })
#      initColorPicker("#txtColorPicker");
      initScroll()


block 'main', ->
  div class:"modal fade", id:"editScene", 'tabindex':"-1", 'role':"dialog", 'aria-labelledby':"editSceneLabel", 'aria-hidden':"true", ->
    div class:"modal-dialog", ->
      div class:"modal-content", ->
        div class:"modal-header", ->
          button type:"button",class:"close",'data-dismiss':"modal",'aria-hidden':"true", ->
            text '&times;'
          h4 class:"modal-title", id:"editSceneLabel", ->
            text '设置场景'
        div class:"modal-body", ->
          div class:"input-group ", style:'display:none;', ->
            span class:"input-group-addon", style:'width:95px; text-align:right;', ->'名称：'
            input type:"text", class:"form-control", id:"txtSceneName", placeholder:"请输入名称", ->
          div class:"input-group col-xs-4", style:'margin-top:10px; margin-left:0; padding-left:0;', ->
            span class:"input-group-addon", ->'背景颜色：'
            input type:"text", class:"form-control", value:"#ffffffff", id:"txtSceneBg", style:'display:none',  placeholder:"请选择背景颜色", onfocus:'$(this).blur()', ->
#            span class:"input-group-addon", -> ''
            input type:"text", class:"form-control", id:'txtColorPicker', style:'width:52px; height:40px;'
          div id:'picker', style:'display:none'
          div class:"input-group xs-col-8", style:'margin:10px 0', ->
            span class:"input-group-addon", ->'背景图片：'
            input type:"text", class:"form-control", value:"", name:"border-color", id:"txtSceneBgPic", placeholder:"请选择背景图片", onclick:"showMediaList(this, 'scene')", onfocus:'$(this).blur()', ->
            span class:"input-group-addon", style:'cursor:pointer', onclick:"$('#txtSceneBgPic').val('')", ->'清空'
          div  class:"input-group", style:'margin:10px 0',->
            div class:"input-group", ->
              span class:"input-group-addon", ->'持续时间：'
              input type:"text", class:"form-control", id:"txtSceneDurationHour", placeholder:"请输入小时", ->
              span class:"input-group-addon", ->'时'
              input type:"text", class:"form-control", id:"txtSceneDurationMin", placeholder:"请输入分钟", ->
              span class:"input-group-addon", ->'分'
              input type:"text", class:"form-control", id:"txtSceneDurationSec", placeholder:"请输入秒", ->
              span class:"input-group-addon", ->'秒'
          #          div  class:"input-group", style:'margin:10px 0',->
#            div class:"input-group", ->
#              span class:"input-group-addon", ->'分：'
#              input type:"text", class:"form-control", id:"txtSceneDurationMin", placeholder:"请输入分钟", ->
#          div  class:"input-group", style:'margin:10px 0',->
#            div class:"input-group", ->
#              span class:"input-group-addon", ->'秒：'
#              input type:"text", class:"form-control", id:"txtSceneDurationSec", placeholder:"请输入秒", ->
          div class:"input-group", style:'margin-top:10px', ->
            span class:"input-group-addon", style:'width:95px; text-align:right;', ->'分辨率：'
            input type:"text", class:"form-control",placeholder:"请输入宽度",id:"txtSceneWidth", value:'1280', ->
            span class:"input-group-addon", ->'X'
            input type:"text", class:"form-control",placeholder:"请输入高度", id:"txtSceneHeight",value:'720',->

          div class:"col-xs-offset-9 diabtnfix", ->
            button type:"button",  class:"btn btn-primary ",id:"btnEditScene", onclick:'editScene(this)', ->
              text '确定'
            button type:"button", class:"btn btn-default gap", 'data-dismiss':"modal",->
              text '关闭'



  div class:"modal fade", id:"playlistModal", 'tabindex':"-1", 'role':"dialog", 'aria-labelledby':"playlistModalLabel", 'aria-hidden':"true", ->
    div class:"modal-dialog", ->
      div class:"modal-content", ->
        div class:"modal-header", ->
          button type:"button",class:"close",'data-dismiss':"modal",'aria-hidden':"true", ->
            text '&times;'
          h4 class:"modal-title", id:"playlistModalLabel", ->
            button type:"button", class:"btn btn-default btn-xs ",onclick:"showMediaList(event, 'mediaZone')", ->
              span class:"glyphicon glyphicon-plus", title:'添加',
            button type:"button",  disabled:'disabled', class:"btn btn-default btn-xs btnMultOperate", onclick:'delElement(this)', style:'margin-left:5px;', ->
              span class:"glyphicon glyphicon-remove", title:'删除',
            button type:"button",  disabled:'disabled', class:"btn btn-default btn-xs btnMixOperate", onclick:'showEditMediaEleModal(this)', style:'margin-left:5px;', ->
              span class:"glyphicon glyphicon-cog", title:'设置',
#            button type:"button",  disabled:'disabled', class:"btn btn-default btn-xs btnSingleOperate", onclick:'downloadElement(this)', style:'margin-left:5px;', ->
#              span class:"glyphicon glyphicon-arrow-down", title:'下载',
            button type:"button", disabled:'disabled',  class:"btn btn-default btn-xs btnSingleOperate", onclick:"switchElePlace(this,  -1)", style:'margin-left:5px;', ->
              span class:"glyphicon glyphicon-arrow-left ", title:'左移'
            button type:"button", disabled:'disabled', class:"btn btn-default btn-xs btnSingleOperate", onclick:'switchElePlace(this, 1)',style:'margin-left:5px;', ->
              span class:"glyphicon glyphicon-arrow-right", title:'右移'
            span style:'fontsize:8px; color:#ccc;'
        div class:"modal-body lielements", ->
          div style:'overflow-x:scroll;', ->
            div id:'mediaElements'
        div class:"modal-footer", ->
          div class:"col-xs-offset-9 diabtnfix", ->
            button type:"button", class:"btn btn-default gap", 'data-dismiss':"modal",->
              text '关闭'

  div class:"modal fade", id:"mediaModal", 'tabindex':"-1", 'role':"dialog", 'aria-labelledby':"mediaModalLabel", 'aria-hidden':"true", ->
    div class:"modal-dialog", ->
      div class:"modal-content", ->
        div class:"modal-header", ->
          button type:"button",class:"close",'data-dismiss':"modal",'aria-hidden':"true", ->
            text '&times;'
          h4 class:"modal-title", id:"mediaModalLabel", ->
            text '选择媒体'
        div class:"modal-body", ->
          div class: 'input-group col-xs-4 pull-right', style:'display:none', id:'operateMediaArea', ->
            input type:"text", class:"form-control", id:"searchInput", placeholder:"输入文件名", ->
            span class: 'input-group-btn', ->
              button type:"button", class:"btn btn-default", id:"searchBtn", -> '搜索'

          div class: ' ', ->
            ol class:"breadcrumb", id: 'mediaNav',currentId:'', ->

          div class: '  ', ->
#            div class: 'panel panel-default', style:"max-height:400px;overflow-y:auto", ->
            div class: 'panel panel-default',   style:"max-height:400px;overflow-y:auto", ->

              table class: 'table table-striped', style:"table-layout:fixed;word-wrap:break-word;", id: 'mediaList', ->
                thead class:"thead-color",->
                  tr ->
                    th class :"col-xs-4 curpointer sortByName sortBy", ->
                      span class:"col-xs-1 ", ->
                        input type: 'checkbox',id:"allMedias"
                      div class :"col-xs-9 ", ->
                        b class:"col-xs-2 typepic tyblank", ->
                        span class:"col-xs-8",->
                          text ' 名称'
                          b class:"caret ",sortColName:"name",style:"display:none",
                    th class :"col-xs-2 curpointer sortByType sortBy",->
                      text '类型'
                      b class:"caret type",sortColName:"type",style:"display:none",
                    th class :"col-xs-2 curpointer sortByDuration sortBy",->
                      text '时长'
                      b class:"caret duration",sortColName:"duration",style:"display:none",
                    th style:'display:none',class:"mediaParent col-xs-3", -> '所在目录'
                tbody ->
          script type:"text/template", id:"mediaTemplate", style:"display:none", ->
            td ->
              span class:"col-xs-1 ", ->
                input type:"checkbox",value:"{{id}}", class: 'mediaItemChk', mediaName:"{{name}}", mediaUrl:"{{url}}", mediaType:"{{type}}", mediaDuration:"{{duration}}"
              div class:"col-xs-9 ", ->
                b class:"col-xs-2 typepic ty{{type}}", ->
                span class:"col-xs-8 mediaName", mediaType:'{{type}}', title:'{{name}}', -> '{{name}}'
            td  -> '{{displayType}}'
            td -> '{{duration}}'
            td class:'mediaParent ',style:'display:none', ->
              b class:"col-xs-2 typepic tyfolder", ->
              span class:"col-xs-9 mediaParent displayName-parent ", mediaType:'{{type}}', title:'{{mediaParentName}}', -> '{{mediaParentName}}'
          script type:"text/template", id:"mediaNavTemplate", style:"display:none", ->
            a href:'',currentId:'{{id}}', class :"curpointer", title:"{{name}}", -> '{{displayName}}'

          div class:"col-xs-offset-9 diabtnfix", ->
            button type:"button",  class:"btn btn-primary ",id:"btnEditSceneAdd", editType:'', onclick:'addMedia(this)', ->
              text '确定'
            button type:"button", class:"btn btn-default gap", 'data-dismiss':"modal",->
              text '关闭'
  div class:"modal fade", id:"mediaItemModal", 'tabindex':"-1", 'role':"dialog", 'aria-labelledby':"mediaItemLabel", 'aria-hidden':"true", ->
    div class:"modal-dialog", ->
      div class:"modal-content", ->
        div class:"modal-header", ->
          button type:"button",class:"close",'data-dismiss':"modal",'aria-hidden':"true", ->
            text '&times;'
          h4 class:"modal-title", id:"mediaItemLabel", ->
            text '设置持续时间'
        div class:"modal-body", ->
          div  class:"input-group", style:'margin-bottom:10px',->
            div class:"input-group col-xs-4", ->
              span class:"input-group-addon", ->'时：'
              input type:"text", class:"form-control", id:"txtItemDurationHour", placeholder:"请输入小时", ->
            div class:"input-group col-xs-4", ->
              span class:"input-group-addon", ->'分：'
              input type:"text", class:"form-control", id:"txtItemDurationMin", placeholder:"请输入分钟", ->
            div class:"input-group col-xs-4", ->
              span class:"input-group-addon", ->'秒：'
              input type:"text", class:"form-control", id:"txtItemDurationSec", placeholder:"请输入秒", ->
          div  class:"input-group",  id:'picFadeTime', style:'display:none', ->
            div class:"input-group col-xs-6", ->
              span class:"input-group-addon", ->'渐入：'
              input type:"text", class:"form-control", id:"txtItemFadeIn", placeholder:"请输入渐入时间", ->
            div class:"input-group col-xs-6", ->
              span class:"input-group-addon", ->'渐出：'
              input type:"text", class:"form-control", id:"txtItemFadeOut", placeholder:"请输入渐出时间", ->
        div class:"modal-footer", ->
          div class:"col-xs-offset-9 diabtnfix", ->
            button type:"button",  class:"btn btn-primary ", onclick:'editMediaItem(this)', ->
              text '确定'
            button type:"button", class:"btn btn-default gap", 'data-dismiss':"modal",->
              text '关闭'
  div id:"nav", class :'row', ->

      span  -> '名称：'
      input type:"text",  id:"txtRelativePlaylistName", class:'form-control', style:'width:150px; display:inline-block;', placeholder:"请输入名称", ->
      button  class:'btn btn-default', style:'margin-left:5px', onclick:'saveRelativePlaylist()',->'保存'
      button class:'btn btn-default',  style:'margin-left:5px', onclick:"window.location.href='/playlist'",->'返回'

  div id:'scrolldiv', style:'margin: 0 auto; overflow: hidden; min-width:1280px;', onselectstart:'return false',->
    div class:"col-xs-2", ->
      div id:"leftdiv", class :'well well-xs',  style:'padding-bottom: 9999px; margin-bottom: -9999px;',->
        div id:"leftnav", ->
          div style:'margin-left:19px; margin-right:19px;padding-bottom:5px;',->
            img src:'/images/add.png', width:'30', height:'30',onclick:"showAddViewModal('add')", title:'添加', style:'cursor:pointer; margin-right:10px '
            img src:'/images/cancel.png', width:'30', height:'30',onclick:"delView()", title:'删除', style:'cursor:pointer; margin-right:10px '
            img src:'/images/setting.png', width:'30', height:'30',onclick:"showEditViewModal('edit')", title:'设置', style:'cursor:pointer;  margin-right:10px'
        div id:"leftside", onselectstart:'return false', ->


    div id:"main", onselectstart:'return false', class :'col-xs-8  well well-xs',style:'padding-bottom: 9999px; margin-bottom: -9999px;', ->
      div id:'toolbar', ->
        div class:'panelarea', ->

          img src:'/images/component/媒体区.png', class:'btn', style:'padding:1px; width:30px; height:30px;',  title:'媒体', type:'mediaZone', onclick:"changeDrawFlag(this, 'mediaZone')"
          img src:'/images/component/分组区.png', class:'btn', style:'padding:1px; width:30px; height:30px;',  title:'面板', type:'groupZone', onclick:"changeDrawFlag(this, 'groupZone')"


        div class :' singlearea', style:'border-right:1px solid white', ->
          img src:'/images/component/文字.png', class:'btn', style:'padding:1px; width:30px; height:30px;',  title:'文字', type:'text', onclick:"changeDrawFlag(this, 'text')"
          img src:'/images/component/时间.png', class:'btn', style:'padding:1px; width:30px; height:30px;',  title:'时间', type:'dateTime', onclick:"changeDrawFlag(this, 'dateTime')"
          img src:'/images/component/天气文字.png', class:'btn', style:'padding:1px; width:30px; height:30px;',  title:'天气文字', type:'weatherText', onclick:"changeDrawFlag(this, 'weatherText')"
          img src:'/images/component/温度.png', class:'btn', style:'padding:1px; width:30px; height:30px;',  title:'温度', type:'temperature', onclick:"changeDrawFlag(this, 'temperature')"
          img src:'/images/component/空气质量.png', class:'btn', style:'padding:1px; width:30px; height:30px;',  title:'空气质量', type:'airQualityLevel', onclick:"changeDrawFlag(this, 'airQualityLevel')"
          img src:'/images/component/PM2.5.png', class:'btn', style:'padding:1px; width:30px; height:30px;',  title:'PM2.5', type:'airQualityPm25', onclick:"changeDrawFlag(this, 'airQualityPm25')"
          img src:'/images/component/字幕.png', class:'btn', style:'padding:1px; width:30px; height:30px;',  title:'字幕', type:'marquee', onclick:"changeDrawFlag(this, 'marquee')"
          img src:'/images/component/天气图标.png', url:'/images/weatherimage/多云.png', class:'btn', style:'padding:1px; width:30px; height:30px;',  title:'多云', type:'weatherImage', onclick:"changeDrawFlag(this, 'weatherImage')"
          img src:'/images/component/时钟.png', url:'/images/clock/简单时钟.png', class:'btn', style:'padding:1px; width:30px; height:30px;', title:'时钟', index:0, type:'clock', onclick:"changeDrawFlag(this, 'clock')"
          div class:'btn-group',  ->
            div  id:'btnImageRect', class:'btn btn-default dropdown-toggle', onclick:"changePictureDrawFlag(this, 'image')", title:'普通图片', 'data-toggle':'dropdown', style:'margin-left:15px; height:30px; padding:0px;',->
              img src:'/images/component/图片.png', title:'图片', draggable:'false',  type:'image', style:'margin-left:0px'
              div style:'padding:0 5px; display:inline-block;', onclick:"showMediaList(this, 'image')", ->
                span class:"caret"
        div class :'percentarea  panelarea col-xs-2', ->
          select class :'form-control', id:"sceneratio", onchange:'scaleView(this)', style:'height:30px', ->
            option  value:'0.5',-> '50%'
            option  value:'0.6',-> '60%'
            option  value:'0.7',-> '70%'
            option  value:'0.8',-> '80%'
            option  value:'0.9',-> '90%'
            option  selected:'true', value:'1', -> '100%'
            option  value:'1.25',-> '125%'
            option  value:'1.5',-> '150%'
            option  value:'1.75',-> '175%'
            option  value:'2',-> '200%'
        div class :'panelarea', style:'border:none; border-right:1px solid #fff;',->
          img '.translateimg', src:'/images/component/鼠标箭头.png', draggable:'false',  class:'btn', onclick:'preTranslate(this)', style:'padding:1px; width:30px; height:30px;'
          img src:'/images/component/刷新.png', draggable:'false', class:'btn', onclick:'resetCvs(this)', style:'padding:1px; width:30px; height:30px;'
        div class :'panelarea', style:'border:none;',->
          img src:'/images/component/垃圾桶.png', draggable:'false', class:'btn', onclick:'removeSelectedRect()', style:'padding:1px; width:30px; height:30px;'
#          span class:"glyphicon glyphicon-move", style:'margin-left:10px',  title:'移动', onclick:'preTranslate(this)'
#          span class:"glyphicon glyphicon-refresh", style:'margin-left:10px', title:'复位', onclick:'resetCvs(this)'

        div class:'clear'

      div id:"activeArea", ->
        div class:'blankdiv'
        canvas id:'xCoord'
        canvas id:'yCoord'
        div id:"cvsarea", ->
          canvas id:'canvas'
          canvas id:'bgcanvas'
          canvas id:'coordcanvas'
          canvas id:'topcanvas', class :'topcanvas'

      coffeescript ->
        width =1280
        height = 720
        $('#cvsarea canvas').attr({'width':width,'height': height})

        p = getClientHeight() -  $('#activeArea').offset().top - 50;
        $('#cvsarea').css({'width': $('#activeArea').width() - 30 , 'height': p})


    div class:"col-xs-2", ->
      div class :'well well-xs', id:"rightdiv", ->
        ol class:"nav nav-tabs nav-justified", id:'rightsidehead', style:'font-size:8px;', ->
          li class :'active',  onclick:'showComponents()',->
            a -> '组件列表'
          li onclick:'showComponentDetail()', ->
            a -> '属性列表'

        div id:"rightside",onselectstart:'return false',  ->
          ul id:'compnentindex', ->
          div id:"detailarea"
    script type:"text/template", id:"tmplImg", ->
      li ->
        div draggable:'true', ondrop:"infoDrop(event)", onclick:"switchRect(this)", ondragstart:"infoDragStart(event)", ondrag:"infoDrag(event)", ondragend:"infoDragEnd(event)",
        ondragenter:"infoDragEnter(event)", ondragover:"infoDragOver(event)", ->
          img draggable:'false', src:"{0}"
          span ->'{1}'
    script type:"text/template", id:"tmplOther", ->
      li ->
        div draggable:'true', ondrop:"infoDrop(event)", onclick:"switchRect(this)", ondragstart:"infoDragStart(event)", ondrag:"infoDrag(event)", ondragend:"infoDragEnd(event)",
        ondragenter:"infoDragEnter(event)", ondragover:"infoDragOver(event)", ->
          b ->
          span ->'{0}'
    script type:"text/template", id:"detail", ->
      ul ->
        li class:"input-group", ->
          span class:"input-group-addon span-description", ->'标签：'
          input type:"text", class:"form-control componenttag", value:"{0}", onblur:"updateTag($(this).next().get(0))", ->
          span class:"input-group-addon", style:'cursor:pointer; display:none;',  onclick:"updateTag(this)", ->'保存'
        li class:"input-group", style:"display: none", ->
          span class:"input-group-addon span-description", ->'边框：'
          input type:"text", class:"form-control", value:"{2}", onblur:"updateBorder($(this).next().get(0))", ->
          span class:"input-group-addon", style:'cursor:pointer; display:none;',  onclick:"updateBorder(this)", ->'保存'
        li class:"input-group", ->
          span class:"input-group-addon span-description", ->'宽度：'
          input value:"{3}", type:"text", class:"form-control", onblur:"updateWidth($(this).next().get(0))", ->
          span class:"input-group-addon", style:'cursor:pointer; display:none;',  onclick:"updateWidth(this)", ->'保存'
        li class:"input-group", ->
          span class:"input-group-addon span-description", ->'高度：'
          input type:"text", class:"form-control",value:"{4}",  onblur:"updateHeight($(this).next().get(0))", ->
          span class:"input-group-addon", style:'cursor:pointer; display:none;',  onclick:"updateHeight(this)", ->'保存'
        li class:"input-group", ->
          span class:"input-group-addon span-description", ->'X坐标：'
          input type:"text", class:"form-control", value:"{5}",  onblur:"updateSx($(this).next().get(0))", ->
          span class:"input-group-addon", style:'cursor:pointer; display:none;',  onclick:"updateSx(this)", ->'保存'
        li class:"input-group", ->
          span class:"input-group-addon span-description", ->'Y坐标：'
          input type:"text", class:"form-control", value:"{6}",  onblur:"updateSy($(this).next().get(0))", ->
          span class:"input-group-addon", style:'cursor:pointer; display:none;',  onclick:"updateSy(this)", ->'保存'
        li class:"input-group libg", ->
          span class:"input-group-addon span-description", ->'背景色：'
          input value:"{1}", type:"text", class:"form-control", onfocus:'$(this).blur()', class:"txtBgColor", ->

    script type:"text/template", id:"tmplMediaEles", ->
      div  style:'width:110px; display:inline-block; margin-left:5px;',  ->
        div class: 'panel panel-default ',  onclick:'selectMediaEle(event, this)', mediaType:'{2}', 'data-id':'{4}', 'data-name':'{3}', ->
          div class: 'panel-heading', ->
            h3 class:'panel-title text-center', -> '{0}'
          div class: 'panel-body ', width:'100', height:'100', style:'padding:0', ->
            img src:'{1}', title:'{3}', class :'pull-center',width:'100%', height:'100',
    script type:'text/template', id:'tmplPreview', ->
      div class: 'panel panel-default ', index:'{0}', onclick:"switchView(this)", ->
        div class: 'panel-heading', ->
          h3 class:'panel-title', ->
            span class :'span-sceneindex', -> '{1}'
            span class :'col-xs-offset-4 span-duration', -> '{2}'
        div class: 'panel-body ', style:'padding:0; clear:both;', ->
          canvas  style:"width: 100%", ->
    script type:'text/template', id:'tmplPlaylistsLink', ->
      li class:"input-group", ->
        span class:"input-group-addon  span-description", ->'持续时间：'
        input value:"{0}",  readonly:'readonly', type:"text", class:"form-control",  ->
      li class:"input-group", ->
        span class:"input-group-addon  span-description", ->'媒体列表：'
        input value:"{1}", readonly:'readonly',  type:"text", class:"form-control",  ->
        span class:"input-group-addon", style:'cursor:pointer', onclick:"showMediaPlaylists()",->'编辑'
    div style:"display: none", id:"tmplText", ->
      li  class:"input-group",->
        span class:"input-group-addon span-description", -> '字体颜色：'
        input value:"{0}",  type:"text", class:"form-control", onfocus:'$(this).blur()', class:"txtForeColor", ->
      li  class:"input-group",->
        span class:"input-group-addon span-description", -> '字体大小：'
        input value:"{1}",  type:"text", class:"form-control", onblur:"updateFontSize($(this).next().get(0))", ->
        span class:"input-group-addon", style:'cursor:pointer; display:none;', onclick:"updateFontSize(this)", ->'保存'
      li class:"input-group",->
        span class:"input-group-addon  span-description", -> '文字字体：'
        select class:"selFontFamily form-control", onchange:'updateFontFamily(this)', ->
          #option  value:'Arial', -> 'Arial'
          #option style:'font-family: Verdana', value:'Verdana', -> 'Verdana'
          #option style:'font-family: Georgia', value:'Georgia', -> 'Georgia'
          #option style:'font-family: Times New Roman', value:'Times New Roman', -> 'Times New Roman'
          #option style:'font-family: Courier New', value:'Courier New', -> 'Courier New'
          #option style:'font-family: Impact', value:'Impact', -> 'Impact'
          #option style:'font-family: Comic Sans MS', value:'Comic Sans MS', -> 'Comic Sans MS'
          #option style:'font-family: Tahoma', value:'Tahoma', -> 'Tahoma'
          #option style:'font-family: Garamond', value:'Garamond', -> 'Garamond'
          #option style:'font-family: Lucida Console', value:'Lucida Console', -> 'Lucida Console'
          option  value:'宋体', -> '宋体'
          option style:'font-family: 微软雅黑', value:'微软雅黑',-> '微软雅黑'
          option style:'font-family: 黑体', value:'黑体',-> '黑体'
          option style:'font-family: 楷体', value:'楷体', -> '楷体'
      li class:"input-group",->
        span class:"input-group-addon  span-description", -> '文字：'
        input value:"{3}",  type:"text", class:"form-control txtValue", onblur:"updateText($(this).next().get(0))", ->
        span class:"input-group-addon", style:'cursor:pointer; display:none;', onclick:"updateText(this)", ->'保存'
    script type:'text/template', id:'tmplDateTime', ->
      select class :'form-control selDateTime', onchange:'updateDateTimeStyle(this)', ->
        option selected:'true', -> 'yyyy-MM-dd HH:mm:ss'
        option -> 'yyyy-MM-dd HH:mm'
        option -> 'yyyy-MM-dd'
        option -> 'yyyy年MM月dd日 HH:mm:ss'
        option -> 'yyyy年MM月dd日 HH:mm'
        option -> 'yyyy年MM月dd日'
        option -> 'yyyy/MM/dd HH:mm:ss'
        option -> 'yyyy/MM/dd HH:mm'
        option -> 'yyyy/MM/dd'
        option -> 'HH:mm:ss'
        option -> 'HH:mm'
        option -> '周一'
  script type:'text/template', id:'tmplWhichDay', ->
    select class :'form-control selWhichDay',  onchange:'updateWhichDay(this)', ->
      whichData = ['今天', '明天', '后天']
      (option value: "#{each + 1}" , -> "#{whichData[each]}") for each in [0..2]
  script type:'text/template', id:'tmplTempStyle', ->
    select class :'form-control selTempStyle',  onchange:'updateTempStyle(this)', ->
      tempStyle = [
        {value: 'max', type: '最高'},
        {value: 'min', type: '最低'}
      ]
      (option value: "#{each.value}" , -> "#{each.type}") for each in tempStyle
  script type:'text/template', id:'tmplDirection', ->
    select class :'form-control selDirection',  onchange:'updateDirection(this)', ->
      option value:'leftToRight', -> '从左到右'
      option value:'rightToLeft', -> '从右到左'

  script type:'text/template', id:'tmplSpeed', ->
    select class:"selSpeed form-control", onchange:'updateSpeed(this)', ->
      (option value: "#{each}", -> "#{each}") for each in [1..10]

  script type:'text/template', id:'tmplClockStyle', ->
    select class:"selClockStyle form-control", onchange:'updateClockStyle(this)', ->
      clockData = ['简单时钟', '复杂时钟', '黑色时钟', '白色时钟']
      (option value: "#{each}", -> "#{each}") for each in clockData


block 'lazyscript', ->
  coffeescript ->
    #$('#leftside, #rightside').height($('#scrolldiv').height())
    @cvs = document.getElementById('canvas')
    @ctx = cvs.getContext('2d')
    @tempCvs = document.getElementById('topcanvas')
    @tempCtx = tempCvs.getContext('2d')
    @bgCvs = document.getElementById('bgcanvas')
    @bgCtx = bgCvs.getContext('2d')
    @coordCvs = document.getElementById('coordcanvas')
    @coordCtx = coordCvs.getContext('2d')
    @WIDTH = cvs.width * 1.0
    @HEIGHT = cvs.height * 1.0
    @RATIO = 1
    @TRANSLATE = {x:0, y:0};
    @GRIDEWIDTH = 10
    @viewIndex = 0
    @relativePlaylist = { name:'relativePlaylist', type:'relativePlaylist', stamp:new Date().getTime(), children:[]}
    @mediaSourceList = []

  script src:"/js/playlist/edit/initcvs.js"
  script src:"/js/playlist/edit/helper.js"
  script src:"/js/playlist/edit/drawrect.js"
  script src:"/js/playlist/edit/dragrect.js"
  script src:"/js/playlist/edit/changeindex.js"
  script src: '/js/moment.js'
  script src:"/js/zh-cn.js"
  script src:"/js/media.js"
  script src:"/js/playlist/edit/edit.js"
  script src:"/js/playlist/edit/view.js"
  coffeescript ->
    initCoord()
    if playlistId then  initReplaylistData() else addView()

