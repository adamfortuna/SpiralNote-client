angular.module('fsc:treeView').directive 'fscTreeViewFile', (FSCSocket, $rootScope)->
  replace: true
  restrict: "E"
  scope: true
  template: """
    <li><a href='' ng-click="showFile()">{{file.name}}</a></li>
  """
  link: (scope, element, attrs)->
    
    scope.showFile = ->
      FSCSocket.func('fsReadFile', scope.file.path).then (data)->
        $rootScope.$emit 'file:show', {fileName: scope.file.name, content: data.result, path: scope.file.path}
        
        
