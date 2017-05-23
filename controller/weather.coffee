esp = require 'esp'
url = require 'url'
serviceEntry = require '../service/serviceEntry'
serviceManager = serviceEntry.serviceManager

esp.route ->
  @get '/weather', ->
    args = url.parse(@request.url, true).query
    city = args.city
    result = {}

    weathercn = serviceManager.getService 'weathercn'
    weatherData = weathercn.data[city]
    unless weatherData
      @json result, 2
      return

    date = new Date()
    hour = date.getHours()

    result.city = city
    result.temperature1Max = weatherData.temperature1Max
    result.temperature1Min = weatherData.temperature1Min
    result.temperature2Max = weatherData.temperature2Max
    result.temperature2Min = weatherData.temperature2Min
    result.temperature3Max = weatherData.temperature3Max
    result.temperature3Min = weatherData.temperature3Min
    #8:00到18:00采用日间天气现象以外时间采用夜间天气现象
    if hour >= 8 and hour <=18
      result.weather1 = weatherData.weather1Day
      result.weather2 = weatherData.weather2Day
      result.weather3 = weatherData.weather3Day
      result.weather1Image = weatherData.weather1DayImage
      result.weather2Image = weatherData.weather2DayImage
      result.weather3Image = weatherData.weather3DayImage
    else
      result.weather1 = weatherData.weather1Night
      result.weather2 = weatherData.weather2Night
      result.weather3 = weatherData.weather3Night
      result.weather1Image = weatherData.weather1NightImage
      result.weather2Image = weatherData.weather2NightImage
      result.weather3Image = weatherData.weather3NightImage

    pm25in = serviceManager.getService 'pm25in'
    aqiData = pm25in.data[city] or {}
    result.aqi = []
    for k,v of aqiData
      result.aqi.push v

    @json result, 2
  ,public: true

