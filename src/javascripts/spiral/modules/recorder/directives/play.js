// Todo: 

angular.module('spiral:recorder').directive('spiralRecorderPlay', ['SpiralPlayer', function(SpiralPlayer) {
  return {
    replace: true,
    restrict: 'E',
    scope: {
      "recording": "="
    },
    templateUrl: 'templates/spiral/recorder/play.html',
    controller: function($scope) {
      $scope.player = new SpiralPlayer($scope.recording);

      $scope.play = function() {
        // In case the recording changed, make a new player
        $scope.player = new SpiralPlayer($scope.recording);
        $scope.player.play(function() {
          if(!$scope.$$phase) { $scope.$apply(); }
        });
      };

      $scope.pause = function() {
        $scope.player.pause();
      };

      $scope.resume = function() {
        $scope.player.resume();
      };
    }
  };
}]);
