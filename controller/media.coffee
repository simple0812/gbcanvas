esp = require 'esp'
User = require '../model/user'
_ = require 'underscore'
Media = require '../model/media'
path = require 'path'
logger = require '../model/logger'

esp.route ->
  @get '/ML', ->
    @view 'media'

  @get '/medias', ->
    p = Media.find()
    media = _.map p, (each) -> _.pick(each, 'id', 'type', 'name', 'mtime', 'size', 'parentId', 'url', 'duration', 'children')
    @json media, 2

  @get '/media/:id', ->
    p = Media.find @id
    if p? then @json p.getAllAttr(), 2 else @json {}

  @post '/media', ->
    data = ''
    @request.on 'data', (chunk) -> data += chunk
    @request.on 'end', =>
      try
        p = JSON.parse data
        medias = Media.find (x) -> x.parentId is p.parentId and x.type is p.type
        names = []
        names.push each.name for each in medias
        if p.name in names
          extname = path.extname p.name
          if extname
            name = path.basename p.name, extname
          else
            name = p.name
          y = 1
          y += 1 while "#{name}(#{y})#{extname}" in names
          p.name = "#{name}(#{y})#{extname}"
        media = Media.create p
        media.updateParent()
        logger.info User.getCurrentUserName() + "添加媒体库文件 #{media.name} 成功", {'action': logger.action.add, 'source': logger.source.media}
        @json {status: 'success', result:  _.pick(media,'id', 'name', 'type', 'mtime',
          'size', 'parentId', 'url', 'duration' )}
      catch err
        console.log err
        logger.error User.getCurrentUserName() + "添加媒体库文件失败", {'action': logger.action.add, 'source': logger.source.media}
        @json {status: 'failed'}

  @put '/media/:id', ->
    data = ''
    @request.on 'data', (chunk) -> data += chunk
    @request.on 'end', =>
      try
        p = JSON.parse data
        mtime = ''
        media = Media.findone (p) => p.id is @id
        if p.name isnt media.name
          medias = Media.find (x) -> x.parentId is p.parentId and x.type is p.type
          names = []
          names.push each.name for each in medias when each.name isnt media.name
#          names = _.without(names,media.name);
  #        console.log names.length
          if p.name in names
            extname = path.extname p.name
            if extname
              name = path.basename p.name, extname
            else
              name = p.name
            y = 1
            y += 1 while "#{name}(#{y})#{extname}" in names
            p.name = "#{name}(#{y})#{extname}"
          mtime = media.setName(p.name)
        mtime = media.setURL(p.url) unless p.url is media.url
#        console.log 'sss' unless p.url is media.url
        media.save()
        logger.info User.getCurrentUserName() + "编辑媒体库文件 #{media.name} 成功", {'action': logger.action.edit, 'source': logger.source.media}
        @json {status: 'success',result:mtime}
      catch err
        console.log err.message
        logger.error User.getCurrentUserName() + "编辑媒体库文件失败", {'action': logger.action.edit, 'source': logger.source.media}
        @json {status: 'failed'}

  @delete '/media/:id', ->
    p = Media.findone (x) => x.id is @id
    try
      p.destroy()
      parentMedia = Media.findone (x) -> x.id is p.parentId
      mtime = parentMedia?.mtime or new Date().getTime()
      logger.info User.getCurrentUserName() + "删除媒体库文件 #{p.name} 成功", {'action': logger.action.delete, 'source': logger.source.media}
      @json {status: 'success',result:mtime}
    catch err
      logger.error User.getCurrentUserName() + "删除媒体库文件失败", {'action': logger.action.delete, 'source': logger.source.media}
      @json {status:'failed', result:'io err'}

  @delete '/medias', ->
    data = ''
    @request.on 'data', (chunk) -> data += chunk
    @request.on 'end', =>
      try
        p = JSON.parse data
        for each in p
          media = Media.findone (x) => x.id is each
          media.destroy()
          parentMedia = Media.findone (x) -> x.id is media.parentId
          mtime = parentMedia?.mtime  or new Date().getTime()
          logger.info User.getCurrentUserName() + "删除媒体库文件 #{media.name} 成功", {'action': logger.action.delete, 'source': logger.source.media}
        @json {status: 'success',result:mtime}
      catch err
        console.log err
        logger.error User.getCurrentUserName() + "删除媒体库文件失败", {'action': logger.action.delete, 'source': logger.source.media}
        @json {status: 'failed'}

  @put '/medias/move', ->
    data = ''
    @request.on 'data', (chunk) -> data += chunk
    @request.on 'end', =>
      try
        p = JSON.parse data
        successful = []
        failed = []
        destMedia = Media.findone (x) -> x.id is p.mediasTo
        if destMedia?
          destMediaChildren = Media.find (x) -> x.parentId is destMedia.id
        else
          destMediaChildren = Media.find (x) -> x.parentId is ''
        for id in p.moveMedias
          if id is p.mediasTo
            failed.push id
            continue
          media = Media.findone (x) -> x.id is id
          isExists = false
          isExists = true for each in destMediaChildren when each.name is media.name

          if isExists
            failed.push id
            continue
          parentMedia = Media.findone (x) -> x.id is media.parentId
          if parentMedia
            parentMedia.size -= 1
            parentMedia.setMTime()
            parentMedia.save()

          if destMedia?
            destMedia.size += 1
            destMedia.setMTime()
            destMedia.save()
            media.parentId = destMedia.id
          else
            media.parentId = ''
          media.save()

          successful.push id

        return @json {status: 'fail', result: '部分或全部文件移动失败'} unless successful.length is p.moveMedias.length
        @json {status: 'success', result: '移动成功'}
      catch err
        @json {status: 'fail', result: 'Got an error!',err:err.message}

  @post '/upload/media', ->
    pid = @query.path
    feedback = (arg) =>
      res = {status: 'fail', result: ''}
      if arg instanceof Media
        [res.status, res.result] = ['success', arg]
      else
        res.result = arg
      @json res
    Media.upload @request, pid, feedback

  @post '/uploadPPT', ->
    feedback = (arg) =>
      result = {status: null, message: null}
      if arg then [result.status, result.message] = [ 'success', arg] else [result.status, result.message] = ['fail', '上传失败']
      @json result
    Media.uploadPPT @request, feedback

  @post '/compressPPT', ->
    pid = @query.path
    compressname = @query.compressname
    tmpDir = @query.tmpDir
    feedback = (arg) =>
      result = {status: null, message: null}
      if arg then [result.status, result.message] = [ 'success', arg] else [result.status, result.message] = ['fail', '压缩失败']
      @json result
    if compressname isnt undefined and tmpDir isnt undefined
      Media.compress pid, tmpDir, compressname, feedback
    else
      feedback false

  @get '/download/:file', ->
    id = path.basename @file, path.extname @file
    file = Media.find id
    return @html '', 404 unless file?
    url = "/#{esp.MEDIA_STORAGE}/#{@file}"
    @response.setHeader 'X-Accel-Redirect', "/#{esp.MEDIA_STORAGE}/#{@file}?filename=#{@file}"
    @response.end()
  ,public: true

  @get '/downloadfile/:file', ->
    id = path.basename @file, path.extname @file
    file = Media.find id
    filename = @query.filename
    console.log @file
    console.log filename
    return @html '', 404 unless file?
    url = "/#{esp.MEDIA_STORAGE}/#{@file}"
    @response.setHeader 'X-Accel-Redirect', "/#{esp.MEDIA_STORAGE}/#{@file}?filename=#{encodeURIComponent(filename)}"
    @response.end()

  @head '/download/:file', ->
    id = path.basename @file, path.extname @file
    file = Media.find id
    return @html '', 404 unless file?
    url = "/#{esp.MEDIA_STORAGE}/#{@file}"
    @response.setHeader 'X-Accel-Redirect', "/#{esp.MEDIA_STORAGE}/#{@file}?filename=#{@file}"
    @response.end()
  ,public: true

