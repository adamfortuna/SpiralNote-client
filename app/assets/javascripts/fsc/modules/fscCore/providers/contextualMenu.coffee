angular.module('fsc:core').provider 'FSCContextualMenu', ->
  contextualMenuItems = {}
  @add = (menuItems)->
    _.extend(contextualMenuItems, menuItems)

  # Swap out $log for something else if you want to change log adapters
  @$get = ->
    new ->
      init: ->
        console.log("init context menu")
        console.log(contextualMenuItems)

  # This is required since the $get method was being detected by angular when being returned
  return
