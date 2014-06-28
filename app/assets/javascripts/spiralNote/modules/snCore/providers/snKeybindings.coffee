angular.module('sn:core').provider 'snKeybindings', ->
  keybindings = {}
  @registerKeyBindings = (keybindingObj)->
    _.extend(keybindings, keybindingObj)

  @$get = ->
    new ->
      init: ->
        console.log("keybindings init:")
        console.log(keybindings)

  # This is required since the $get method was being detected by angular when being returned
  return
