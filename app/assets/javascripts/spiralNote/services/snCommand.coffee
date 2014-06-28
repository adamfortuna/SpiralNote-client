angular.module('spiralNote').factory 'snCommand', (snKeybindings, snContextualMenu, snSocket)->
  init: ->
    snKeybindings.init()
    snContextualMenu.init()
    snSocket.establishConnection()
