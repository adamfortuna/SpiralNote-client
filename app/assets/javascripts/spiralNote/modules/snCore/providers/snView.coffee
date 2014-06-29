angular.module('sn:core').provider 'snView', ->
  sidebarViews = []
  rightViews = []
  bottomViews = []

  @addToSidebar = (html)->
    sidebarViews.push(html)
    
  @addRight = (html)->
    rightViews.push(html)
  
  @addBottom = (html)->
    bottomViews.push(html)

  # Swap out $log for something else if you want to change log adapters
  @$get = ->
    new ->
      sidebarViews: ->
        sidebarViews
      
      rightViews: ->
        rightViews
      
      bottomViews: ->
        bottomViews

  # This is required since the $get method was being detected by angular when being returned
  return
