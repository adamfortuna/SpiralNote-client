angular.module('fsc:treeView').directive 'fscTreeView', (FSCSocket, $compile)->
  replace: true
  restrict: "E"
  scope: true
  template: """
    <div>
      <ul></ul>
    </div>
  """
  link: (scope, element, attrs)->
    fileList = element.find('ul')

    FSCSocket.func('fsGetDirectoryTree', './demo').then (data)->
      scope.directory = {files: data.result, name: 'demo'}
      fileList.append($compile(angular.element('<fsc-tree-view-directory></fsc-tree-view-directory>'))(scope))

    .catch (error)->
      console.log(error)
