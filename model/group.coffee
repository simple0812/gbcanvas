esp = require 'esp'
_ = require 'underscore'

class Group extends esp.Model
  @persist 'name', 'boxes', 'owner'

  constructor: (arg) -> @update arg

  update: (arg) ->
    @name = arg.name if arg.name?
    @boxes = _.clone arg.boxes if arg.boxes?
    @owner = arg.owner if arg.owner?

  getAllAttr: ->
    range = ['id', 'name', 'boxes', 'owner']
    _.pick @, range

exports = module.exports = Group
