angular.module('spiral:recorder').directive('spiralRecorderRecording', [function() {
  return {
    replace: true,
    restrict: 'E',
    scope: {
      "recording": "="
    },
    templateUrl: 'templates/spiral/recorder/recording.html'
  };
}]);
