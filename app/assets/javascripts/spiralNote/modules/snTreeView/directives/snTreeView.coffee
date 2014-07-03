angular.module('sn:treeView').directive 'snTreeView', ($compile, snApi)->
  replace: true
  restrict: "E"
  scope: true
  template: """
    <div class='sn-treeview'>
      <a href="" ng-click="toggleRecord()">{{record ? 'Recording...':'Record'}}</a>
      <a href="" ng-click="play()">PLAY</a>
      <ul></ul>
    </div>
  """
  link: (scope, element, attrs)->
    fileList = element.find('ul')
    scope.toggleRecord = ->
      scope.record = !scope.record
      snApi.event.toggleRecord()
    
    scope.play = ->
      snApi.event.playback()

    snApi.file.dirList('./demo').then (data)->
      scope.directory = {files: data.result, name: 'demo'}
      fileList.append($compile(angular.element('<sn-tree-view-directory collapse="false"></sn-tree-view-directory>'))(scope))

    .catch (error)->
      console.log(error)
