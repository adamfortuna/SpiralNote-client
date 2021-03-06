angular.module('sn:treeView').directive 'snTreeView', ($compile, snApi)->
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

    snApi.file.dirList('./demo').then (data)->
      scope.directory = {files: data.result, name: 'demo'}
      fileList.append($compile(angular.element('<sn-tree-view-directory collapse="false"></sn-tree-view-directory>'))(scope))

    .catch (error)->
      console.log(error)
