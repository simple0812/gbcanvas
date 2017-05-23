esp = require '../espx'
_ = require 'underscore'


class BoxUnionUser extends esp.Model

  @persist 'userId', 'boxId'

  constructor: (@userId, @boxId) ->

exports = module.exports = BoxUnionUser