angular.module("sn:fileDisplay").directive "snFileDisplay", ($timeout, snApi)->
  replace: true
  restrict: "E"
  scope: {}
  controller: ($scope)->
    $scope.activeFilePath = null
    $scope.files = []

  template: """
    <div class="sn-fileDisplay">
      <sn-file-display-tabs></sn-file-display-tabs>
      <sn-file-display-views></sn-file-display-views>
    </div>
  """
    
