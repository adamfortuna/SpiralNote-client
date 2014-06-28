angular.module('fsc').factory 'fscCommand', (FSCKeybindings, FSCContextualMenu, FSCSocket)->
  init: ->
    FSCKeybindings.init()
    FSCContextualMenu.init()
    FSCSocket.establishConnection()
