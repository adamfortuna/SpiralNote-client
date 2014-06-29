angular.module('spiralNote').directive 'spiralNote', (snView)->
  replace: true
  restrict: "EA"
  scope: {}
  controller: (snCommand)->
    snCommand.init()

  template: """
    <div class='spiralNote' ng-app='spiralNote'>
      <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">

      <div class='main'>
        <sn-editor-sidebar></sn-editor-sidebar>
        <sn-editor-right-pane></sn-editor-left-pane>
      </div>
      <sn-editor-bottom-pane></sn-editor-bottom-pane>
    </div>
  """
