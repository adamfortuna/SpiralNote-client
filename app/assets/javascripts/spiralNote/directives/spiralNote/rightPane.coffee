angular.module('spiralNote').directive 'snEditorRightPane', (snView, $compile)->
  replace: true
  restrict: "EA"
  scope: true
  template: """
    <div class='sn-editor--rightPane'>

    </div>
  """
  link: (scope, element, attrs)->
    _.each snView.rightViews(), (view)->
      childScope = scope.$new()
      element.append($compile(view)(childScope))
