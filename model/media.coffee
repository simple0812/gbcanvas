esp = require '../espx'
_ = require 'underscore'
fs = require 'fs'
formidable = require 'formidable'
path = require 'path'
ffmpeg = require 'fluent-ffmpeg'
archiver = require 'archiver'
async = require 'async'
mkdirp = require 'mkdirp'
uuid = require 'node-uuid'


class Media extends esp.Model

  @persist 'name', 'type', 'mtime', 'size', 'parentId', 'url', 'duration'

  constructor: (arg) ->
    super()
    options = ['name', 'type', 'size', 'parentId', 'url', 'duration']
    options.forEach (each) => @[each] = arg[each]
    @mtime = new Date().getTime().toString()

  @validate = (arg) ->
    # 简单验证
    options = ['name', 'type', 'size', 'parentId', 'url']
    for each in options
      return false unless _.has arg, each
    true

  setName: (name) ->
    # 缺少其他验证
    if typeof name is 'string' then @name = name else false
    parentMedia = Media.findone (p) => p.id is @parentId
    if parentMedia
      parentMedia.setMTime()
      parentMedia.save()
    new Date().getTime()

  updateParent: ->
    parentMedia = Media.findone (p) => p.id is @parentId
    if parentMedia
      newsize = parseInt(parentMedia.size)+1
      parentMedia.setSize newsize
      parentMedia.setMTime()
      parentMedia.save()

  setURL: (url) ->
    # 缺少其他验证
    if typeof url is 'string' then @url = url else false
    parentMedia = Media.findone (p) => p.id is @parentId
    if parentMedia
      parentMedia.setMTime()
      parentMedia.save()
    new Date().getTime()

  setMTime: ->
    @mtime = new Date().getTime().toString()

  setSize: (size) ->
    @size = size

  setDuration: (duration) ->
    @duration = duration

  destroy: () ->  # shi folder digui  delete  tichulai
    parentMedia = Media.findone (p) => p.id is @parentId
    if @type isnt 'folder'
      try
        @delete()
        extname = path.extname @name or ''
        fs.unlink path.join(esp.MEDIA_STORAGE, @id + extname), (err) ->
          console.log err if err?
        if @type is 'video'
          fs.unlink path.join(esp.SCREENSHOTS_STORAGE,"#{@id}.jpg"), (err) ->
            console.log err if err?
          # ToDo 删除失败后写入系统日志
      catch err
        console.log err
    else
      children = Media.find (p) => p.parentId is @id
      each.destroy() for each in children
      @delete()
    if parentMedia
      newsize = parseInt(parentMedia.size)-1
      parentMedia.setSize(newsize)
      parentMedia.setMTime()
      parentMedia.save()

  getAllAttr: ->
    range = ['name', 'type', 'mtime', 'size', 'parentId', 'url', 'duration']
    _.pick @, range

  @getType: (filename) ->
    extension = path.extname(filename).toLowerCase().slice 1
    switch extension
      when 'bmp', 'jpg', 'jpeg', 'png'
        return 'picture'
      when 'ppt', 'pptx'
        return 'ppt'
      when 'zip'
        return 'imageSlide'
      when 'avi', 'mp4', 'mkv', 'mpg', 'wmv', 'vob', 'asf', 'flv'
        return 'video'
      else
        return 'other'

  second2hms = (num) ->
    num = parseInt num
    return '00:00:00' if num < 0 or num > 359999
    hour = Math.floor num/3600
    min = Math.floor(num/60)%60
    sec = num % 60
    p = ''
    if hour < 10 then p = p + '0' + hour + ':' else p = p + hour + ':'
    if min < 10 then p = p + '0' + min + ':' else p = p + min + ':'
    if sec < 10 then p = p + '0' + sec else p = p + sec

  @getDuration: (media, callback) ->
    if media.type is 'video'
      extname = path.extname media.name or ''
      proc = new ffmpeg {source: path.join esp.MEDIA_STORAGE, media.id + extname}
      proc.withSize '50%'
      proc.takeScreenshots {
          count: 1 ##//图片数量  需要和时间对应，时间没有的不会生成
          timemarks: [ '1' ]#//指定时间
          filename:media.id}#//文件名时间_宽度_高度_尺寸_原视频名（有后缀）_原视频名（无后缀）_第几张图
      , esp.SCREENSHOTS_STORAGE
      , (err, filenames) ->
        return callback 'error' if err?
        callback second2hms proc.metaData.durationsec if proc?
    else
      callback '00:00:10'

  @upload: (req, pid, cb) ->
    form = new formidable.IncomingForm()
    form.encoding = 'utf-8'
    form.uploadDir = esp.TMP_DIR
    form.keepExtensions = true
    form.parse req, (err, fields, files) ->
      return cb '上传失败' if err?
      file = files['files[]']
      return cb '上传失败' unless file?
      parentMedia = Media.findone (p) -> p.id is pid
      extname = path.extname file.name or ''
      pid = '' unless parentMedia?
      medias = Media.find (p) -> p.parentId is pid
      names = []
      names.push each.name for each in medias
      p = 0
      name = path.basename file.name, extname
      while file.name in names
        p += 1
        file.name = "#{name}(#{p})#{extname}"
      p = {}
      [p.name, p.type, p.size, p.parentId] = [file.name, Media.getType(file.name), parseInt(file.size), pid]
      media = Media.create p
#      media.url = path.join '/download', media.id + extname
      media.url = '/download/' +  media.id + extname
      x = path.join esp.MEDIA_STORAGE, media.id + extname
      fs.rename file.path, x, (err) ->
        if err?
          media.delete()
          cb "未知错误，#{file.name} 上传失败"
        else
          updateMediaInfo = (duration) ->
            if duration is 'error'
              fs.unlink x, (error) ->
                console.log error if error?
                # ToDo 删除失败后写入系统日志
                media.delete()
                cb '上传的视频格式错误，请确认后上传'
            else
              media.setDuration duration
              media.save()
              media.updateParent()
              cb media
          Media.getDuration media, updateMediaInfo

  compressFileHandler = (pid, filepath, number, compressname, cb) ->
    parentMedia = Media.findone (p) -> p.id is pid
    extname = '.zip'
    tmpName = compressname + '.zip'
    pid = '' unless parentMedia?
    medias = Media.find (p) -> p.parentId is pid
    names = []
    names.push each.name for each in medias
    p = 0
    while tmpName in names
      p += 1
      tmpName = "#{compressname}(#{p})#{extname}"
    size = 0
    try
      x = fs.statSync filepath
      size = x.size
    catch err
      console.log err
    p = {}
    [p.name, p.type, p.size, p.parentId] = [tmpName, Media.getType('tmp.zip'), parseInt(size), pid]
    media = Media.create p
    media.url = path.join '/download', media.id + extname
    x = path.join esp.MEDIA_STORAGE, media.id + extname
    fs.rename filepath, x, (err) ->
      if err?
        media.delete()
        cb false
      else
        duration = second2hms 10 * parseInt(number)
        media.setDuration duration
        media.save()
        media.updateParent()
        cb true

  @compress: (pid, tmpDir, compressname, cb) ->
    p = path.join esp.TMP_DIR, tmpDir
    zipPath = path.join esp.TMP_DIR, tmpDir + '.zip'
    try
      files = fs.readdirSync p
    catch err
      console.log err if err?
      cb false
    output = fs.createWriteStream zipPath
    archive = archiver 'zip'
    output.on 'close', ->
      async.map files, (file, cb) ->
        fs.unlink path.join(p, file), (err) -> cb err, file
      , (err, results) ->
        if err? then console.log err else fs.rmdir p, (err) -> console.log err if err?
      compressFileHandler pid, zipPath, files.length, compressname, cb
    archive.on 'error', (err) ->
      console.log err if err?
      cb false
    archive.pipe output
    for each in files
      archive.append fs.createReadStream(path.join p, each), {name: each}
    archive.finalize()

  @uploadPPT: (req, cb) ->
    form = new formidable.IncomingForm()
    form.encoding = 'utf-8'
    tmpDir = uuid.v1()
    uploadDir = path.join esp.TMP_DIR, tmpDir
    try
      mkdirp.sync uploadDir
    catch err
      console.log err if err?
    form.uploadDir = uploadDir
    form.keepExtensions = true
    files = []
    finish = ->
      try
        fs.renameSync each.path, path.join(uploadDir, each.name) for each in files
        cb tmpDir
      catch err
        console.log err if err?
    form.on 'fileBegin', (name, file) -> files.push file
    form.on 'file', (name, file) ->
    form.on 'aborted', ->
      for each in files
        fs.unlink each.path, (err) -> console.log err if err?
    form.on 'error', (err) ->
      console.log err if err?
      try
        fs.unlinkSync each.path for each in files
        fs.rmdirSync uploadDir
      catch err
        console.log err if err?
    form.on 'end', finish
    form.parse req

exports = module.exports = Media
