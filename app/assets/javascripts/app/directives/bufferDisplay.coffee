angular.module('fullStackClass').directive 'fscBufferDisplay', ->
    replace: true
    restrict: "E"
    scope: true
    template: """
      <textarea></textarea>
    """
    link: (scope, element, attrs)->
      scope.textEditor = CodeMirror.fromTextArea element[0],
      tabSize: 2
      lineNumbers: true
      autofocus: false
      
