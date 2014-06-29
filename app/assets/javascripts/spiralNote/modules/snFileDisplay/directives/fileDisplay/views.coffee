angular.module("sn:fileDisplay").directive "snFileDisplayViews", ($timeout, snApi)->
  replace: true
  restrict: "E"
  scope: true
  template: """
    <div class="sn-fileDisplay--views">
      <div ng-repeat='file in files'>
        <sn-file-display-buffer ng-show='isActive(file)'></sn-file-display-buffer>
      </div>
    </div>
  """
  link: (scope, elements, attrs)->
    
    scope.isActive = (file)->
      file.path == scope.activeFilePath
    
    snApi.event.on 'fileDisplay:activate', (data)->
      scope.activeFilePath = data.path
