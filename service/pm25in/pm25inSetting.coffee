exports = module.exports = pm25inSetting = {}

pm25inSetting.interfaces = [
  {city:'上海市', url: 'http://www.pm25.in/api/querys/pm2_5.json?city=shanghai&token=KkKFzPWWxTbx5B9Zpdbb'},
  {city:'北京市', url: 'http://www.pm25.in/api/querys/pm2_5.json?city=beijing&token=KkKFzPWWxTbx5B9Zpdbb'}
  {city:'杭州市', url: 'http://www.pm25.in/api/querys/pm2_5.json?city=hangzhou&token=KkKFzPWWxTbx5B9Zpdbb'}
]

#interval(s)
pm25inSetting.interval = 1800
