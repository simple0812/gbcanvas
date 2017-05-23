esp = require '../espx'
User = require '../model/user'
querystring = require 'querystring'

esp.route ->
  @get '/login', -> @view 'login'

  @post '/login', ->
    data = ''
    @request.on 'data', (chunk) -> data += chunk
    @request.on 'end', =>
      try
        p = JSON.parse data
        p.name = p.name
        user = User.findone (x) -> x.name is p.name
        return @json {status: 'fail', result: '用户名不存在'} unless user?
        return @json {status: 'fail', result: '用户密码不匹配'} unless user.password is p.password
        return @json {status: 'fail', result: '该用户被禁用'} unless user.activated
        @setCookie token: user.id, type:user.type, name: user.name
        @json {status: 'success', result: user}
      catch err
        @clearCookie()
        @json {status: 'fail', result: 'Got an error!'}

  @get '/logout', ->
    @clearCookie()
    @redirect '/login'
