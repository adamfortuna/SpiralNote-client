angular.module('sn:core').provider 'snApi', ->
  exposedFunctions = {}
  exposedInjectableFunctions = []
  keybindings = {}
  contextMenuObjs = {}
  views = {}
  
  # A function or plain object can be passed to this. If it's a function, then that
  # function will be passed the api object and the injector. The injector can be used
  # to manually inject services inside the function.
  @exposeToApi = (functionObj)->
    if functionObj.constructor == Function
      exposedInjectableFunctions.push(functionObj)
    else
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

  @$get = (snEventHandler, snFileSystem, $injector)->
    _.each exposedInjectableFunctions, (func)->
      _.extend(exposedFunctions, func(@, $injector))

    init: ->
      console.log('init api')
      
    modules: exposedFunctions
    
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
