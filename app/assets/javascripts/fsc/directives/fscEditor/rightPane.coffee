angular.module('fsc').directive 'fscEditorRightPane', (FSCView, $compile)->
  replace: true
  restrict: "EA"
  scope: true
  template: """
    <div class='fsc-editor--rightPane'>

    </div>
  """
  link: (scope, element, attrs)->
    _.each FSCView.rightViews(), (view)->
      childScope = scope.$new()
      element.append($compile(view)(childScope))
