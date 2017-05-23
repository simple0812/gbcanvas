exports = module.exports = weathercnSetting = {}

weathercnSetting.interfaces = [
  {area:'上海市', areaid: '101020100', url: 'http://webapi.weather.com.cn/data/'},
  {area:'北京市', areaid: '101010100', url: 'http://webapi.weather.com.cn/data/'}
  {area:'杭州市', areaid: '101210101', url: 'http://webapi.weather.com.cn/data/'}
]

#interval(s)
weathercnSetting.interval = 1800

#以下appid，appid6c(appid的前6位)，privateKey都是从www.weather.com.cn申请而来
weathercnSetting.appid = 'b7d54dff686f26ac'
weathercnSetting.appid6c = 'b7d54d'
weathercnSetting.privateKey = '710898_SmartWeatherAPI_0b52523'

#天气现象代码名称表
weathercnSetting.codeNames =
  '00': '晴',
  '01': '多云',
  '02': '阴',
  '03': '阵雨',
  '04': '雷阵雨',
  '05': '雷阵雨伴有冰雹',
  '06': '雨夹雪',
  '07': '小雨',
  '08': '中雨',
  '09': '大雨',
  '10': '暴雨',
  '11': '大暴雨',
  '12': '特大暴雨',
  '13': '阵雪',
  '14': '小雪',
  '15': '中雪',
  '16': '大雪',
  '17': '暴雪',
  '18': '雾',
  '19': '冻雨',
  '20': '沙尘暴',
  '21': '小到中雨',
  '22': '中到大雨',
  '23': '大到暴雨',
  '24': '暴雨到大暴雨',
  '25': '大暴雨到特大暴雨',
  '26': '小到中雪',
  '27': '中到大雪',
  '28': '大到暴雪',
  '29': '浮尘',
  '30': '扬沙',
  '31': '强沙尘暴',
  '53': '霾',
  '99': '无',
