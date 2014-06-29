angular.module('sn:core').provider 'snKeybindings', ->
  # Override keymaster's filter function to exclude textareas so keybindings while
  # in textareas (aka codemirror) work
  key.filter = (event)->
    tagName = (event.target || event.srcElement).tagName
    # scope = if /^(INPUT|TEXTAREA|SELECT)$/.test(tagName) then 'input' else 'other'
    scope = if /^(INPUT|SELECT)$/.test(tagName) then 'input' else 'other'
    key.setScope(scope)
    return true
  
  keybindings = {}
  @registerKeyBindings = (keybindingObj)->
    _.extend(keybindings, keybindingObj)

  @$get = (snApi)->
    _.extend(keybindings, snApi.keyBindings())
    new ->
      init: ->
        _.each keybindings, (keyObject, scope)->
          _.each keyObject, (funcStr, keys)->
            key keys, snApi.getExposedFunction(funcStr)
      
      destroy: ->
        _.each keybindings, (keyObject, scope)->
          _.each keyObject, (funcStr, keys)->
            key.unbind(k, snApi.getExposedFunction(funcStr))

  # This is required since the $get method was being detected by angular when being returned
  return
