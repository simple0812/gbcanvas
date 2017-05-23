esp = require 'esp'
_ = require 'underscore'

class Task extends esp.Model
  @persist 'stamp', 'schedule', 'scheduleName', 'boxes', 'isCancelled'

  constructor: (schedule, scheduleName) ->
    @stamp = new Date().getTime().toString()
    @schedule = schedule or ''
    @scheduleName = scheduleName or ''
    @boxes = []
    @isCancelled = false

  getAllAttr: ->
    range = ['id', 'stamp', 'schedule', 'scheduleName', 'boxes', 'isCancelled']
    _.pick @, range

  @removeBoxes: (task, boxes) ->
    task.boxes = _.difference task.boxes, boxes
    task.isCancelled = true if task.boxes.length is 0
    task.save()


exports = module.exports = Task
