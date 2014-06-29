angular.module('spiralNote').directive 'spiralNote', (snView)->
  replace: true
  restrict: "EA"
  scope: {}
  controller: (snCommand)->
    snCommand.init()

  template: """
    <div class='spiralNote' ng-app='spiralNote'>
      <div class='main'>
        <sn-editor-left-pane></sn-editor-left-pane>
        <sn-editor-right-pane></sn-editor-left-pane>
      </div>
    </div>
  """
