angular.module('spiral').directive('spiral', ['WorkspaceManager', 'FileService', function(WorkspaceManager, FileService) {
  return {
    replace: true,
    restrict: 'E',
    scope: {
      "workspace": "="
    },
    templateUrl: 'templates/spiral/index.html',
    controller: function($scope) {
      $scope.workspaceManager = new WorkspaceManager($scope.workspace);

      $scope.openFiles = [];
      $scope.openChanged = function() {
        return FileService.openFileNames($scope.workspace.files);
      };
      $scope.$watch('openChanged()', function() {
        $scope.openFiles = FileService.openFiles($scope.workspace.files);
      });

      $scope.activeFiles = [];
      $scope.activeChanged = function() {
        return FileService.activeFileNames($scope.workspace.files);
      };
      $scope.$watch('activeChanged()', function() {
        $scope.activeFiles = FileService.activeFiles($scope.workspace.files);
      });

      $scope.save = $scope.workspaceManager.save;
    }
  };
}])
