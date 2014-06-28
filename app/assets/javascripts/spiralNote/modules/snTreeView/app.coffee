angular.module('sn:treeView', ['sn:core']).config (snApiProvider)->
  snApiProvider.exposeToApi
    treeView:
      test: ->
        console.log('test1 function for tree view')
      
      test2: ->
        console.log('test2 function for tree view')
      
      files:
        show: (file)->
          console.log("showing file! #{file}")
