esp = require 'esp'
fs = require 'fs'
_ = require 'underscore'
moment = require 'moment'
User = require '../model/user'
logger = require '../model/logger'
filesize = require 'filesize'


esp.route ->
  @get '/log', -> @view 'log'

  @get '/logs', ->
    files = fs.readdirSync esp.LOGFILE_STORAGE
    p = []
    try
      for each in files when each isnt 'README'
        xStat = fs.statSync esp.LOGFILE_STORAGE + '/' + each
        xStat.name = each
        xStat.mtime = new moment(xStat.mtime).lang('zh-cn').from()
        xStat.ctime = new moment(xStat.ctime).lang('zh-cn').from()
        xStat.atime = new moment(xStat.atime).lang('zh-cn').from()
        xStat.size = filesize(xStat.size, {base: 2, round: 2}).toUpperCase()
        p.push(xStat)
      @json p
    catch err
      console.log err
      @html '', 400

  @delete '/log', ->
    data = ''
    @request.on 'data', (chunk) -> data += chunk
    @request.on 'end', =>
      try
        p = JSON.parse data
        files = fs.readdirSync esp.LOGFILE_STORAGE
        for each in p
          if each is logger.log.transports.file.filename
            fs.openSync(esp.LOGFILE_STORAGE + '/' + logger.log.transports.file.filename, 'w' )
          else fs.unlinkSync esp.LOGFILE_STORAGE + '/' + each

        @json {status:'success', result:'删除成功'}
      catch err
        console.log err.message
        @html '', 400


  @get '/logfile/:file', ->
    @response.setHeader 'X-Accel-Redirect', "/#{esp.LOGFILE_STORAGE}/#{@file}"
    @response.end()
