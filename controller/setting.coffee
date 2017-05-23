esp = require '../espx'
_ = require 'underscore'
Package = require '../model/package'

esp.route ->

  @get '/setting', ->
    p = Package.find()
    if p? then p = p.pop() else p = Package.create()
    @view 'setting', version: p.getVersion()

  @post '/upload/package', ->
    type = @query.type
    feedback = (res) =>
      if res.code?
        @json {status: 'success', result: res.code}
      else
        @json {status: 'fail', result: res}
    Package.upload @request, type, feedback

  @get '/package/:filename', ->
    @response.setHeader 'X-Accel-Redirect', "/#{esp.PACKAGE_STORAGE}/#{@filename}?filename=#{@filename}"
    @response.end()
  ,public: true

  @head '/package/:filename', ->
    @response.setHeader 'X-Accel-Redirect', "/#{esp.PACKAGE_STORAGE}/#{@filename}?filename=#{@filename}"
    @response.end()
  ,public: true



