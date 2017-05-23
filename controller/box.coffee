esp = require 'esp'
Box = require '../model/box'
User = require '../model/user'
BoxUnionUser = require '../model/boxunionuser'
Playlist = require '../model/playlist'
Group = require '../model/group'
Task = require '../model/task'
_ = require 'underscore'
moment = require 'moment'
Package = require '../model/package'
logger = require '../model/logger'

esp.route ->

  @get '/box/:name', ->
    box = Box.findone (p) => p.name is @name
    return @html '', 404 unless box?
    box.lastLinkTime = new Date().getTime()
    p = box.getAttr()
    p.datetime = moment().format('YYYY/MM/DD HH:mm:ss.SSS')
    x = Package.find()
    if x? then x = x.pop() else x = Package.create()
    android_regex = /Android/i
    win_regex = /Windows/i
    agent = @request.headers['user-agent']
    if android_regex.test agent
      box.clearPublish()
      box.clearCommands()
      p.version = x.getANDVersion()
      p.dsmversion = x.getD4AVersion()
    else if win_regex.test agent
      box.clearPublish()
      box.clearCommands()
      p.version = x.getWINVersion()
    else
      p.ANDVerison = x.getANDVersion()
      p.D4AVersion = x.getD4AVersion()
      p.WINVersion = x.getWINVersion()

    p.authorization = 'ShgbitGBVision'
    # ToDo get screen?
    # ToDo add to logger
    logger.debug   "GETTER LEVEL1 Boxname: #{@name}, extra:" + JSON.stringify(p), {'action': 'get', 'source': 'box'}
    @json p, 2
  ,public: true


  @get '/box/schedule', ->
    return @html '', 400 unless @query.boxName? and @query.scheduleId?
    box = Box.findone (p) => p.name is @query.boxName
    APL = Playlist.AbsolutePlaylist.find @query.scheduleId
    return @html '', 404 unless box? and APL?
    schedule = APL.getAllAttr()
    x = _.first schedule.children
    RPL = Playlist.RelativePlaylist.find x
    schedule.children = []
    schedule.children.push RPL.getAllAttr() if RPL?
    logger.debug   "GETTER LEVEL2 Boxname: #{@query.boxName}, extra:" + JSON.stringify(schedule), {'action': 'get', 'source': 'box'}
    @json schedule, 2
  ,public: true


  @post '/box/:name', ->
    box = Box.findone (p) => p.name is @name
    return @html '', 404 unless box?
    box.lastLinkTime = new Date().getTime()
    data = ''
    @request.on 'data', (chunk) -> data += chunk
    @request.on 'end', =>
      try
        p = JSON.parse data
        if p.snapshot? then box.updateSnapshot p.snapshot else box.updateNormalAttr p
        if not box.network.ip? and p.network?
          box.setNetwork p.network
          box.save()
        if box.service is '' and p.service?
          box.service = p.service
          box.save()
        box.network.mac = p.network.mac or '' if p.network?
    # ToDo add to logger
        logger.debug   "SETTER Boxname: #{@name}, extra: " + JSON.stringify(p), {'action': 'post', 'source': 'box' }
        @html '', 200
      catch err
        logger.error   "SETTER Boxname: #{@name}", {'action': 'post', 'source': 'box'}
        @html '', 400
  ,public: true


  @get '/device', ->
    @view 'box/index'


  @get '/devices', ->
    userId = @cookie['token']
    boxes = []

    xUser = User.findone (x) -> x.id is userId
    if xUser and xUser.type is 'normal'
      boxUnionUsers = BoxUnionUser.find (x) -> x.userId is userId
      for each in boxUnionUsers
        xBox = Box.findone (x) -> x.id is each.boxId
        boxes.push(xBox.getAllAttr()) if xBox?
    else
      p = Box.find()
      boxes = _.map p, (each) -> each.getAllAttr()

    @json boxes, 2


  @get '/device/:id',  ->
    p = Box.find @id
    @html '', 404 unless p?
    @json p.getAllAttr(), 2


  @post '/device', ->
    data = ''
    @request.on 'data', (chunk) -> data += chunk
    @request.on 'end', =>
      try
        p = JSON.parse data
        boxes = Box.find()
        x = _.where boxes, {name: p.name}
        return @html '', 409 unless 0 is x.length
        box = Box.create p.name
        box.updatePersistAttr p
        box.save()
        logger.info User.getCurrentUserName() + "添加播放器 #{box.name} 成功", {'action': logger.action.add, 'source': logger.source.box}
        @json box.getAllAttr(), 2
      catch err
        logger.error User.getCurrentUserName() + "添加播放器 #{box.name} 失败", {'action': logger.action.add, 'source': logger.source.box}
        @html '', 400


  @put '/device/:id', ->
    data = ''
    @request.on 'data', (chunk) -> data += chunk
    @request.on 'end', =>
      try
        p = JSON.parse data
        box = Box.find @id
        return html '', 404 unless box?
        box.updatePersistAttr p
        box.save()
        logger.info User.getCurrentUserName() + "编辑播放器 #{box.name} 成功", {'action': logger.action.edit, 'source': logger.source.box}
        @json box.getAllAttr(), 2
      catch err
        console.log err
        logger.error User.getCurrentUserName() + "编辑播放器失败", {'action': logger.action.edit, 'source': logger.source.box}
        @html '', 400

  @put '/devices', ->
    data = ''
    @request.on 'data', (chunk) -> data += chunk
    @request.on 'end', =>
      try
        p = JSON.parse data
        return @json {status:'fail'} if  !p.ids or !p.data
        for each in p.ids
          box = Box.find each
          return html '', 404 unless box?
          box.updatePersistAttr p.data
          box.save()
          logger.info User.getCurrentUserName() + "编辑播放器 #{box.name} 成功", {'action': logger.action.edit, 'source': logger.source.box}
        @json {status:'success'}
      catch err
        console.log err
        logger.error User.getCurrentUserName() + "编辑播放器失败", {'action': logger.action.edit, 'source': logger.source.box}
        @html '', 400


  @delete '/device/:id', ->
    box = Box.find @id
    return @html '', 404 unless box?
    box.delete()
    BoxUnionUser p = (BoxUnionUser.find (x) => x.boxId is @id) or []
    each.delete() for each in p
    logger.info User.getCurrentUserName() + "删除播放器 #{box.name} 成功", {'action': logger.action.delete, 'source': logger.source.box}
    @html '', 200


  @delete '/devices', ->
    data = ''
    @request.on 'data', (chunk) -> data += chunk
    @request.on 'end', =>
      try
        p = JSON.parse data
        for each in p
          x = Box.find each
          if x?
            x.delete()
            logger.info User.getCurrentUserName() + "删除播放器 #{x.name} 成功", {'action': logger.action.delete, 'source': logger.source.box}
        @html '', 200
      catch err
        console.log err
        logger.error User.getCurrentUserName() + "编辑播放器失败", {'action': logger.action.delete, 'source': logger.source.box}
        @html '', 400


  # p = {command: xxx, boxes: [id1, id2, ...]}
  @put '/command', ->
    data = ''
    @request.on 'data', (chunk) -> data += chunk
    @request.on 'end', =>
      try
        p = JSON.parse data
        x = {boxes: []}
        for each in p.boxes
          box = Box.find each
          if box?
            box.appendCommands p.command
            x.boxes.push box.name
          else
            @html "#{each}", 404
        esp.socketio.sockets.emit 'changed', x
        @html '', 200
      catch err
        console.log err
        @html '', 400
