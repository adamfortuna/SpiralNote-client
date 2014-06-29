angular.module('sn:fileDisplay').config (snApiProvider)->
  
  # HACK: This kills the default cmd/ctrl+s saving page functionality
  document.addEventListener "keydown", (e)->
    modKey = if navigator.platform.match("Mac") then e.metaKey else e.ctrlKey
    if e.keyCode == 83 && modKey
      e.preventDefault()

  snApiProvider.keyBindings.add
    '.file-display':
      '⌘+S': 'fileDisplay:saveActive'
