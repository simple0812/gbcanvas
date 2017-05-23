util = require 'util'
logger = require '../model/logger'
weathercn = require './weathercn/weathercnService'
pm25in = require './pm25in/pm25inService'

exports.serviceManager = serviceManager = {}

serviceManager.register = ->
  logger.info "注册服务", {'action': 'register', 'source': logger.source.serviceManager}
  @services = {}
  weatherService = new weathercn.WeathercnService
  @services['weathercn'] = weatherService
  pm25inService = new pm25in.Pm25inService
  @services['pm25in'] = pm25inService

serviceManager.init = ->
  @register()
  logger.info "初始化服务", {'action': 'init', 'source': logger.source.serviceManager}
  for k,v of @services
    v.init()

serviceManager.run = ->
  @init()
  logger.info "运行服务", {'action': 'run', 'source': logger.source.serviceManager}
  for k,v of @services
    v.run()

serviceManager.getService = (name) ->
  return @services[name]

