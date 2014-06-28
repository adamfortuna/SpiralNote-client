angular.module('fsc:core').provider 'FSCApi', ->
  exposedFunctions = {}    
    
  @exposeToApi = (functionObj)->
    _.extend(exposedFunctions, functionObj)

  @$get = ->
    
    new ->
      init: ->
        console.log('init api')
        
      exposedFunctions: ->
        exposedFunctions
      
      # strPath is a colon delimited path
      # ex. treeView:file:show
      getExposedFunction: (strPath)->
        foundFunction = exposedFunctions
        _.each strPath.split(":"), (pathItem)->
          foundFunction = foundFunction[pathItem]
          unless foundFunction
            throw new Error("Function #{strPath} not found exposed to the api")

        foundFunction

  # This is required since the $get method was being detected by angular when being returned
  return
