angular.module('fsc').directive 'fscEditor', (FSCView)->
  replace: true
  restrict: "EA"
  scope: {}
  controller: (fscCommand)->
    fscCommand.init()

  template: """
    <div class='fsc-editor' ng-app='fsc'>
      <fsc-editor-left-pane></fsc-editor-left-pane>
      <fsc-editor-right-pane></fsc-editor-left-pane>
    </div>
  """
