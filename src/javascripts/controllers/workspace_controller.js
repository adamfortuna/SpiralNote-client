// workspaces: [{ "name": "...", "files": [] }]

// Solely responsible for getting the workspace from Firebase, or setting up a new one
angular.module('app').controller('WorkspaceController', ['$scope', '$location', '$route', 'WorkspaceService', function($scope, $location, $route, WorkspaceService) {
  $scope.id = $route.current.params.id;

  if($scope.id) {
    WorkspaceService.find($scope.id).then(function(workspace) {
      $scope.workspace = workspace;
      $scope.workspace.id = $scope.id;
    }, function() {
      alert('No Such workspace');
      $location.path('/');
    });
  } else {
    $scope.workspace = WorkspaceService.newSpace();
  }
}]);
