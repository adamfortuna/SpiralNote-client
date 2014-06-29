angular.module('sn:core').provider 'snApi', ->
  exposedFunctions = {}    
  keybindings = {}
  contextMenuObjs = {}
  views = {}
    
  @exposeToApi = (functionObj)->
    _.extend(exposedFunctions, functionObj)
    
  @keyBindings = 
    add: (keyBindingObj)->
      _.extend(keybindings, keyBindingObj)
  
  @menu = 
    context:
      add: (menuObj)->
        _.extend(contextMenuObjs, menuObj)
  
  @view = 
    addTo: (location, html)->
      views[location] ||= []
      views[location].push(html)

  @$get = (snEventHandler, snFileSystem)->
    
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
      
      keyBindings: ->
        keybindings
        
      contextMenuItems: ->
        contextMenuObjs
        
      views: ->
        views
      
      event: new snEventHandler()
      
      file: new snFileSystem()

  # This is required since the $get method was being detected by angular when being returned
  return
