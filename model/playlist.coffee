esp = require '../espx'
_ = require 'underscore'


class AbsolutePlaylist extends esp.Model
  @persist 'name', 'type', 'stamp', 'children', 'schedule'

  constructor: (arg) ->
    @type = 'absolutePlaylist'
    @update arg

  update: (arg) ->
    @name = arg.name if arg?.name?
    @stamp = new Date().getTime().toString()
    @schedule = _.clone arg.schedule if arg?.schedule?
    @children = _.clone arg.children if arg?.children?

  getAllAttr: ->
    range = ['id', 'name', 'type', 'stamp', 'children', 'schedule']
    _.pick @, range


class RelativePlaylist extends esp.Model
  @persist 'name', 'type', 'stamp', 'children'

  constructor: (arg) ->
    @type = 'relativePlaylist'
    @update arg

  update: (arg) ->
    @name = arg.name if arg?.name?
    @stamp = new Date().getTime().toString()
    @children = _.clone arg.children if arg?.children?

  getAllAttr: ->
    range = ['id', 'name', 'type', 'stamp', 'children']
    _.pick @, range


class Scene extends esp.Model
  @persist 'name', 'type', 'duration', 'background', 'width', 'height', 'ratio', 'children'

  constructor: (arg) ->
    @type = 'scene'
    @update arg

  update: (arg) ->
    @name = arg.name
    @duration = arg.duration
    @background = arg.background
    @width = arg.width
    @height = arg.height
    @ratio = arg.ratio
    @children = _.clone arg.children

  getAllAttr: ->
    range = ['id', 'name', 'type', 'duration', 'background', 'width', 'height', 'ratio', 'children']
    _.pick @, range


module.exports.AbsolutePlaylist = AbsolutePlaylist
module.exports.RelativePlaylist = RelativePlaylist
module.exports.Scene = Scene

