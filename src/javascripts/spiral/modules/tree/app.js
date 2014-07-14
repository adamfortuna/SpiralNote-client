angular.module('spiral:tree', ['spiral']); // depends on spiral for RecursionHelper

// Recursive directive for displaying all files given a file with a nested array of files.
// The "root" file should be the base directory. ex:
//   { "name": "demo", "type": "directory", "files": [directory, directory, file, file] }
angular.module('spiral:tree').directive('spiralTree', ['RecursionHelper', 'FileService', function(RecursionHelper, FileService) {
  return {
    replace: true,
    restrict: 'E',
    scope: {
      "file": "="
    },
    templateUrl: 'templates/spiral/tree/index.html',
    controller: function($scope) {
      $scope.itemClicked = function(file) {
        if(file.type === 'file') {
          FileService.activate(file);
        } else {
          FileService.expand(file);
        }
      }
    },
    compile: function(element){
      return RecursionHelper.compile(element);
    }
  }
}]);

// Folder/File icon next to each item in the tree. Also icons for expanded directories
angular.module('spiral:tree').directive('spiralTreeIcon', function() {
  return {
    replace: true,
    restrict: 'E',
    scope: {
      file: '='
    },
    templateUrl: 'templates/spiral/tree/icon.html'
  };
});
