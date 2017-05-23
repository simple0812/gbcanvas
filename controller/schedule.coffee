esp = require 'esp'
User = require '../model/user'
Playlist = require '../model/playlist'
Box = require '../model/box'
Task = require '../model/task'
Group = require '../model/group'
_ = require 'underscore'
logger = require '../model/logger'

esp.route ->

  @get '/schedule', -> @view 'schedule/index'


  @get '/schedules', ->
    p = Playlist.AbsolutePlaylist.find()
    playlists = _.map p, (each) ->
      x = each.getAllAttr()
      t = Playlist.RelativePlaylist.find _.first(x.children)
      x.playlistName = t.name if t?
      return x
    @json playlists, 2


  @get '/schedule/:id', ->
    p = Playlist.AbsolutePlaylist.findone (p) => p.id is @id
    @json p.getAllAttr(), 2


  @get '/schedule/create', -> @view '/schedule/edit'


  @get '/schedule/edit/:id', -> @view '/schedule/edit', id: @id


  @post '/schedule', ->
    data = ''
    @request.on 'data', (chunk) -> data += chunk
    @request.on 'end', =>
      try
        p = JSON.parse data
        APLs = Playlist.AbsolutePlaylist.find()
        x = _.where APLs, {name: p.name}
        return @html '', 409 unless 0 is x.length
        RPL = Playlist.RelativePlaylist.find _.first p.children
        return @html '', 404 unless RPL?
        APL = Playlist.AbsolutePlaylist.create p
        @json APL.getAllAttr(), 2
        logger.info User.getCurrentUserName() + "添加排期 #{APL.name} 成功", {'action': logger.action.add, 'source': logger.source.schedule}
      catch err
        console.log err
        logger.error User.getCurrentUserName() + "添加排期失败", {'action': logger.action.add, 'source': logger.source.schedule}
        @html '', 400


  @put '/schedule/:id', ->
    data = ''
    @request.on 'data', (chunk) -> data += chunk
    @request.on 'end', =>
      try
        p = JSON.parse data
        APL = Playlist.AbsolutePlaylist.find p.id
        return @html '', 404 unless APL?
        APLs = Playlist.AbsolutePlaylist.find()
        return @html '', 409 for each in APLs when p.name is each.name and p.id isnt each.id if APLs?
        APL.update p
        APL.save()
        logger.info User.getCurrentUserName() + "编辑排期 #{APL.name} 成功", {'action': logger.action.edit, 'source': logger.source.schedule}
        @json APL.getAllAttr(), 2
      catch err
        console.log err
        logger.error User.getCurrentUserName() + "编辑排期失败", {'action': logger.action.edit, 'source': logger.source.schedule}
        @html '', 400


  @delete '/schedule/:id', ->
    APL = Playlist.AbsolutePlaylist.find @id
    APL.delete()
    logger.info User.getCurrentUserName() + "删除排期 #{APL.name} 成功", {'action': logger.action.delete, 'source': logger.source.schedule}
    @json {status: 'success'}


  @delete '/schedules', ->
    data = ''
    @request.on 'data', (chunk) -> data += chunk
    @request.on 'end', =>
      try
        p = JSON.parse data
        for each in p
          APL = Playlist.AbsolutePlaylist.find each
          APL.delete() if APL?
          logger.info User.getCurrentUserName() + "删除排期 #{APL.name} 成功", {'action': logger.action.delete, 'source': logger.source.schedule}
        @json {status: 'success'}
      catch err
        console.log err
        logger.info User.getCurrentUserName() + "删除排期失败", {'action': logger.action.delete, 'source': logger.source.schedule}
        @html '', 400


  # data {groups:[group1, group2, ...], boxes: [box1, box2, ...]}
  @post '/publish/:scheduleId', ->
    data = ''
    @request.on 'data', (chunk) -> data += chunk
    @request.on 'end', =>
      try
        p = JSON.parse data
        schedule = Playlist.AbsolutePlaylist.find @scheduleId
        return @html '', 404 unless schedule?
        task = Task.create schedule.id, schedule.name
        tasks = Task.find()
        boxes = p.boxes
        for each in p.groups
          group = Group.find each
          return @html '', 404 unless group?
          boxes = _.union boxes, group.boxes
        Task.removeBoxes each, boxes for each in tasks when each.schedule is task.schedule and each.id isnt task.id
        x = {boxes:[]}
        for each in boxes
          box = Box.find each
          if box?
            box.appendPublish schedule.id
            task.boxes.push each
            x.boxes.push box.name
          else
            @html "#{each}", 404
        task.save()
        esp.socketio.sockets.emit 'changed', x
        @html '', 200
      catch err
        console.log err
        @html '', 400
