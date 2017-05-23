esp = require 'esp'
User = require '../model/user'
BoxUnionUser = require '../model/boxunionuser'
_ = require 'underscore'
logger = require '../model/logger'
md5 = require('blueimp-md5').md5


esp.route ->

  @put '/admin/init', ->
    admin = User.findone (x) -> x.type is 'administrator' and x.name is 'admin'
    options =
      name: 'admin'
      password: md5 'admin'
      type: 'administrator'
    User.create options unless admin?
    dev = User.findone (x) -> x.type is 'administrator' and x.name is 'shgbit'
    options =
      name: 'shgbit'
      password: md5 'shgbit123'
      type: 'administrator'
    User.create options unless dev?
    @html ''
  ,public: true

  @put '/admin/reset', ->
    admin = User.findone (x) -> x.type is 'administrator' and x.name is 'admin'
    options =
      name: 'admin'
      password: md5 'admin'
      type: 'administrator'
    if admin?
      admin.update options
      admin.save()
    @html ''
  ,public: true

  @get '/user', -> @view 'user'

  @get '/users', ->
    p = (User.find (x) -> x.type is 'normal') or []
    x = _.map p, (each) ->
      _.pick(each, 'id', 'name', 'password', 'type', 'description', 'activated', 'boxes')
    @json x, 2

  @get '/user/:id', ->
    user = User.findone (x) => x.id is @id
    return @json {status: 'failed'} unless user?
    @json {status: 'success',result: user}


  @post '/user', ->
    data = ''
    @request.on 'data', (chunk) -> data += chunk
    @request.on 'end', =>
      try
        p = JSON.parse data
        x = User.findone (x) ->x.name is p.name
        return @html '', 409 if x?
        user = User.create p
        user.save()
        logger.info User.getCurrentUserName() + "添加用户 #{user.name} 成功", {'action': logger.action.add, 'source': logger.source.user}
        @json user, 2
      catch err
        logger.error User.getCurrentUserName() + "添加用户 #{user.name} 失败", {'action': logger.action.add, 'source': logger.source.user}
        @json {status: 'failed', result: 'Got an error!'}

  @put '/user/:id', ->
    xid = @id
    user = User.findone (x) -> x.id is xid
    return @json {status: 'failed'} unless user?
    data = ''
    @request.on 'data', (chunk) -> data += chunk
    @request.on 'end', =>
      try
        p = JSON.parse data
        [user.name, user.password, user.type, user.description, user.activated] = [p.name, p.password, p.type, p.description, p.activated]
#        user.update(p)
        user.save()
        console.log user.name
        logger.info User.getCurrentUserName() + "编辑用户 #{user.name} 成功" , {'action': logger.action.edit, 'source': logger.source.user}
        @json {status: 'success',result:user }
      catch err
        logger.error User.getCurrentUserName() + "编辑用户失败", {'action': logger.action.edit, 'source': logger.source.user}
        @json {status: 'failed', result: 'Got an error!'}

  @put '/user/:id/password', ->
    user = User.findone (x) => x.id is @id
    return @json {status: 'failed',message:"用户不存在"} unless user?
    data = ''
    @request.on 'data', (chunk) -> data += chunk
    @request.on 'end', =>
      try
        p = JSON.parse data
        return @json {status: 'failed',result:"原始密码错误"}  unless user.password is p.oldpassword
        console.log user.password
        console.log p.oldpassword
        console.log p.newpassword
  #        {password:}
        user.update({password:p.newpassword})
        user.save()
        @json {status: 'success',result:user }
      catch err
        console.log err
        @json {status: 'failed', result: 'Got an error!'}

  @post '/authorize/:id', ->
    data = ''
    xId = @id
    @request.on 'data', (chunk) -> data += chunk
    @request.on 'end', =>
      try
        console.log data
        boxUnionUsers = BoxUnionUser.find (x) -> x.userId is xId
        each.delete() for each in boxUnionUsers

        p = JSON.parse data
        console.log p
        for each in p
          BoxUnionUser buu = BoxUnionUser.create @id, each
          buu.save()
        @json {status: 'success', result: ''}
      catch err
        @json {status: 'failed', result: 'Got an error!'}

  @get '/user/boxes/:id', ->
    boxUnionUsers = BoxUnionUser.find (x) => x.userId is @id
    @json boxUnionUsers || []

  @delete '/user/:id', ->
    xid = @id
    user = User.findone (x) -> x.id is xid
    return @json {status: 'failed', result:'用户不存在'} unless user?
    user.delete()
    BoxUnionUser p = (BoxUnionUser.find (x) -> x.userId is xid) or []
    each.delete() for each in p
    logger.info User.getCurrentUserName() + "删除用户 #{user.name} 成功", {'action': logger.action.delete, 'source': logger.source.user}
    @json {status: 'success', result: ''}

  @delete '/users', ->
    data = ''
    @request.on 'data', (chunk) -> data += chunk
    @request.on 'end', =>
      try
        p = JSON.parse data
        for each in p
          user = User.findone (x) -> x.id is each
          user.delete() unless user.type is 'adminitrator'
          logger.info User.getCurrentUserName() + "删除用户 #{user.name} 成功", {'action': logger.action.delete, 'source': logger.source.user}
        @json {status: 'success', result: ''}
      catch err
        @json {status: 'failed', result: 'Got an error!'}

