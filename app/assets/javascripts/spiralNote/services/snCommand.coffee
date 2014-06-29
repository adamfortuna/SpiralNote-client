angular.module('spiralNote').factory 'snCommand', (snKeybindings, snContextMenu, snSocket)->
  init: ->
    snKeybindings.init()
    snContextMenu.init()
    snSocket.establishConnection()
