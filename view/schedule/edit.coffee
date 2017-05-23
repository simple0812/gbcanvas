extend "layout"
block 'title', ->
  title '新建/编辑'
block 'style', ->
  link href:"/css/bootstrap-datetimepicker.css", rel:"stylesheet"

block 'main', ->
  coffeescript ->
    @isSave = false;
    window.onbeforeunload = ->
      return ('确认离开吗?未保存的数据将丢失') unless(isSave)

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

#  div class:"modal fade", id:"returnModal", role:"dialog", 'aria-hidden':"true", ->
#    div class:"modal-dialog", ->
#      div class:"modal-content", ->
#        div class:"modal-header", ->
#          button class:"close", 'data-dismiss':"modal", 'aria-hidden':"true", ->
#            text '&times;'
#          h4 class:"modal-title", ->
#            text '返回'
#        div class:"modal-body", ->
#          div class:'col-xs-offset-4', ->
#            h3 ->
#              text "是否确定返回"
#        div class:"modal-footer", ->
#          button class:"btn btn-primary", id: 'returnComfirmBtn', -> '确定'
#          button class:"btn btn-default", 'data-dismiss':"modal", -> '关闭'

  div id: 'scheduleEdit', value:"#{@id}", ->
    div class:" well well-sm fix-top-2", ->
      div class: 'container fixed-width', ->
        div class:"input-group col-xs-3 ",  ->
          span class:"input-group-addon", style:'background-color: transparent;border:0', -> '名称:'
          input type:"text", class:"form-control", id:'name', placeholder:"排期名称", ->
        div class: "col-xs-9 ",->
          button type:"button",  class:"btn btn-default", id:'save', ->
            span class:"glyphicon glyphicon-folder-close", ->
            text ' 保存'
          button type:"button", class:"btn btn-default gap", id:'saveAndPublish',  ->
            span class:"glyphicon glyphicon-move", ->
            text ' 保存并发布'
          button type:"button", class:"btn btn-default gap",  id:'returnComfirmBtn',onclick:"location.href = '/schedule';", ->
            text ' 返回'
#          button type:"button", class:"btn btn-default gap",  id:'return', ->
#            text ' 返回'

    div class: 'container fix-top-2-tablelist-default fixed-width', ->
      div class: 'panel panel-default', ->
        div class: 'panel-heading', ->
          label -> '排期'
        div class: 'panel-body', ->
          div class: 'col-xs-4',  ->
            label for:"selecttest",->'播放列表'
            select class:'form-control',id:'children',->
          div class: 'col-xs-2',  ->
            label for:"radiogroup",->'排期类型'
            div id:'type', ->
              div class:"radio", ->
                input type:"radio", name:"optionsRadios", class :"scheduleType",id:"everyday", value:"everyday", 'checked':"true", ->
                label for:"everyday",-> '每天'
              div class:"radio", ->
                input type:"radio", name:"optionsRadios", class :"scheduleType",id:"everyweek", value:"everyweek",  ->
                label for:"everyweek",-> '每周'
              div class:"radio", ->
                input type:"radio", name:"optionsRadios", class :"scheduleType",id:"everymonth", value:"everymonth", ->
                label for:"everymonth",-> '每月'
              div class:"radio", ->
                input type:"radio",name:"optionsRadios", class :"scheduleType",id:"once", value:"once", ->
                label for:"once",-> '一次'

          div class: 'col-xs-6', id: 'detail',  ->
            label for:"date",->'排期时间'

            div class :"row",id:'month',style:"display:none", ->
              div class:"input-group ", ->
                span class:"input-group-addon input-group-addon-format", ->'每月:'
                select class:'form-control',id:'selectMonthday', ->
                  option ->'请选择每月需要的日期'
                  option ->'01'
                  option ->'02'
                  option ->'03'
                  option ->'04'
                  option ->'05'
                  option ->'06'
                  option ->'07'
                  option ->'08'
                  option ->'09'
                  option ->'10'
                  option ->'11'
                  option ->'12'
                  option ->'13'
                  option ->'14'
                  option ->'15'
                  option ->'16'
                  option ->'17'
                  option ->'18'
                  option ->'19'
                  option ->'20'
                  option ->'21'
                  option ->'22'
                  option ->'23'
                  option ->'24'
                  option ->'25'
                  option ->'26'
                  option ->'27'
                  option ->'28'
                  option ->'29'
                  option ->'30'
                  option ->'31'
              #            br ->
              div class :"row",id:"monthDay", ->
            div class :"row",id:'week', style:"display:none", ->
              div ->
                button class:"btn btn-default gap weekday",onclick:"weekday(this)", 'day':"1", ->'周一'
                button class:"btn btn-default gap weekday",onclick:"weekday(this)", 'day':"2",  ->'周二'
                button class:"btn btn-default gap weekday",onclick:"weekday(this)", 'day':"3", ->'周三'
                button class:"btn btn-default gap weekday",onclick:"weekday(this)", 'day':"4",  ->'周四'
                button class:"btn btn-default gap weekday",onclick:"weekday(this)", 'day':"5",  ->'周五'
                button class:"btn btn-default gap weekday",onclick:"weekday(this)", 'day':"6",  ->'周六'
                button class:"btn btn-default gap weekday",onclick:"weekday(this)", 'day':"7",  ->'周日'
#              br ->
            div class :"row", id:"date",  style:"display:none",->
                div class:"input-group ", ->
                  span class:"input-group-addon input-group-addon-format", ->'日期:'
                  input type:"text", class:"form-control", placeholder:"开始日期",'readonly':'readonly',id:"startDate", onclick:"datePick('#startDate','#endDate',true)",onfocus:"$(this).blur()", ->
                  span class:"input-group-addon curpointer",onclick:"clearDateTime('#startDate')", ->
                    span class:"glyphicon glyphicon-remove ", ->
                  span class:"input-group-addon input-group-addon-format", ->'至'
                  input type:"text", class:"form-control ", placeholder:"结束日期",'readonly':'readonly', id:"endDate", onclick:"datePick('#endDate','#startDate',false)",onfocus:"$(this).blur()", ->
                  span class:"input-group-addon curpointer",onclick:"clearDateTime('#endDate')",  ->
                    span class:"glyphicon glyphicon-remove ", ->
              br ->
            div class :"row", id:"time", ->
              div class:"input-group ", ->
                span class:"input-group-addon input-group-addon-format", ->'时间:'
                input type:"text", class:"form-control", placeholder:"开始时间",'readonly':'readonly',id:"startTime", onclick:"timePick('#startTime','#endTime',true)",onfocus:"$(this).blur()", ->
                span class:"input-group-addon curpointer",onclick:"clearDateTime('#startTime')", ->
                  span class:"glyphicon glyphicon-remove ", ->
                span class:"input-group-addon input-group-addon-format", ->'至'
                input type:"text", class:"form-control ", placeholder:"结束时间",'readonly':'readonly', id:"endTime", onclick:"timePick('#endTime','#startTime',false)",onfocus:"$(this).blur()", ->
                span class:"input-group-addon curpointer",onclick:"clearDateTime('#endTime')",  ->
                  span class:"glyphicon glyphicon-remove ", ->
              br ->

  script type:'text/template', id:'box-template', style: 'display: none', ->
    td class:"col-xs-3",   ->
      span class:"col-xs-1 ", ->
        input type:"checkbox",value:"{{id}}"
      div ->
        span class:"name displayName",  title:'{{name}}', style:'width:100px;', -> '{{name}}'
    td class:"col-xs-3", ->
      span class:'td-alias displayName', -> '{{alias}}'
    td class:"col-xs-3", -> '{{ip}}'
    td class:"col-xs-3 text-center", ->
      span class: '{{online}}'

  script type:'text/template', id: 'group-template', style: 'display: none', ->
    td ->
      span class: 'col-xs-1', ->
        input type: 'checkbox', value: "{{id}}"
      div ->
        span class: 'name displayName', title:"{{name}}", -> "{{name}}"

  script type:"text/template", id:"monthDayItemTemplate", style:"display:none", ->
    div class:"input-group col-xs-3 ", ->
      input type:"text", class:"form-control", 'readonly':'readonly',onfocus:"$(this).blur()",value:'{{name}}', ->
      span class:"input-group-addon curpointer ", ->
        span class:"glyphicon glyphicon-remove ", ->

block 'lazyscript', ->
  script src:"/js/bootstrap-datetimepicker.js"
  script src:"/js/bootstrap-datetimepicker.zh-CN.js"
  script src: '/js/playlist/model/playlist.js'
  script src: '/js/schedule/model/schedule.js'
  script src: '/js/box/model/box.js'
  script src: '/js/box/model/group.js'
  script src: '/js/gbvision.js'
  script src: '/js/schedule/view/publish.js'
  script src: '/js/schedule/view/edit.js'
