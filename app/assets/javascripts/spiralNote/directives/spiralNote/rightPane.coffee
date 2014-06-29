angular.module('spiralNote').directive 'snEditorRightPane', (snView, $compile)->
  replace: true
  restrict: "EA"
  scope: true
  template: """
    <div class='spiralNote--rightPane'>

    </div>
  """
  link: (scope, element, attrs)->
    _.each snView.getForType('right'), (view)->
      childScope = scope.$new()
      element.append($compile(view)(childScope))
