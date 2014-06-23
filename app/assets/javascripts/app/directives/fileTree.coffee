angular.module('fullStackClass').directive 'fscFileTree', (FSCSocket, $compile)->
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
      fileList.append($compile(angular.element('<fsc-file-tree-directory></fsc-file-tree-directory>'))(scope))
        

    .catch (error)->
      console.log(error)
