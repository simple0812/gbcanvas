esp = require 'esp'
_ = require 'underscore'

class User extends esp.Model
  @persist 'name', 'password', 'type', 'description', 'activated'

  constructor: (arg) ->
    @name = arg.name
    @password = arg.password
    if arg.type? then @type = arg.type else @type = 'normal'
    if arg.description? then @description = arg.description else @description = ''
    @activated = arg.activated or true

  update:(arg) ->
     for key, value of arg when @[key]?
        @[key] = value

  @getCurrentUserName : ()->
    token =  esp.router.ctx.cookie?.token

    user = @findone (x) -> x.id is token if token
    return user?.name or ''


exports = module.exports = User