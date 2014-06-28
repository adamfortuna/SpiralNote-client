angular.module('sn:treeView').factory 'snTreeView', ->
  selectFile: (path)->
    console.log("selecting file: #{path}")
    
  openFile: (path)->
    console.log("opening file: #{path}")
  
  expandDirectory: (path)->
    console.log("expanding directory: #{path}")
  
  
