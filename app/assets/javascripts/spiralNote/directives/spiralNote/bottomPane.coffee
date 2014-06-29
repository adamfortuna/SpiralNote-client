angular.module('spiralNote').directive 'snEditorBottomPane', (snView, $compile)->
  replace: true
  restrict: "EA"
  scope: true
  template: """
    <div class='spiralNote--bottomPane'>

    </div>
  """
  link: (scope, element, attrs)->
    _.each snView.getForType('bottom'), (view)->
      childScope = scope.$new()
      element.append($compile(view)(childScope))
