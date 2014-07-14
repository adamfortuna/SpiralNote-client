angular.module('spiral:recorder').directive('spiralRecorderNew', [function() {
  return {
    replace: true,
    restrict: 'E',
    scope: {
      "workspace": "=",
    },
    templateUrl: 'templates/spiral/recorder/new.html',
    controller: function($scope) {
      $scope.recording = {};
      $scope.createRecording = function() {
        $scope.workspace.recordings = $scope.workspace.recordings || [];
        $scope.workspace.recordings.push($scope.recording);
        $scope.recording = {};
      };
    }
  };
}]);
