esp = require 'esp'
Task = require '../model/task'
Box = require '../model/box'
Playlist = require '../model/playlist'
_ = require 'underscore'

esp.route ->

  @get '/task', -> @view 'task'

  @delete '/task/:id', ->
    task = Task.find @id
    return @html '', 404 unless task?
#    return @html '', 423 unless task.isCancelled
    task.delete()
    @html '', 200

  @delete '/tasks', ->
    data = ''
    @request.on 'data', (chunk) -> data += chunk
    @request.on 'end', =>
      try
        p = JSON.parse data
        for each in p
          task = Task.find each
          return @html '', 404 unless task
#          return @html '', 423 unless task.isCancelled
          task.delete()
        @html '', 200
      catch err
        console.log err
        @html '', 400

  @get '/tasks', ->
    tasks = Task.find()
    return @html '', 404 unless tasks?
    p = _.map tasks, (each) -> each.getAllAttr()
    @json p, 2

  @get '/task/:id/boxes', ->
    task = Task.find @id
    return @html '', 404 unless task?
    boxes = []
    for each in task.boxes
      box = Box.find each
      boxes.push _.pick(box, ['id', 'name', 'alias']) if box?
    @json boxes, 2

  @put '/task/:id', ->
    data = ''
    @request.on 'data', (chunk) -> data += chunk
    @request.on 'end', =>
      try
      #p = JSON.parse data
        task = Task.find @id
        return @html '', 400 unless task?
        task.isCancelled = true
        x = {boxes:[]}
        for each in task.boxes
          box = Box.find each
          if box?
            box.appendCommands 'canceltask', task.schedule
            x.boxes.push box.name
          else
            @html "#{each}", 404
        task.save()
        esp.socketio.sockets.emit 'changed', x
        @json task, 2
      catch err
        console.log err
        @html '', 400
