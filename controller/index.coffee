esp = require 'esp'
User = require '../model/user'

esp.route ->

  @get '/index', ->
    @view 'index'

  @get '/', ->
    @view 'index'
