angular.module('sn:treeView').directive 'snTreeView', (snSocket, $compile)->
  replace: true
  restrict: "E"
  scope: true
  template: """
    <div class='sn-treeview'>
      <ul></ul>
    </div>
  """
  link: (scope, element, attrs)->
    fileList = element.find('ul')

    snSocket.func('fsGetDirectoryTree', './demo').then (data)->
      scope.directory = {files: data.result, name: 'demo'}
      fileList.append($compile(angular.element('<sn-tree-view-directory></sn-tree-view-directory>'))(scope))

    .catch (error)->
      console.log(error)
