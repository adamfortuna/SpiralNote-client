angular.module("sn:fileDisplay").directive "snFileDisplayTabs", ($timeout, snApi)->
  replace: true
  restrict: "E"
  scope: true
  template: """
    <div class="sn-fileDisplay--tabs">
      <ul class="sn-fileDisplay--tabList">
        <li ng-repeat='file in files' class='sn-fileDisplay--tab' ng-class="{'is-selected': isSelected(file)}">
          <a href='' ng-click='activate(file)'>{{file.fileName}}</a>
          <a href='' ng-click='closeFile(file)'><i class="fa fa-times-circle-o"></i></a>
        </li>
      </ul>
    </div>
  """
  link: (scope, elements, attrs)->    
    scope.isSelected = (file)->
      file.path == scope.activeFilePath

    scope.activate = (file)->
      scope.activeFilePath = file.path
      snApi.event.emit 'fileDisplay:activate', {fileName: file.fileName, path: file.path}
    
    scope.closeFile = (file)->
      scope.files.splice(scope.files.indexOf(file), 1)
      
    snApi.event.on 'file:selected', (data)->
      scope.selectedFilePath = data.path
      existingFile = _.find scope.files, (file)->
        file.path == data.path
      
      unless existingFile
        newFile = {fileName: data.fileName, path: data.path}
        scope.files.push(newFile)
        scope.activate(newFile)
        
