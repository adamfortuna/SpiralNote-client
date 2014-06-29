angular.module("sn:fileDisplay").directive "snFileDisplay", (snSocket, $rootScope, $timeout)->
  replace: true
  restrict: "E"
  scope: {}
  template: """
    <div class="sn-fileDisplay">
      <sn-fileDisplay-tabs></sn-fileDisplay-tabs>
      <sn-fileDisplay-views></sn-fileDisplay-views>
      <sn-file-buffer></sn-file-buffer>
    </div>
  """
  link: (scope, element, attrs)->
    
