esp = require '../espx'
User = require '../model/user'
_ = require 'underscore'
Playlist = require '../model/playlist'
logger = require '../model/logger'

esp.route ->

  @get '/playlist', -> @view 'playlist/index'

  @get '/playlists', ->
    p = Playlist.RelativePlaylist.find()
    playlists = _.map p, (each) -> each.getAllAttr()
    @json playlists, 2

  @get '/playlist/:id', ->
    p = Playlist.RelativePlaylist.findone (p) => p.id is @id
    @json p.getAllAttr(), 2

  @get '/playlist/create', -> @view '/playlist/edit'

  @get '/playlist/edit', -> @view 'playlist/edit'

  # TODO check name conflict
  @post '/playlist', ->
    data = ''
    @request.on 'data', (chunk) -> data += chunk
    @request.on 'end', =>
      try
        p = JSON.parse data
        RPLs = Playlist.RelativePlaylist.find()
        RPL = Playlist.RelativePlaylist.findone (x) -> x.name is p.name if p.name?
        return @json {status: 'fail', result:'播放列表名称已存在，请换个名称'} if RPL?
        newRPL = Playlist.RelativePlaylist.create p
        logger.info User.getCurrentUserName() + "添加播放列表 #{p.name} 成功", {'action': logger.action.add, 'source': logger.source.playlist}
        @json newRPL.getAllAttr()
      catch err
        console.log err
        logger.error User.getCurrentUserName() + "添加播放列表失败", {'action': logger.action.add, 'source': logger.source.playlist}

  @put '/playlist/:id', ->
    RPL = Playlist.RelativePlaylist.findone (p) => p.id is @id
    return  @json {result: 'fail'} unless RPL
    data = ''
    @request.on 'data', (chunk) -> data += chunk
    @request.on 'end', =>
      try
        p = JSON.parse data
        RPL.update p
        APLs = Playlist.AbsolutePlaylist.find()
        ([each.update(), each.save()] for each in APLs when _.first(each.children) is RPL.id) if APLs
        RPL.save()
        logger.info User.getCurrentUserName() + "编辑播放列表 #{RPL.name} 成功", {'action': logger.action.edit, 'source': logger.source.playlist}
        @json RPL.getAllAttr(), 2
      catch err
        console.log err
        logger.error User.getCurrentUserName() + "编辑播放列表失败", {'action': logger.action.edit, 'source': logger.source.playlist}

  @post '/playlist/copy/:id', ->
    RPL = Playlist.RelativePlaylist.findone (p) => p.id is @id
    return  @json {result: 'fail'} unless RPL
    p = RPL.getAllAttr()
    RPLs = Playlist.RelativePlaylist.find()
    names = []
    names.push each.name for each in RPLs
    t = 1
    t += 1 while "#{p.name}(#{t})" in names
    p.name = "#{p.name}(#{t})"
    duplicate = Playlist.RelativePlaylist.create p
    @json duplicate.getAllAttr(), 2

  @delete '/playlist/:id', ->
    RPL = Playlist.RelativePlaylist.find @id
    RPL.delete()
    logger.info User.getCurrentUserName() + "删除播放列表 #{RPL.name} 成功", {'action': logger.action.delete, 'source': logger.source.playlist}
    @json {status: 'success'}

  @delete '/playlists', ->
    data = ''
    @request.on 'data', (chunk) -> data += chunk
    @request.on 'end', =>
      try
        p = JSON.parse data
        for each in p
          RPL = Playlist.RelativePlaylist.find each
          RPL.delete()
          logger.info User.getCurrentUserName() + "删除播放列表 #{RPL.name} 成功", {'action': logger.action.delete, 'source': logger.source.playlist}
        @json {status: 'success'}
      catch err
        console.log err
        logger.error User.getCurrentUserName() + "删除播放列表失败", {'action': logger.action.delete, 'source': logger.source.playlist}
        @html '', 400

