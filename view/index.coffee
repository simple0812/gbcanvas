extend "layout"
block 'title', ->
  title '首页'
block 'style', ->
#  link href:"css/style.css", rel:"stylesheet"
#block 'toolbar', ->
#  div class:"navbar navbar-default  ", role:"navigation", ->
#    div class:"container fixed-top", ->
#      div class:"navbar-header", ->
#        a class:"navbar-brand", href:"#", ->'公告系统 © 上海金桥信息股份有限公司 2014'
block 'main', ->
  div id:"goTop", ->
  div class:"panel panel-primary",  id:'indexHead',style:"min-width:1280px;", ->
    div class :" text-center  panel-heading ", ->
      div class:"container fixed-width", ->
        h1 id:"indexLogo", ->'GBVISION'
        p id:"indexName", ->
          text '多媒体信息发布系统'
          span id:"indexVer", -> ' R3'
        p id:"indexText", onclick:"location.href='/images/OperationManual/GBVISION_manual.pdf'", ->'操作指南文档'
  div class :"container fix-top-2-tablelist-index fixed-width", ->
    h1 ->'操作指南'
    hr class:"hr-color", ->
    div class : "row", ->
#      div class :"col-xs-3", style:"position:fixed;z-index:1030", ->
      div class :"col-xs-4", ->
        ul class :"list-unstyled",->
          li ->
            a href:"#_1", ->'1.用户操作'
          li ->
            a href:"#_1_1", class :"indent1", ->'1.1.使用环境' #登录，
          li ->
            a href:"#_1_2", class :"indent1", ->'1.2.登录' #登录，
          li ->
            a href:"#_1_3", class :"indent1", ->'1.3.修改个人信息' #用户信息，修改
          li ->
            a href:"#_2" ,->'2.媒体库'
          li ->
            a href:"#_2_1", class :"indent1", ->'2.1.上传媒体文件' #新建
          li ->
            a href:"#_2_2", class :"indent1", ->'2.2.打包上传图片' #新建
          li ->
            a href:"#_2_3", class :"indent1", ->'2.3.新建文件夹' #移动，编辑
          li ->
            a href:"#_2_4", class :"indent1", ->'2.4.移动' #删除
          li ->
            a href:"#_2_5", class :"indent1", ->'2.5.删除' #搜索
          li ->
            a href:"#_2_6", class :"indent1", ->'2.6.其他' #搜索
          li ->
            a href:"#_2_7", class :"indent1", ->'2.7.搜索' #搜索
          li ->
            a href:"#_2_8", class :"indent1", ->'2.8.排序' #搜索
          li ->
            a href:"#_2_9", class :"indent1", ->'2.9.编辑' #搜索
          li ->
            a href:"#_3" ,->'3.播放列表'
          li ->
            a href:"#_3_1", class :"indent1", ->'3.1.播放列表查看（列表）' #新建，复制
          li ->
            a href:"#_3_2", class :"indent1", ->'3.2.播放列表新建、编辑' #新建，复制
          li ->
            a href:"#_3_2_1", class :"indent2", ->'3.2.1.场景设置' #编辑
          li ->
            a href:"#_3_2_2", class :"indent2", ->'3.2.2.组件列表' #编辑
          li ->
            a href:"#_3_3", class :"indent1", ->'3.3.组件' #删除
          li ->
            a href:"#_3_3_1", class :"indent2", ->'3.3.1.添加组件' #删除
          li ->
            a href:"#_3_3_2", class :"indent2", ->'3.3.2.媒体区域' #删除
          li ->
            a href:"#_3_3_3", class :"indent2", ->'3.3.3.分组区域' #删除
          li ->
            a href:"#_3_3_4", class :"indent2", ->'3.3.4.文本区域' #删除
          li ->
            a href:"#_3_3_5", class :"indent2", ->'3.3.5.时间（文字）' #删除
          li ->
            a href:"#_3_3_6", class :"indent2", ->'3.3.6.天气（文字）' #删除
          li ->
            a href:"#_3_3_7", class :"indent2", ->'3.3.7.气温（文字）' #删除
          li ->
            a href:"#_3_3_8", class :"indent2", ->'3.3.8.空气质量' #删除
          li ->
            a href:"#_3_3_9", class :"indent2", ->'3.3.9.PM2.5' #删除
          li ->
            a href:"#_3_3_10", class :"indent2", ->'3.3.10.字幕' #删除
          li ->
            a href:"#_3_3_11", class :"indent2", ->'3.3.11.天气（图标）' #删除
          li ->
            a href:"#_3_3_12", class :"indent2", ->'3.3.12.时钟（图标）' #删除
          li ->
            a href:"#_3_3_13", class :"indent2", ->'3.3.13.普通图片' #删除
          li ->
            a href:"#_3_3_14", class :"indent2", ->'3.3.14.场景缩放' #删除
          li ->
            a href:"#_3_3_15", class :"indent2", ->'3.3.15.删除' #删除
          li ->
            a href:"#_3_4", class :"indent1", ->'3.4.离开页面' #编辑
          li ->
            a href:"#_4" ,->'4.排期'
          li ->
            a href:"#_4_1", class :"indent1", ->'4.1.排期列表' #排期
          li ->
            a href:"#_4_2", class :"indent1", ->'4.2.排期编辑' #编辑，发布，重命名
          li ->
            a href:"#_4_3", class :"indent1", ->'4.3.排期发布' #删除
          li ->
            a href:"#_5" ,->'5.播放器'
          li ->
            a href:"#_5_1", class :"indent1", ->'5.1.新建播放器' #新建
          li ->
            a href:"#_5_2", class :"indent1", ->'5.2.播放器分组' #编辑
          li ->
            a href:"#_5_3", class :"indent1", ->'5.3.播放器设置' #删除
          li ->
            a href:"#_5_4", class :"indent1", ->'5.4.播放器控制' #删除
          li ->
            a href:"#_6" ,->'6.任务'
          li ->
            a href:"#_7" ,->'7.设置'
          li ->
            a href:"#_8" ,->'8.用户'
          li ->
            a href:"#_8_1", class :"indent1", ->'8.1.新建用户' #删除
          li ->
            a href:"#_8_2", class :"indent1", ->'8.2.用户管理' #删除
          li ->
            a href:"#_9" ,->'9.日志'

#      div class :"col-xs-9 col-xs-offset-3", ->
      div class :"col-xs-8 ", ->
        h2 id:"_1",->'1.用户操作'
        br ->

        h3 id:"_1_1",->'1.1.使用环境'
        br ->
        p -> 'GBVISION多媒体信息发布系统，是分别支持IE10,11,FIREFOX及CHROME浏览器。'
        br ->
        h3 id:"_1_2",->'1.2.登录'
        br ->
        p -> '打开浏览器，在地址栏输入网站的IP地址与端口号，登录界面如图1-2-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/01login/01Login.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图1-2-1'
        p ->'【用户名】文本输入框：输入用户的登录账号。'
        p ->'【密码】文本输入框：用户的登录密码。'
        p ->'【登录】按钮：点击该按钮，可以激发系统对输入的用户名和密码进行匹配验证。'
        p ->'如果验证通过，那么系统就自动进入GBVISION管理系统操作界面；否则给出提示信息。'
        br ->
        p -> '普通用户登录如图1-2-2所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/01login/02LoginNormal.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图1-2-2'
        br ->
        p -> '管理员登录如图1-2-3所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/01login/03LoginAdmin.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图1-2-3'
        p ->'点击【退出】按钮，退出登录，回到登录界面。'
        br ->
        h3 id:"_1_3",->'1.3.修改个人信息'
        br ->
        p -> '点击【用户名】出现用户操作菜单，如图1-3-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/01login/04UserInfo.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图1-3-1'
        br ->
        p ->'点击【修改个人信息】按钮弹出修改个人信息对话框，如图1-3-2所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/01login/05UserModify.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图1-3-2'
        p ->'在【修改个人信息】对话框当中可以修改用户的密码，以及添加个人注释。'
        br ->


        h2 id:"_2",->'2.媒体库'
        br ->
        p -> '点击上方导航栏的【媒体库】按钮进入媒体库页面，如图2-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/02media/01MediaIndex.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图2-1'
        br ->

        h3 id:"_2_1",->'2.1.上传媒体文件'
        br ->
        p -> '点击【上传文件】按钮弹出上传对话框，如图2-1-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/02media/02MediaUpload.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图2-1-1'
        p ->'选择文件，并点击【打开】按钮后开始上传。'
        br ->

        h3 id:"_2_2",->'2.2.打包上传图片'
        br ->
        p -> '点击【打包上传图片】按钮，弹出上传并打包图片对话框，如图2-2-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/02media/02MediaUploadZip1.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图2-2-1'
        br ->
        p ->'点击【选择需上传的图片】选择所要上传的图片，选中图片后，会显示选中的图片的列表以及【请输入压缩包名】输入框，在输入框中填入压缩包名，点击上传，即可打包上传图片，如图2-2-2所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/02media/02MediaUploadZip2.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图2-2-2'
        p ->'上传成功后，会有打包上传成功的提示。'
        br ->

        h3 id:"_2_3", ->'2.3.新建文件夹'
        br ->
        p -> '点击【新建文件夹】按钮弹出新建文件夹对话框，如图2-3-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/02media/03MediaNewFolder.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图2-3-1'
        p ->'在文本框内输入文件夹名称后，点击【确定】按钮，验证通过则新建成功。'
        p ->'点击【关闭】按钮或【X】图标，关闭对话框。'
        p ->'备注：文件夹名不能为空，字数不能超过50字,并且不能含有（<>\*\?:\^|"）'
        br ->

        h3 id:"_2_4", ->'2.4.移动'
        br ->
        p -> '选择某些媒体元素的选择框，点击上方【移动】按钮；或者直接点击某个媒体元素的【移动】按钮，弹出对话框，如图2-4-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/02media/04MediaMove.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图2-4-1'
        p ->'点击【＋】【－】图标可以展开或者收起文件夹。'
        p ->'点击某个文件夹（背景变蓝）为选中文件夹。'
        p ->'点击【确定】完成移动。'
        br ->

        h3 id:"_2_5", ->'2.5.删除'
        br ->
        p -> '选择某些媒体元素的选择框，点击上方【删除】按钮；或者直接点击某个媒体元素的【删除】按钮，弹出对话框，如图2-5-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/02media/05MediaDelete.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图2-5-1'
        br ->
        p ->'点击【确定】完成删除。'
        br ->

        h3 id:"_2_6", ->'2.6.其他'
        br ->
        p -> '点击上方【其他】按钮，出现下拉框，如图2-6-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/02media/06MediaButtonOther.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图2-6-1'
        br ->
        p ->'点击【其他】中的【添加网页】按钮弹出添加网页对话框，如图2-6-2所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/02media/07MediaAddWebpage.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图2-6-2'
        p ->'在对应的输入框中，输入指定的内容，点击【确定】按钮触发验证，通过后完成添加网页。'
        p ->'备注：验证名称与媒体文件一致，服务器地址一定要符合规范才能通过验证。'
        br ->

        p -> '点击【其他】中的【添加流媒体】按钮弹出对话框，如图2-6-3所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/02media/08MediaAddStream.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图2-6-3'
        p ->'其他操作与添加网页类似'
        br ->

        h3 id:"_2_7", ->'2.7.搜索'
        br ->
        p -> '在【搜索】对应的输入框中输入文字即可触发搜索，如图2-7-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/02media/09MediaSearch.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图2-7-1'
        br ->
        p -> '当搜索的内容存在时，则能显示搜索结果，并能找到搜索结果所在目录。如图2-7-2所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/02media/09MediaSearch02.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图2-7-2'
        br ->

        h3 id:"_2_8", ->'2.8.排序'
        br ->
        p -> '点击表的列名（如：【大小】）可以触发对应列的排序，如图2-8-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/02media/10MediaSortAsc.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图2-8-1'
        br ->


        h3 id:"_2_9", ->'2.9.编辑'
        br ->
        p -> '点击列表某个元素的【重命名】可以弹出重命名对话框（除了流媒体和网页），如图2-9-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/02media/12MediaRename.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图2-9-1'
        br ->

        p -> '点击列表某个元素的【编辑】按钮，可以弹出重命名对话框（仅流媒体和网页），如图2-9-2所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/02media/13MediaRenameWebStream.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图2-9-2'
        br ->

        h2 id:"_3",->'3.播放列表'
        br ->
        p -> '点击上方导航栏【播放列表】进入播放列表页面，如图3-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/03playlist/01PlaylistIndex.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图3-1'
        br ->

        h3 id:"_3_1", ->'3.1.播放列表查看（列表）'
        br ->
        p -> '点击【新建】按钮进入播放列表（新建）页面，如3.2所示。'
        p -> '点击【编辑】按钮进入播放列表（编辑）页面，如3.2所示。'
        p -> '【搜索】按钮和【删除】按钮与媒体库搜索和删除类似。'
        p -> '点击【复制】按钮复制播放列表，如图3-1-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/03playlist/02PlaylistCopy.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图3-1-1'
        br ->

        h3 id:"_3_2", ->'3.2.播放列表新建、编辑'
        br ->
        p -> '在播放列表首页点击【新建】【编辑】按钮后进入播放列表编辑页面，如图3-2-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/03playlist/03PlaylistEditIndex.png",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图3-2-1'
        br ->

        h4 id:"_3_2_1", ->'3.2.1.场景设置'
        br ->
        p -> '在播放列表编辑页面【添加场景】【编辑场景】图标按钮，进入场景设置界面，如图3-2-1-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/03playlist/04PlaylistSceneAdd.png", onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图3-2-1-1'
        p -> '点击【背景颜色】按钮后面输入框，可以设置场景背景颜色。'
        p -> '点击【背景图片】按钮后面输入框，可以设置场景背景图片。'
        p -> '点击【持续时间】按钮后面输入框，分别对应时、分、秒，最大分别为（23时，59分，59秒）可以设置场景背景图片。'
        p -> '点击【分辨率】按钮后面输入框，可以设置场景的分辨率。'
        p -> '选中某个场景后，点击【删除场景】按钮可以删除某个场景。'
        br ->

        h4 id:"_3_2_2", ->'3.2.2.组件列表'
        br ->
        p -> '在场景中添加了组件之后可以在右侧组件列表中查看，如图3-2-2-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/03playlist/22PlaylistElList.png", onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图3-2-2-1'
        p -> '可以点击组件列表选中某个组件。'
        p -> '可以拖动某个组件的位置改变组件之间层级关系。'
        br ->

        h3 id:"_3_3", ->'3.3.组件'
        br ->
        p -> '在中间场景区域的操作都为组件操作，下面简单介绍一下每个操作：'
        p -> '注1：组件在场景内支持部分键盘事件，可以用方向键移动组件、enter键确定修改、delete键删除组件。'
        p -> '注2：组件与组件有一定的碰撞规则：'
        p class:"indent1", -> '媒体区域不能和任何组件重合。'
        p class:"indent1", -> '分组区域不能和媒体区域重合。'
        p class:"indent1", -> '分组区域1不能和分组区域2重合。'
        p class:"indent1", -> '普通组件进入分组区域自动被加入分组区域，并且截掉超出区域内容的显示。'
        p -> '所有组件如图3-3-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/03playlist/22PlaylistCMALL.png", onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图3-3-1'
        p -> '各个图标含义：'
        div class:'row', ->
          div class :"col-xs-6",->
            dl class: "dl-horizontal", ->
              dt ->
                img src:"/images/OperationManual/03playlist/22PlaylistDtMedia.png", onerror:"this.src = '/images/default.jpg'", ->
              dd  ->'添加媒体区域'
              dt ->
                img src:"/images/OperationManual/03playlist/22PlaylistDtWeatherText.png", onerror:"this.src = '/images/default.jpg'", ->
              dd  ->'添加天气文字'
              dt ->
                img src:"/images/OperationManual/03playlist/22PlaylistDtMarquee.png", onerror:"this.src = '/images/default.jpg'", ->
              dd  ->'添加字幕'
              dt ->
                img src:"/images/OperationManual/03playlist/22PlaylistDtText.png", onerror:"this.src = '/images/default.jpg'", ->
              dd  ->'添加文字'
              dt ->
                img src:"/images/OperationManual/03playlist/22PlaylistDtAQI.png", onerror:"this.src = '/images/default.jpg'", ->
              dd  ->'添加空气质量'
              dt ->
                img src:"/images/OperationManual/03playlist/22PlaylistDtClock.png", onerror:"this.src = '/images/default.jpg'", ->
              dd  ->'添加时钟图标'
          div class :"col-xs-6", ->
            dl class: "dl-horizontal", ->
              dt ->
                img src:"/images/OperationManual/03playlist/22PlaylistDtGroup.png", onerror:"this.src = '/images/default.jpg'", ->
              dd  ->'添加分组区域'
              dt ->
                img src:"/images/OperationManual/03playlist/22PlaylistDtTemperatureText.png", onerror:"this.src = '/images/default.jpg'", ->
              dd  ->'添加温度'
              dt ->
                img src:"/images/OperationManual/03playlist/22PlaylistDtWeatherPic.png", onerror:"this.src = '/images/default.jpg'", ->
              dd  ->'添加天气图标'
              dt ->
                img src:"/images/OperationManual/03playlist/22PlaylistDtTime.png", onerror:"this.src = '/images/default.jpg'", ->
              dd  ->'添加时间'
              dt ->
                img src:"/images/OperationManual/03playlist/22PlaylistDtPM25.png", onerror:"this.src = '/images/default.jpg'", ->
              dd  ->'添加PM2.5指标'
              dt ->
                img src:"/images/OperationManual/03playlist/22PlaylistDtNormalPic.png", onerror:"this.src = '/images/default.jpg'", ->
              dd  ->'添加图片'
        br ->

        h4 id:"_3_3_1", ->'3.3.1.添加组件'
        br ->
        p -> '可以拖动某个组件，向场景中添加组件，如图3-3-1-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/03playlist/05PlaylistAddMediaZoneDrag.png", onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图3-3-1-1'
        p -> '拖动添加组件时，组件拥有一个默认边框确认大小；'
        br ->
        p -> '选中某个组件时，可以在场景中画出组件，如图3-3-1-2所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/03playlist/06PlaylistAddMediaZonePaint.png", onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图3-3-1-2'
        br ->

        h4 id:"_3_3_2", ->'3.3.2.媒体区域'
        br ->
        p -> '媒体区域包含属性，如图3-3-2-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/03playlist/07PlaylistMediaZoneAttr.png", onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图3-3-2-1'
        p -> '【标签】用于标记区域名称方便在组件列表中查找。'
        p -> '【宽度】用于设置区域宽度的精确值。'
        p -> '【高度】用于设置区域高度的精确值。'
        p -> '【x坐标】用于设置区域起始x坐标的精确值。'
        p -> '【y坐标】用于设置区域起始y坐标的精确值。'
        p -> '【持续时间】用于设置区域持续时间。'
        p -> '【媒体列表】用于设置媒体列表的媒体元素（从媒体库选择）,点击编辑后弹出媒体列表对话框，如图3-3-2-2所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/03playlist/08PlaylistMediaZoneEl.png", onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图3-3-2-2'
        br ->
        p -> '点击【+】图标，弹出选择媒体对话框，添加媒体元素。如果选择的类型不正确则会自动被屏蔽不会被加入列表，如图3-3-2-3所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/03playlist/09PlaylistMediaZoneElAdd.png", onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图3-3-2-3'
        br ->
        p -> '将媒体元素添加完成以后点击属性按钮，可以编辑媒体元素的持续时间，如图3-3-2-4及3-3-2-5所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/03playlist/09PlaylistMediaZoneElSetting.png", onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图3-3-2-4'
        div class:"text-center", ->
          img src:"/images/OperationManual/03playlist/09PlaylistMediaZoneElDurationSet.png", onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图3-3-2-5'
        br ->
        h4 id:"_3_3_3", ->'3.3.3.分组区域'
        br ->
        p -> '点击【分组区域】按钮，画出图案。分组区域的作用是为了使某些组件组成一个小组共同移动等，如图3-3-3-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/03playlist/10PlaylistGroupZoneAttr.png", onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图3-3-3-1'
        p -> '【标签】用于标记区域名称方便在组件列表中查找。'
        p -> '【宽度】用于设置区域宽度的精确值。'
        p -> '【高度】用于设置区域高度的精确值。'
        p -> '【x坐标】用于设置区域起始x坐标的精确值。'
        p -> '【y坐标】用于设置区域起始y坐标的精确值。'
        p -> '【背景色】用于设置区域背景色。'
        p -> '【背景图片】用于设置区域背景图片。'
        br ->

        h4 id:"_3_3_4", ->'3.3.4.文本区域'
        br ->
        p -> '文本区域是为了输入文字使用的，如图3-3-4-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/03playlist/11PlaylistTextAttr.png", onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图3-3-4-1'
        p -> '【标签】用于标记区域名称方便在组件列表中查找。'
        p -> '【宽度】用于设置区域宽度的精确值。'
        p -> '【高度】用于设置区域高度的精确值。'
        p -> '【x坐标】用于设置区域起始x坐标的精确值。'
        p -> '【y坐标】用于设置区域起始y坐标的精确值。'
        p -> '【背景色】用于设置区域背景色。'
        p -> '【字体颜色】用于设置区域字体颜色。'
        p -> '【字体大小】用于设置区域字体大小。'
        p -> '【文字字体】用于设置区域字体类型。'
        p -> '【文字】用于设置区域文字内容。'
        br ->

        h4 id:"_3_3_5", ->'3.3.5.时间（文字）'
        br ->
        p -> '时间（文字）用来展现当前时间，如图3-3-5-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/03playlist/12PlaylistTimeTextAttr.png", onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图3-3-5-1'
        p -> '【标签】用于标记区域名称方便在组件列表中查找。'
        p -> '【宽度】用于设置区域宽度的精确值。'
        p -> '【高度】用于设置区域高度的精确值。'
        p -> '【x坐标】用于设置区域起始x坐标的精确值。'
        p -> '【y坐标】用于设置区域起始y坐标的精确值。'
        p -> '【背景色】用于设置区域背景色。'
        p -> '【字体颜色】用于设置区域字体颜色。'
        p -> '【字体大小】用于设置区域字体大小。'
        p -> '【文字字体】用于设置区域字体类型。'
        p -> '【样式】用于设置时间展示的样式。'
        br ->

        h4 id:"_3_3_6", ->'3.3.6.天气（文字）'
        br ->
        p -> '天气（文字）用来展现天气，如图3-3-6-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/03playlist/13PlaylistWeatherTextAttr.png", onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图3-3-6-1'
        p -> '【标签】用于标记区域名称方便在组件列表中查找。'
        p -> '【宽度】用于设置区域宽度的精确值。'
        p -> '【高度】用于设置区域高度的精确值。'
        p -> '【x坐标】用于设置区域起始x坐标的精确值。'
        p -> '【y坐标】用于设置区域起始y坐标的精确值。'
        p -> '【背景色】用于设置区域背景色。'
        p -> '【字体颜色】用于设置区域字体颜色。'
        p -> '【字体大小】用于设置区域字体大小。'
        p -> '【文字字体】用于设置区域字体类型。'
        p -> '【文字】用于显示区域文字内容。'
        p -> '【哪天】用于设置所要展现的时间（今天，明天，后天）。'
        p -> '【城市】选择框，用于设置城市。'
        br ->

        h4 id:"_3_3_7", ->'3.3.7.气温（文字）'
        br ->
        p -> '气温（文字）用来展现气温，如图3-3-7-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/03playlist/14PlaylistTemperatureTextAttr.png", onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图3-3-7-1'
        p -> '【标签】用于标记区域名称方便在组件列表中查找。'
        p -> '【宽度】用于设置区域宽度的精确值。'
        p -> '【高度】用于设置区域高度的精确值。'
        p -> '【x坐标】用于设置区域起始x坐标的精确值。'
        p -> '【y坐标】用于设置区域起始y坐标的精确值。'
        p -> '【背景色】用于设置区域背景色。'
        p -> '【字体颜色】用于设置区域字体颜色。'
        p -> '【字体大小】用于设置区域字体大小。'
        p -> '【文字字体】用于设置区域字体类型。'
        p -> '【文字】用于显示区域文字内容。'
        p -> '【哪天】用于设置所要展现的时间（今天，明天，后天）。'
        p -> '【城市】选择框，用于设置城市。'
        br ->

        h4 id:"_3_3_8", ->'3.3.8.空气质量'
        br ->
        p -> '空气质量用来展现城市空气质量，如图3-3-8-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/03playlist/15PlaylistAQITextAttr.png", onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图3-3-8-1'
        br ->
        p -> '【标签】用于标记区域名称方便在组件列表中查找。'
        p -> '【宽度】用于设置区域宽度的精确值。'
        p -> '【高度】用于设置区域高度的精确值。'
        p -> '【x坐标】用于设置区域起始x坐标的精确值。'
        p -> '【y坐标】用于设置区域起始y坐标的精确值。'
        p -> '【背景色】用于设置区域背景色。'
        p -> '【字体颜色】用于设置区域字体颜色。'
        p -> '【字体大小】用于设置区域字体大小。'
        p -> '【文字字体】用于设置区域字体类型。'
        p -> '【文字】用于显示区域文字内容。'
        p -> '【监测点】用于设置所要展现的监测点。'
        p -> '【城市】选择框，用于设置城市。'
        br ->

        h4 id:"_3_3_9", ->'3.3.9.PM2.5'
        br ->
        p -> 'PM2.5用来展现城市PM2.5的值，如图3-3-9-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/03playlist/16PlaylistPM25TextAttr.png", onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图3-3-9-1'
        br ->
        p -> '【标签】用于标记区域名称方便在组件列表中查找。'
        p -> '【宽度】用于设置区域宽度的精确值。'
        p -> '【高度】用于设置区域高度的精确值。'
        p -> '【x坐标】用于设置区域起始x坐标的精确值。'
        p -> '【y坐标】用于设置区域起始y坐标的精确值。'
        p -> '【背景色】用于设置区域背景色。'
        p -> '【字体颜色】用于设置区域字体颜色。'
        p -> '【字体大小】用于设置区域字体大小。'
        p -> '【文字字体】用于设置区域字体类型。'
        p -> '【文字】用于显示区域文字内容。'
        p -> '【监测点】用于设置所要展现的监测点。'
        p -> '【城市】选择框，用于设置城市。'
        br ->

        h4 id:"_3_3_10", ->'3.3.10.字幕'
        br ->
        p -> '字幕用来显示可以滚动的文字字幕，如图3-3-10-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/03playlist/17PlaylistMarqueeAttr.png", onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图3-3-10-1'
        p -> '【标签】用于标记区域名称方便在组件列表中查找。'
        p -> '【宽度】用于设置区域宽度的精确值。'
        p -> '【高度】用于设置区域高度的精确值。'
        p -> '【x坐标】用于设置区域起始x坐标的精确值。'
        p -> '【y坐标】用于设置区域起始y坐标的精确值。'
        p -> '【背景色】用于设置区域背景色。'
        p -> '【字体颜色】用于设置区域字体颜色。'
        p -> '【字体大小】用于设置区域字体大小。'
        p -> '【文字字体】用于设置区域字体类型。'
        p -> '【文字】用于设置区域文字内容。'
        p -> '【方向】用于选择字幕滚动方向。'
        p -> '【速度】用于选择文字滚动速度，有10个级别可以选择。'
        br ->

        h4 id:"_3_3_11", ->'3.3.11.天气（图标）'
        br ->
        p -> '天气（图标）用来展现天气，如图3-3-11-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/03playlist/18PlaylistWeatherImageAttr.png", onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图3-3-11-1'
        p -> '【标签】用于标记区域名称方便在组件列表中查找。'
        p -> '【宽度】用于设置区域宽度的精确值。'
        p -> '【高度】用于设置区域高度的精确值。'
        p -> '【x坐标】用于设置区域起始x坐标的精确值。'
        p -> '【y坐标】用于设置区域起始y坐标的精确值。'
        p -> '【哪天】用于设置所要展现的时间（今天，明天，后天）。'
        p -> '【城市】选择框，用于设置城市。'
        br ->

        h4 id:"_3_3_12", ->'3.3.12.时钟（图标）'
        br ->
        p -> '时钟（图标）用来展现时钟，如图3-3-12-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/03playlist/19PlaylistClockImageAttr.png", onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图3-3-12-1'
        p -> '【标签】用于标记区域名称方便在组件列表中查找。'
        p -> '【宽度】用于设置区域宽度的精确值。'
        p -> '【高度】用于设置区域高度的精确值。'
        p -> '【x坐标】用于设置区域起始x坐标的精确值。'
        p -> '【y坐标】用于设置区域起始y坐标的精确值。'
        p -> '【样式】用于设置时钟的样式。'
        br ->

        h4 id:"_3_3_13", ->'3.3.13.普通图片'
        br ->
        p -> '普通图片用于展现媒体库内的普通图片素材，如图3-3-13-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/03playlist/20PlaylistNormalImageAttr.png", onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图3-3-13-1'
        p -> '【标签】用于标记区域名称方便在组件列表中查找。'
        p -> '【宽度】用于设置区域宽度的精确值。'
        p -> '【高度】用于设置区域高度的精确值。'
        p -> '【x坐标】用于设置区域起始x坐标的精确值。'
        p -> '【y坐标】用于设置区域起始y坐标的精确值。'
        br ->

        h4 id:"_3_3_14", ->'3.3.14.场景缩放'
        br ->
        p -> '场景缩放用于等比缩放场景大小用于全局布局，如图3-3-14-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/03playlist/21PlaylistScalZoom.png", onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图3-3-14-1'
        br ->

        h4 id:"_3_3_15", ->'3.3.15.删除'
        br ->
        p -> '选中某个组件后点击上方删除，或者键盘delete可以删除组件。'
        br ->

        h3 id:"_3_4", ->'3.4.离开页面'
        br ->
        p -> '编辑播放列表时离开页面会有提示防止编辑未保存，如图3-4-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/03playlist/23PlaylistLeaveConfirm.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图3-4-1'
        br ->


        h2 id:"_4",->'4.排期'
        br ->
        h3 id:"_4_1", ->'4.1.排期列表'
        br ->
        p -> '点击上方导航栏【排期】按钮，进入排期页面。排期用来确定播放列表的播出时间，如图4-1-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/04schedule/01ScheduleIndex.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图4-1-1'
        p -> '点击【新建】按钮、【编辑】按钮进入排期编辑页面，如4.2所示。'
        p -> '点击【删除】按钮、【搜索】按钮、【重命名】按钮和媒体库类似。'
        p -> '点击【发布】按钮发布排期给某个播放器或者组，如4.3所示。'
        br ->

        h3 id:"_4_2", ->'4.2.排期编辑'
        br ->
        p -> '编辑排期内容，如图4-2-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/04schedule/02ScheduleEdit.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图4-2-1'
        p -> '【名称】用于输入排期名称，字数不超过40字。'
        p -> '【保存】触发验证，保存排期。'
        p -> '【保存并且发布】触发验证，保存排期并且发布，如4.3所示。'
        p -> '【播放列表】提供系统已经拥有的播放列表。'
        p -> '【排期类型】对应排期的类型。当用户选择一次时，则需确定日期段和时间段。当用户选择每月时，则需添加日期及确定时间段。当用户选择每周时，则需确定星期几及时间段。当用户选择每天时，则需确定时间段。'
        p -> '【排期时间】不同类型的时间不同。'
        p -> '备注:'
        p class:"indent1", -> '1.相同类型的排期，如果时间出现冲突，则前一个排期会被最新的排期所替换。'
        p class:"indent1", -> '2.不同类型的排期，如果时间出现冲突，则优先级依次为，一次>每月>每周>每天。'
        br ->

        h3 id:"_4_3", ->'4.3.排期发布'
        br ->
        p -> '发布对应排期，如图4-3-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/04schedule/02SchedulePublish.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图4-3-1'
        p -> '【分组】列表用于选择所要发布的分组。'
        p -> '【播放器】列表用于选中所要发布的播放器。'
        p -> '【确定】触发验证，通过后发布成功跳转到任务页面。'
        br ->


        h2 id:"_5",->'5.播放器'
        br ->
        p ->'点击上方导航栏【播放器】按钮，进入播放器页面。播放器页面用于管理播放器，首页如图5-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/05device/01DeviceIndex.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图5-1'
        p -> '点击【删除】、【搜索】、【重命名】按钮和媒体库类似。'
        p -> '点击【视图】按钮可以切换成视图模式。如图5-2所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/05device/02DeviceView.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图5-2'
        br ->

        h3 id:"_5_1", ->'5.1.新建播放器'
        br ->
        p -> '点击【新建】弹出新建播放器对话框，如图5-1-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/05device/03DeviceCreate.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图5-1-1'
        p -> '【设备ID】为设备识别号只支持英文、数字、下划线等，字数不超过40字。'
        p -> '【名称】用于用户记录用的设备名描述，字数不超过40字。'
        p -> '【确定】按钮触发验证，成功新建播放器。'
        br ->

        h3 id:"_5_2", ->'5.2.播放器分组'
        br ->
        p -> '点击【分组】弹出下拉框，如图5-2-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/05device/04DeviceGroup.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图5-2-1'
        br ->
        p -> '点击【创建分组】弹出创建分组对话框（必须选中至少一个播放器才能创建分组），如图5-2-2所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/05device/05DeviceGroupCreate.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图5-2-2'
        p class :"indent1", -> '【分组名】用于输入分组名称。'
        p class :"indent1", -> '【确定】按钮触发验证，成功新建分组。'
        br ->
        p -> '点击【设置分组】弹出设置分组对话框，如图5-2-3所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/05device/06DeviceGroupSetting.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图5-2-3'
        p class :"indent1", -> '【批量删除】用于批量删除选中分组。'
        p class :"indent1", -> '【重命名】用于重命名对应分组。'
        p class :"indent1", -> '【删除】删除单个分组。'
        br ->
        p -> '点击【加入分组】弹出加入分组对话框（必须选中至少一个播放器才能加入分组），如图5-2-4所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/05device/07DeviceGroupAddBox.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图5-2-4'
        p class :"indent1", -> '【当前分组】用于展现当前存在的分组。'
        p class :"indent1", -> '【确定】提交选中的分组加入当前组。'
        br ->

        h3 id:"_5_3", ->'5.3.播放器设置'
        br ->
        p -> '点击【播放器】按钮弹出【更多选项】，包括【基本设置】按钮和【网络设置】按钮。'
        p -> '每一行的单项上【更多操作】按钮，包括【基本设置】按钮和【网络设置】按钮。'
        br ->
        p -> '单个播放器【基本设置】按钮，如图5-3-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/05device/08DeviceBasicSetting.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图5-3-1'
        p -> '若为批量时【基本设置】会缺少设备ID属性及名称属性。'
        p -> '【截屏周期】设置播放器自动截屏周期0为不截屏。'
        p -> '【更新周期】设置播放器自动更新的周期。'
        p -> '【运行模式】设置播放器的运行模式。'
        p -> '【开屏时间段】用于设置播放器屏幕开启的时间段，可以添加多少个时间段。'
        br ->
        p -> '单个播放器【网络设置】按钮，如图5-3-2所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/05device/09DeviceNetSetting.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图5-3-2'
        p -> '若为批量时【网络设置】则只能设置服务器地址。'
        p -> '【服务器地址】设置播放器服务器地址。'
        p -> '【IP地址】设置播放器IP地址。'
        p -> '【子网掩码】设置播放器子网掩码。'
        p -> '【网关】设置播放器网关。'
        br ->
        p -> '点击播放器的【详细】显示播放器详细信息，如图5-3-3所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/05device/11DeviceDetail.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图5-3-3'
        br ->

        h3 id:"_5_4", ->'5.4.播放器控制'
        br ->
        p -> '点击【控制】按钮弹出对话框，如图5-4-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/05device/10DeviceControl.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图5-4-1'
        br ->
        p -> '【截屏】控制选中播放器截屏。'
        p -> '【开屏】控制选中播放器开屏。'
        p -> '【关屏】控制选中播放器关屏。'
        p -> '【关机】控制选中播放器关机。'
        p -> '【重启】控制选中播放器重启。'
        p -> '【重置】清空选中播放器排期等数据。'
        br ->


        h2 id:"_6",->'6.任务'
        p -> '点击上方导航条【任务】进入任务页面，如图6-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/06task/01TaskIndex.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图6-1'
        p -> '【删除】、【搜索】和媒体库类似。'
        p -> '【取消】用来取消已经发布的任务（即排期）。'
        p -> '【详细】用来查看任务对应播放器，如图6-2所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/06task/02TaskDetail.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图6-2'
        br ->


        h2 id:"_7",->'7.设置'
        p -> '点击上方导航栏【设置】按钮进入设置页面，如图7-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/07setting/01SettingIndex.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图7-1'
        br ->
        p -> '三个【升级】按钮对应三个不同部分的播放器软件的升级。'
        br ->


        h2 id:"_8",->'8.用户'
        p -> '点击上方导航栏【用户】进入用户页面，如图8-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/08user/01UserIndex.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图8-1'
        br ->

        h3 id:"_8_1",->'8.1.新建用户'
        p -> '点击【添加】按钮弹出添加用户对话框，如图8-1-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/08user/02UserAdd.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图8-1-1'
        p -> '【用户名】输入框用于输入用户名，用户名长度只能为4-18位，用户名只能为英文、数字、下划线和减号。'
        p -> '【密码】输入框用于输入密码，密码长度只能为4-18位。'
        p -> '【确认密码】输入框用于输入确认密码。'
        p -> '【个人注释】输入框用于输入个人注释。'
        br ->


        h3 id:"_8_2",->'8.2.用户管理'
        p -> '点击【重置】按钮可以重置某个用户的密码（重置后为：1111）。'
        p -> '点击【冻结】按钮冻结某个用户，冻结后该用户无法登录。'
        p -> '点击【激活】按钮激活某个被冻结的用户。'
        p -> '【删除】按钮、【搜索】按钮与媒体库类似。'
        p -> '点击【授权】按钮弹出授权对话框，如图8-2-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/08user/03UserAuthority.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图8-2-1'
        br ->
        p -> '【授权】将播放器授权给某个用户。若未授权，则该用户无法控制此播放器。'
        br ->


        h2 id:"_9",->'9.日志'
        p -> '点击上方导航栏【日志】进入日志页面，如图9-1所示：'
        div class:"text-center", ->
          img src:"/images/OperationManual/09log/01LogIndex.png",id:"",onerror:"this.src = '/images/default.jpg'", ->
          h6 -> '图9-1'
        p -> '【删除】、【搜索】类似媒体库。'
        p -> '【下载】下载对应日志文件。'
        br ->
        br ->
        br ->
        br ->
        br ->
      div id:'div-scroll',class :"h6", ->
#        a href:"#goTop", class: 'btn btn-default ', ->
##          span class: 'glyphicon  glyphicon-chevron-up', ->
#          text ' 返回顶部'
        a href:"#goTop", ->'返回顶部'
  div class:"navbar navbar-default  input-group-addon-format", role:"navigation", ->
    div class:"container fixed-width", ->
      div class:"navbar-header", ->
        hr class:"hr-color", ->
        div class :"text-center container", ->
          p ->'Copyright 上海金桥信息股份有限公司 2010 沪ICP备09095147号'
          p ->'地址：上海市徐汇区田林路487号25号楼(200233) 电话：021-33674999 传真：021-64647869'
#          a class:"navbar-brand", href:"#", ->'公告系统 © 上海金桥信息股份有限公司 2014'
#  div class:"navbar navbar-default  navbar-fixed-top", role:"navigation", ->
#    div class:"container", ->
#      div class:"navbar-header", ->
#        a class:"navbar-brand", href:"#", ->'公告系统 © 上海金桥信息股份有限公司 2014'
