angular.module('fsc:treeView').factory 'fscTreeView', ->
  selectFile: (path)->
    console.log("selecting file: #{path}")
    
  openFile: (path)->
    console.log("opening file: #{path}")
  
  expandDirectory: (path)->
    console.log("expanding directory: #{path}")
  
  
