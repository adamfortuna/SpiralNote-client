angular.module('spiralNote').directive 'snEditorLeftPane', (snView, $compile)->
  replace: true
  restrict: "EA"
  scope: true
  template: """
    <div class='sn-editor--leftPane'>

    </div>
  """
  link: (scope, element, attrs)->
    _.each snView.leftViews(), (view)->
      childScope = scope.$new()
      element.append($compile(view)(childScope))
