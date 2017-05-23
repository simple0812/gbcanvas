http = require 'http'
fs = require 'fs'
util = require 'util'
Service = require '../service'
setting = require './pm25inSetting'
logger = require '../../model/logger'

exports.Pm25inService = class Pm25inService extends Service
  data: {}
  interfaces: []
  interval: 1

  init: ->
    @interval = setting.interval * 1000
    @interfaces = setting.interfaces
    @initData(@interfaces)
    @on 'saveAqiData', @savePm25Data
    logger.info "PM2.5in服务,已初始化", {'action': 'init', 'source': logger.source.pm25inService}


  run: ->
    logger.info "PM2.5in服务,运行", {'action': 'run', 'source': logger.source.pm25inService}
    @begin(@interfaces)


  initData: (interfaces) ->
    for i in interfaces
      filename = "./service/pm25in/data/#{i.city}.data"
      continue unless fs.existsSync filename
      data = fs.readFileSync filename, encoding: 'utf8'
      logger.info "PM2.5in服务,初始化并已读取数据文件:#{filename}", {'action': 'init', 'source': logger.source.pm25inService}


  begin: (interfaces)->
    getPm25Data = (onwer, city, url, interval) ->
      p = http.get url, (res) ->
        #console.log 'status: ' + res.statusCode
        #console.log 'headers: ' + JSON.stringify res.headers
        data = ''
        res.on 'data', (chrunk) ->
          data += chrunk
        res.on 'end', ->
          setTimeout getPm25Data, interval, onwer, city, url, interval
          logger.info "PM2.5in服务,已获取#{city}的PM2.5数据:#{data}", {'action': 'run', 'source': logger.source.pm25inService}
          onwer.emit 'saveAqiData', city: city, data: data

      p.on 'error', (e) =>
        logger.warn "PM2.5in服务,获取#{city}的PM2.5数据失败:#{e.message}", {'action': 'run', 'source': logger.source.pm25inService}
        setTimeout getPm25Data, interval, onwer, city, url, interval

    index = 0
    for i in interfaces
      getPm25Data(@, i.city, i.url, @interval+index*2000)
      index++


  savePm25Data: (pm25Data) ->
    logger.info "PM2.5in服务,开始保存#{pm25Data.city}的PM2.5数据", {'action': 'save', 'source': logger.source.pm25inService}

    filename = "./service/pm25in/data/#{pm25Data.city}.data"

    gettedDataString = pm25Data.data or '{}'
    gettedData = {}
    try
      gettedData = JSON.parse gettedDataString
    catch err
      logger.warn "PM2.5in服务,保存前转换#{pm25Data.city}的PM2.5数据:#{gettedDataString}时失败:#{err.message}", {'action': 'save', 'source': logger.source.pm25inService}
      return

    persistData = @data[pm25Data.city] or {}

    for p in gettedData
      continue unless p['position_name']
      positionData = {}
      positionData['aqi'] = p['aqi']
      positionData['pm2_5'] = p['pm2_5']
      positionData['pm2_5_24h'] = p['pm2_5_24h']
      positionData['quality'] = p['quality']
      positionData['point'] = p['position_name']
      positionData['timePoint'] = p['time_point']
      persistData[p['position_name']] = positionData

    @data[pm25Data.city] = persistData

    persistDataString = JSON.stringify persistData, null, 2
    fs.writeFile filename, persistDataString, encoding: 'utf8', (err) ->
      if err
        logger.info "PM2.5in服务,保存#{pm25Data.city}的PM2.5数据到文件时失败:#{err.message}", {'action': 'save', 'source': logger.source.pm25inService}
        return
      logger.info "PM2.5in服务,已保存#{pm25Data.city}的PM2.5数据到文件", {'action': 'save', 'source': logger.source.pm25inService}
