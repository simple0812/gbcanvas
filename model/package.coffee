esp = require '../espx'
fs = require 'fs'
path = require 'path'
_ = require 'underscore'
formidable = require 'formidable'

android_regex = /DigitalSignage-\d+\.apk/
deamon4android_regex = /DSMonitor-sign-\d+\.apk/
windows_regex = /DigitalSignage-\d+\.app/

class Package extends esp.Model
  @persist 'android', 'deamon4android', 'windows'

  constructor: ->
    @android =
      name: ''
      code: ''
      url: ''
      force: 'false'
    @deamon4android =
      name: ''
      code: ''
      url: ''
      force: 'false'
    @windows =
      name: ''
      code: ''
      url: ''
      force: 'false'

  # arg: name, code, url, path
  updateAndroid: (arg) ->
    if @android.name
      oldPath = path.join esp.PACKAGE_STORAGE, @android.name
      fs.unlink oldPath, (err) =>
        console.log err if err?
        # ToDo add to logger
        @android.name = arg.name if arg.name?
        @android.code = arg.code if arg.code?
        @android.url = arg.url if arg.url?
        newPath = path.join esp.PACKAGE_STORAGE, @android.name
        fs.rename arg.path, newPath, (err) ->
          console.log err if err?
          # ToDo add to logger
    else
      @android.name = arg.name if arg.name?
      @android.code = arg.code if arg.code?
      @android.url = arg.url if arg.url?
      newPath = path.join esp.PACKAGE_STORAGE, @android.name
      fs.rename arg.path, newPath, (err) ->
        console.log err if err?
        # ToDo add to logger

  updateD4A: (arg) ->
    if @deamon4android.name
      oldPath = path.join esp.PACKAGE_STORAGE, @deamon4android.name
      fs.unlink oldPath, (err) =>
        console.log err if err?
        # ToDo add to logger
        @deamon4android.name = arg.name if arg.name?
        @deamon4android.code = arg.code if arg.code?
        @deamon4android.url = arg.url if arg.url?
        newPath = path.join esp.PACKAGE_STORAGE, @deamon4android.name
        fs.rename arg.path, newPath, (err) ->
          console.log err if err?
          # ToDo add to logger
    else
      @deamon4android.name = arg.name if arg.name?
      @deamon4android.code = arg.code if arg.code?
      @deamon4android.url = arg.url if arg.url?
      newPath = path.join esp.PACKAGE_STORAGE, @deamon4android.name
      fs.rename arg.path, newPath, (err) ->
        console.log err if err?
        # ToDo add to logger

  updateWindows: (arg) ->
    if @windows.name
      oldPath = path.join esp.PACKAGE_STORAGE, @windows.name
      fs.unlink oldPath, (err) =>
        console.log err if err?
        # ToDo add to logger
        @windows.name = arg.name if arg.name?
        @windows.code = arg.code if arg.code?
        @windows.url = arg.url if arg.url?
        newPath = path.join esp.PACKAGE_STORAGE, @windows.name
        fs.rename arg.path, newPath, (err) ->
          console.log err if err?
          # ToDo add to logger
    else
      @windows.name = arg.name if arg.name?
      @windows.code = arg.code if arg.code?
      @windows.url = arg.url if arg.url?
      newPath = path.join esp.PACKAGE_STORAGE, @windows.name
      fs.rename arg.path, newPath, (err) ->
        console.log err if err?
        # ToDo add to logger

  update: (file) ->
    if file.type is 'android'
      @updateAndroid file
    else if file.type is 'deamon4android'
      @updateD4A file
    else if file.type is 'windows'
      @updateWindows file
    else
      false

  getANDVersion: -> _.pick @android, 'code', 'url', 'force'
  getD4AVersion: -> _.pick @deamon4android, 'code', 'url', 'force'
  getWINVersion: -> _.pick @windows, 'code', 'url', 'force'
  getVersion: ->
    p = {}
    [p.android, p.deamon4android, p.windows]  = [@getANDVersion(), @getD4AVersion(), @getWINVersion()]
    return p

  @getCode: (file) ->
    code = ''
    if file.type is 'android'
      unless android_regex.test file.name
        return false
        fs.unlink file.path, (err) ->
          console.log err if err?
    else if file.type is 'deamon4android'
      unless deamon4android_regex.test file.name
        return false
        fs.unlink file.path, (err) ->
          console.log err if err?
    else if file.type is 'windows'
      unless windows_regex.test file.name
        return false
        fs.unlink file.path, (err) ->
          console.log err if err?
    else
      return false
    p = path.basename file.name, path.extname file.name
    code = p.split('-').pop()

  @upload: (req, type, cb) ->
    form = new formidable.IncomingForm()
    form.encoding = 'utf-8'
    form.uploadDir = esp.TMP_DIR
    form.keepExtensions = true
    form.parse req, (err, fields, files) ->
      return cb '上传失败' if err?
      file = files['file']
      return cb '上传失败' unless file?
      file.type = type
      file.url = path.join '/package', file.name
      code = Package.getCode file
      return cb '升级包不正确，请确认后再上传' unless code
      file.code = code
      p = Package.find().pop()
      p.update file
      p.save()
      cb {code: code}

exports = module.exports = Package
