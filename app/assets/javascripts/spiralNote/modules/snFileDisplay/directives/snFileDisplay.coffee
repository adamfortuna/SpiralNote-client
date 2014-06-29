angular.module('sn:fileDisplay').directive 'snFileDisplay', (snSocket, $rootScope, $timeout)->
  replace: true
  restrict: "E"
  scope: {}
  template: """
    <div class='sn-fileDisplay'>
      <textarea></textarea>
      <div class='bg-overlay'></div>
    </div>
  """
  link: (scope, element, attrs)->
    scope.textEditor = CodeMirror.fromTextArea element.find('textarea')[0],
      tabSize: 2
      lineNumbers: true
      autofocus: false
    
    $timeout ->
      scope.textEditor.refresh()
    
    $rootScope.$on 'file:show', (evt, data)->
      scope.filePath = data.path
      scope.textEditor.setValue(data.content)
    
    scope.save = ->
      snSocket.func 'fsSaveFileBuffer', {path: scope.filePath, contents: scope.textEditor.getValue()}
    
