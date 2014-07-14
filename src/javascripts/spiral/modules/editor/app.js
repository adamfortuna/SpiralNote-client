angular.module('spiral:editor', []);

angular.module('spiral:editor').directive('spiralEditorContent', ['FileService', function(FileService) {
  return {
    replace: true,
    restrict: 'E',
    scope: {
      "file": "="
    },
    templateUrl: 'templates/spiral/editor/content.html',
    link: function(scope, element, attrs) {
      var editor = CodeMirror.fromTextArea(element.find("textarea")[0], {
        tabSize: 2,
        lineNumbers: true,
        autofocus: false,
        mode: FileService.syntax(scope.file)
      });
      FileService.setEditor(editor, scope.file);
    }
  };
}]);

angular.module('spiral:editor').directive('spiralEditorTab', ['FileService', function(FileService) {
  return {
    replace: true,
    restrict: 'E',
    scope: {
      "file": "="
    },
    templateUrl: 'templates/spiral/editor/tab.html',
    controller: function($scope) {
      $scope.close = function(file) {
        FileService.close(file);
      };

      $scope.activate = function(file) {
        FileService.activate(file);
      };
    }
  };
}]);
