angular.module('fsc:fileDisplay').directive 'fscFileDisplay', (FSCSocket, $rootScope)->
  replace: true
  restrict: "E"
  scope: {}
  template: """
    <div>
      <textarea></textarea>
      <button ng-click='save()'>save</button>
    </div>
  """
  link: (scope, element, attrs)->
    scope.textEditor = CodeMirror.fromTextArea element.find('textarea')[0],
      tabSize: 2
      lineNumbers: true
      autofocus: false
    
    $rootScope.$on 'file:show', (evt, data)->
      scope.filePath = data.path
      scope.textEditor.setValue(data.content)
    
    scope.save = ->
      FSCSocket.func 'fsSaveFileBuffer', {path: scope.filePath, contents: scope.textEditor.getValue()}
    
