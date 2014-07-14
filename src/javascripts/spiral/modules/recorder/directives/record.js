angular.module('spiral:recorder').directive('spiralRecorderRecord', ['SpiralRecording', function(SpiralRecording) {
  return {
    replace: true,
    restrict: 'E',
    scope: {
      "workspace": "=",
      "recording": "="
    },
    template: '<button ng-click="toggleRecord()"><span ng-show="record.isRecording">Stop</span><span ng-hide="record.isRecording">Start</span> Recording</button>',
    controller: function($scope) {
      $scope.record = {};
      $scope.toggleRecord = function() {
        if($scope.record.isRecording) {
          $scope.record.stop();
          $scope.recording.changes = $scope.record.changes;
          $scope.recording.initialFiles = $scope.record.initialFiles;
        } else {
          $scope.record = new SpiralRecording($scope.workspace);
          $scope.record.record();
        }
      };

      // Kill the recording object after its saved
      $scope.$watch('recording', function(recording) {
        if(_.isEmpty(recording)) {
          $scope.record = {};
        }
      });
    }
  };
}]);
