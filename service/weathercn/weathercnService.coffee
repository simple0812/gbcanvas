http = require 'http'
fs = require 'fs'
util = require 'util'
events = require 'events'
moment = require 'moment'
crypto = require 'crypto'
Service = require '../service'
setting = require './weathercnSetting'
logger = require '../../model/logger'

exports.WeathercnService = class WeathercnService extends Service
  data: {}
  interfaces: []
  interval: 1

  privateKey: ''
  appid: ''
  appid6c: ''

  init: ->
    @interval = setting.interval * 1000
    @privateKey = setting.privateKey
    @appid = setting.appid
    @appid6c = setting.appid6c
    @interfaces = setting.interfaces
    @initWeatherData(@interfaces)
    @on 'saveWeathercnData', @saveWeatherData
    logger.info "weathercn服务,已初始化", {'action': 'init', 'source': logger.source.weathercnService}


  run: ->
    logger.info "weathercn服务,运行", {'action': 'run', 'source': logger.source.weathercnService}
    @begin(@interfaces)


  initWeatherData: (interfaces) ->
    for i in interfaces
      filename = "./service/weathercn/data/#{i.area}.data"
      continue unless fs.existsSync filename
      dataString = fs.readFileSync filename, encoding: 'utf8'
      @data[i.area] = JSON.parse dataString
      logger.info "weathercn服务,初始化并已读取数据文件:#{filename}", {'action': 'init', 'source': logger.source.weathercnService}


  begin: (interfaces)->
    getWeatherData = (onwer, area, areaid, baseurl, interval) ->
      date = moment().format 'YYYYMMDDHHmm'
      publicKey = onwer.formatPublicKey baseurl, areaid, onwer.appid, date
      key = onwer.calculateKey publicKey, onwer.privateKey
      url = onwer.formatInterfaceUrl baseurl, areaid, onwer.appid6c, key, date
      logger.debug "weathercn服务,开始获取#{area}的天气数据，url:#{url}", {'action': 'run', 'source': logger.source.weathercnService}

      p = http.get url, (res) ->
        #console.log 'status: ' + res.statusCode
        #console.log 'headers: ' + JSON.stringify res.headers
        data = ''
        res.on 'data', (chrunk) ->
          data += chrunk
        res.on 'end', ->
          setTimeout getWeatherData, interval, onwer, area, areaid, baseurl, interval
          logger.info "weathercn服务,已获取#{area}的天气数据:#{data}", {'action': 'run', 'source': logger.source.weathercnService}
          onwer.emit 'saveWeathercnData', area: area, data: data

      p.on 'error', (e) =>
        logger.warn "weathercn服务,获取#{area}的天气数据失败:#{e.message}", {'action': 'run', 'source': logger.source.weathercnService}
        setTimeout getWeatherData, interval, onwer, area, areaid, baseurl, interval

    index = 0
    for i in interfaces
      getWeatherData(@, i.area, i.areaid, i.url, @interval+index*1000)
      index++


  calculateKey: (publicKey, privateKey) ->
    hmac = crypto.createHmac 'sha1', privateKey
    hmac.update publicKey
    key = encodeURIComponent(hmac.digest('base64'))
    return key


  formatPublicKey: (baseUrl, areaid, appid, date) ->
    publicKey = "#{baseUrl}?areaid=#{areaid}&type=forecast3d&date=#{date}&appid=#{appid}"
    return publicKey


  formatInterfaceUrl: (baseUrl, areaid, appid6c, key, date) ->
    url = "#{baseUrl}?areaid=#{areaid}&type=forecast3d&date=#{date}&appid=#{appid6c}&key=#{key}"
    return url


  saveWeatherData: (weatherData) ->
    logger.info "weathercn服务,开始保存#{weatherData.area}的天气数据", {'action': 'save', 'source': logger.source.weathercnService}

    gettedDataString = weatherData.data or '{}'
    gettedData = {}
    try
      gettedData = JSON.parse gettedDataString
    catch err
      logger.warn "weathercn服务,保存前转换#{weatherData.area}的天气数据:#{gettedDataString}时失败:#{err.message}", {'action': 'save', 'source': logger.source.weathercnService}
      return

    f1 = []
    f1 = gettedData.f.f1 or [] if gettedData.f

    persistData = @data[weatherData.area] or {}
    persistData.city = ''
    persistData.city = gettedData.c.c3 if gettedData.c

    #今天的天气数据
    f1_0 = f1[0] or {}
    #过了18:00之后白天气象是空，如果之前白天气象有值则保持不变
    unless f1_0.fa
      persistData["weather1Day"] = '' unless persistData["weather1Day"]
    else
      persistData["weather1Day"] = setting.codeNames[f1_0.fa]

    persistData["weather1Night"] = setting.codeNames[f1_0.fb]  or ''
    #过了18:00之后白天气象图标是空，如果之前白天气象图标有值则保持不变
    unless f1_0.fa
      persistData["weather1DayImage"] = '' unless persistData["weather1DayImage"]
    else
      persistData["weather1DayImage"] = setting.codeNames[f1_0.fa]

    persistData["weather1NightImage"] = setting.codeNames[f1_0.fb]  or ''
    #过了18:00之后夜间温度是空，如果之前最高温度有值则保持不变
    unless f1_0.fc
      persistData["temperature1Max"] = '' unless persistData["temperature1Max"]
    else
      persistData["temperature1Max"] = f1_0.fc + '℃'
    persistData["temperature1Min"] = ''
    persistData["temperature1Min"] = f1_0.fd + '℃' if f1_0.fd
    #明天的天气数据
    f1_1 = f1[1] or {}
    persistData["weather2Day"] = setting.codeNames[f1_1.fa] or ''
    persistData["weather2Night"] = setting.codeNames[f1_1.fb]  or ''
    persistData["weather2DayImage"] = setting.codeNames[f1_1.fa] or ''
    persistData["weather2NightImage"] = setting.codeNames[f1_1.fb]  or ''
    persistData["temperature2Max"] = ''
    persistData["temperature2Max"] = f1_1.fc + '℃' if f1_1.fc
    persistData["temperature2Min"] = ''
    persistData["temperature2Min"] = f1_1.fd + '℃' if f1_1.fd
    #后天的天气数据
    f1_2 = f1[2] or {}
    persistData["weather3Day"] = setting.codeNames[f1_2.fa] or ''
    persistData["weather3Night"] = setting.codeNames[f1_2.fb]  or ''
    persistData["weather3DayImage"] = setting.codeNames[f1_2.fa] or ''
    persistData["weather3NightImage"] = setting.codeNames[f1_2.fb]  or ''
    persistData["temperature3Max"] = ''
    persistData["temperature3Max"] = f1_2.fc + '℃' if f1_2.fc
    persistData["temperature3Min"] = ''
    persistData["temperature3Min"] = f1_2.fd + '℃' if f1_2.fd

    @data[weatherData.area] = persistData

    persistDataString = JSON.stringify persistData, null, 2
    filename = "./service/weathercn/data/#{weatherData.area}.data"
    fs.writeFile filename, persistDataString, encoding: 'utf8', (err) ->
      if err
        logger.info "weathercn服务,保存#{weatherData.area}的天气数据到文件时失败:#{err.message}", {'action': 'save', 'source': logger.source.weathercnService}
        return
      logger.info "weathercn服务,已保存#{weatherData.area}的天气数据到文件", {'action': 'save', 'source': logger.source.weathercnService}
