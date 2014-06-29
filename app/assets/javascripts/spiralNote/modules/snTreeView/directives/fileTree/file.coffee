angular.module('sn:treeView').directive 'snTreeViewFile', (snApi)->
  replace: true
  restrict: "E"
  scope: true
  template: """
    <li class="sn-treeView--file">
      <div class='sn-treeView--selectOverlay' ng-if='selected'></div>
      <a href='' ng-click="showFile()">
        <i class="fa fa-file-text-o"></i>
        {{file.name}}
      </a>
    </li>
  """
  link: (scope, element, attrs)->
    
    scope.showFile = ->
      snApi.event.emit 'file:selected', {path: scope.file.path, fileName: scope.file}
        
    snApi.event.on 'file:selected', (data)->
      if scope.file.path == data.path
        scope.selected = true
      else
        scope.selected = false
    
    snApi.event.on 'directory:selected', (data)->
      scope.selected = false
      
