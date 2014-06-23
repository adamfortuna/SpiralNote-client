angular.module('fullStackClass').directive 'fscFileTreeDirectory', ($compile)->
  replace: true
  restrict: "E"
  scope: true
  template: """
    <li>
      <h3><a href='' ng-click='collapse=!collapse'>{{directory.name}}</a><h3>
      <ul ng-show='collapse'></ul>
    </li>
  """
  link: (scope, element, attrs)->
    if attrs.collapse
      scope.collapse = true
    else
      scope.collapse = false 

    fileList = element.find('ul')
    _.each scope.directory.files, (fileObj, k)->
      childScope = scope.$new()
      if fileObj.type == 'file'
        childScope.file = fileObj
        newEl = angular.element('<fsc-file-tree-file></fsc-file-tree-file>')
      else if fileObj.type == 'directory'
        childScope.directory = fileObj
        newEl = angular.element('<fsc-file-tree-directory></fsc-file-tree-directory>')
      fileList.append($compile(newEl)(childScope))
