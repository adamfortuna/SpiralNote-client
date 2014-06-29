angular.module('spiralNote').directive 'snEditorSidebar', (snView, $compile)->
  replace: true
  restrict: "EA"
  scope: true
  template: """
    <div class='spiralNote--sidebar'>

    </div>
  """
  link: (scope, element, attrs)->
    _.each snView.getForType('sidebar'), (view)->
      childScope = scope.$new()
      element.append($compile(view)(childScope))
