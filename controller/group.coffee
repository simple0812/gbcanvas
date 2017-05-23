esp = require '../espx'
Group = require '../model/group'
_ = require 'underscore'


esp.route ->

  @get '/groups', ->

    userId = @cookie['token']
    p =  Group.find (x) -> x.owner is userId
    groups = _.map p, (each) -> each.getAllAttr()
    @json groups, 2


  @post '/group', ->
    data = ''
    @request.on 'data', (chunk) -> data += chunk
    @request.on 'end', =>
      try
        p = JSON.parse data
        groups = Group.find()
        x = _.where groups, {name: p.name, owner: @cookie['token']}
        return @html '', 409 unless 0 is x.length
        group = Group.create p
        @json group.getAllAttr(), 2
      catch err
        console.log err
        @html '', 400


  @put '/group/:id', ->
    data = ''
    @request.on 'data', (chunk) -> data += chunk
    @request.on 'end', =>
      try
        p = JSON.parse data
        group = Group.find @id
        return html '', 404 unless group?
        unless group.name is p.name
          groups = Group.find()
          x = _.where groups, {name: p.name}
          return @html '', 409 unless 0 is x.length
        group.update p
        group.save()
        @json group.getAllAttr(), 2
      catch err
        console.log err
        @html '', 400


  @delete '/group/:id', ->
    p = Group.find @id
    @html '', 404 unless p?
    p.delete()
    @html '', 200


  @delete '/groups', ->
    data = ''
    @request.on 'data', (chunk) -> data += chunk
    @request.on 'end', =>
      try
        p = JSON.parse data
        for each in p
          x = Group.find each
          x.delete() if x?
        @html '', 200
      catch err
        console.log err
        @html '', 400

