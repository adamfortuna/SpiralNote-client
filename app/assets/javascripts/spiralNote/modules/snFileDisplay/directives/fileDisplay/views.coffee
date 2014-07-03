angular.module("sn:fileDisplay").directive "snFileDisplayViews", ($timeout, snApi, snFileDisplay)->
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
  link: (scope, element, attrs)->
    getBuffer = (path)->
      matchingBufferEl = _.find element.find('.sn-fileBuffer'), (el)->
        angular.element(el).scope().file.path == path
      angular.element(matchingBufferEl).scope().textEditor

    scope.isActive = (file)->
      file.path == scope.activeFilePath
    
    snApi.event.on 'fileDisplay:activate', (data)->
      console.log("activate")
      console.log(data)
      console.log('--')
      scope.activeFilePath = data.path
      # $timeout ->
      #   snFileDisplay.setActiveFile(data.path, data.fileName, getBuffer(data.path))
      # ,
      #   700
