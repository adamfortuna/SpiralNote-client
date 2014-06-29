angular.module('sn:treeView').directive 'snTreeViewFile', (snSocket, $rootScope)->
  replace: true
  restrict: "E"
  scope: true
  template: """
    <li class="sn-treeView--file">
      <a href='' ng-click="showFile()">
        <i class="fa fa-file-text-o"></i>
        {{file.name}}
      </a>
    </li>
  """
  link: (scope, element, attrs)->
    
    scope.showFile = ->
      snSocket.func('fsReadFile', scope.file.path).then (data)->
        $rootScope.$emit 'file:show', {fileName: scope.file.name, content: data.result, path: scope.file.path}
        
        
