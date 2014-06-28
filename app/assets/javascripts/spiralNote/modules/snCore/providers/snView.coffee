angular.module('sn:core').provider 'snView', ->
  leftViews = []
  rightViews = []
  @addLeft = (html)->
    leftViews.push(html)
    
  @addRight = (html)->
    rightViews.push(html)

  # Swap out $log for something else if you want to change log adapters
  @$get = ->
    new ->
      leftViews: ->
        leftViews
      
      rightViews: ->
        rightViews

  # This is required since the $get method was being detected by angular when being returned
  return
