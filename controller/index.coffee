esp = require '../espx'
User = require '../model/user'

esp.route ->

  @get '/index', ->
    @view 'index'

  @get '/', ->
    @view 'index'
