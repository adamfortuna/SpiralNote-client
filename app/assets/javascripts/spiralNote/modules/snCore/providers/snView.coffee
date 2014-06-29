angular.module('sn:core').provider 'snView', ->  
  views = {}
  viewTypes = ['sidebar', 'right', 'bottom', 'top']
  _.each viewTypes, (type)->
    views[type] = []

  @addTo = (location, html)->
    views[location] = html

  # Swap out $log for something else if you want to change log adapters
  @$get = (snApi)->
    apiViews = snApi.views()
    _.each viewTypes, (type)->
      views[type] = views[type].concat(apiViews[type] || [])

    new ->
      types: ->
        viewTypes
      
      getForType: (type)->
        views[type]

  # This is required since the $get method was being detected by angular when being returned
  return
