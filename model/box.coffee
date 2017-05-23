esp = require 'esp'
fs = require 'fs'
path = require 'path'
_ = require 'underscore'

class Box extends esp.Model
  @persist 'name', 'alias', 'auto_screen', 'auto_snapshot', 'debug', 'network', 'service', 'interval'

  # normal attributes: publish, commands, os, version, cpu, memory, disk, boot, screen(status), play, download, snapshot, pixel, client_info
  constructor: (@name) ->
    @auto_screen = []
    @auto_snapshot = '0'
    @debug = '0'
    @interval = '60'
    @service = ''
    @network = {}

  updatePersistAttr: (arg) ->
    range = ['alias', 'auto_snapshot', 'debug', 'service', 'interval']
    @[k] = arg[k] for k in range when arg[k]?
    @auto_screen = _.clone arg.auto_screen if arg.auto_screen?
    @setNetwork arg.network if arg.network?

  updateNormalAttr: (arg) ->
    range = ['screen', 'os', 'version', 'dsmversion', 'cpu', 'memory', 'disk', 'boot', 'schedule', 'pixel', 'client_info']
    @[k] = arg[k] for k in range when arg[k]?

  setNetwork: (arg) ->
    boxes = Box.find()
    return false for each in boxes when each.network.ip is arg.ip and each.id isnt @id
    @network = _.clone arg

  clearPublish: -> @publish = []

  appendPublish: (id) ->
    @publish = [] unless @publish?
    @publish.push id
    @publish = _.uniq @publish

  clearCommands: -> @commands = []

  appendCommands: (arg, id) ->
    range = ['shutdown', 'reboot', 'snapshot', 'screenon', 'screenoff', 'reset']
    @commands = @commands or []
    if arg in range
      p = {command: arg}
      @commands.push p if _.where(@commands, p).length is 0
    else if arg is 'canceltask'
      tasks = _.where(@commands, {command: 'canceltask'}).pop() or {}
      tasks.command = 'canceltask'
      tasks.args = tasks.args or []
      tasks.args.push id if _.indexOf(tasks.args, id) is -1
      @commands.push tasks if _.where(@commands, tasks).length is 0
    else if arg is 'startup'
      console.log 'startup'
      if @network.mac
        mac = @network.mac.replace(new RegExp(":|-", "ig"), '');
        console.log mac
        info = 'FFFFFFFFFFFF'
        for i in [0..15]
          info += mac
        dgram = require 'dgram'
        msg = new Buffer info, 'hex'
        client = dgram.createSocket 'udp4'
        client.bind 30000, ->
          client.setBroadcast true
          client.send msg, 0, msg.length, 30000, '255.255.255.255', (err, bytes) ->
            console.log err if err?
            console.log bytes
            client.close()


  updateSnapshot: (base64) -> @snapshot = base64

  # device will use it to get box's following attributes
  # attributes: name, auto_screen, auto_snapshot, debug, network, service, interval || authorization, version, dsmversion, datetime (need to be set by another way)|| screen, publish, commands ToDo comfirm how to set
  getAttr: ->
    range = ['name', 'auto_screen', 'auto_snapshot', 'debug', 'network', 'service', 'interval', 'publish', 'commands']
    _.pick @, range

  getAllAttr: ->
    range = ['id', 'name', 'alias', 'auto_screen', 'auto_snapshot', 'debug', 'network', 'service',
             'interval', 'screen', 'os', 'version', 'dsmversion', 'cpu', 'memory', 'disk', 'boot',
             'schedule', 'snapshot', 'pixel', 'client_info', 'publish', 'commands', 'online']
    if @lastLinkTime?
      p = new Date().getTime()
      if p - @lastLinkTime > 180000 then @online = false else @online = true
    else
      @online = false
    _.pick @, range


exports = module.exports = Box


