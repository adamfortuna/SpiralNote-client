angular.module('sn:core').provider 'snContextMenu', ->
  contextMenuItems = {}
  @add = (menuItems)->
    _.extend(contextMenuItems, menuItems)

  # Swap out $log for something else if you want to change log adapters
  @$get = (snApi)->
    _.extend(contextMenuItems, snApi.contextMenuItems())
    new ->
      init: ->
        console.log("init context menu")
        console.log(contextMenuItems)

  # This is required since the $get method was being detected by angular when being returned
  return
