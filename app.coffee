#!/usr/bin/env coffee
esp = require './espx'

esp.TMP_DIR = 'files/tmp'
esp.MEDIA_STORAGE = 'files/media'
esp.SCREENSHOTS_STORAGE = 'public/Screenshots'
esp.LOGFILE_STORAGE = 'files/log'
esp.PACKAGE_STORAGE = 'files/package'

socketio = require('socket.io').listen esp.server.server
socketio.set 'log level', 3
socketio.sockets.on 'connection', (socket) ->
  logger.debug "SOCKET CONNECTION " + socket.id, {'action': 'socket', 'source': 'socket'}
  socket.on 'disconnect', ->
    logger.debug "SOCKET DISCONNECTION " + socket.id, {'action': 'socket', 'source': 'socket'}

esp.socketio = socketio

serviceEntry = require './service/serviceEntry'
serviceManager = serviceEntry.serviceManager
require './controller/index'
require './controller/media'
require './controller/playlist'
require './controller/schedule'
require './controller/group'
require './controller/box'
require './controller/weather'
require './controller/task'
require './controller/user'
require './controller/setting'
require './controller/login'
require './controller/log'
User = require './model/user'

logger = require './model/logger'
logger.level 'error'

esp.server.debug = (req, res)->
  logger.debug   "发生请求 #{decodeURIComponent(req.url)} 成功", {'action': logger.action.request, 'source': logger.source.url}

esp.auth '/login', -> User.find @cookie.token if @cookie?.token?

serviceManager.run()

esp.run 10001
