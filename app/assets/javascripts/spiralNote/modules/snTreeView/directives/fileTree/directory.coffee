angular.module('sn:treeView').directive 'snTreeViewDirectory', ($compile)->
  replace: true
  restrict: "E"
  scope: true
  template: """
    <li class="sn-treeView--directory">
      <h3>
        <a href='' ng-click='collapse=!collapse'>
          <i ng-class="{'fa fa-caret-down': !collapse, 'fa fa-caret-right': collapse}"></i>
          <i class="fa fa-folder-o"></i>
          {{directory.name}}
        </a>
      <h3>
      <ul ng-show='!collapse'></ul>
    </li>
  """
  link: (scope, element, attrs)->
    if attrs.collapse == "false"
      scope.collapse = false
    else
      scope.collapse = true

    fileList = element.find('ul')
    files = []
    _.each scope.directory.files, (fileObj, k)->
      childScope = scope.$new()
      if fileObj.type == 'file'
        files.push(fileObj)
      else if fileObj.type == 'directory'
        childScope.directory = fileObj
        newEl = angular.element('<sn-tree-view-directory></sn-tree-view-directory>')
      fileList.append($compile(newEl)(childScope))
      
    _.each files, (fileObj)->
      childScope = scope.$new()
      childScope.file = fileObj
      newEl = angular.element('<sn-tree-view-file></sn-tree-view-file>')
      fileList.append($compile(newEl)(childScope))
