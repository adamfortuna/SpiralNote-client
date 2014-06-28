angular.module('fsc').directive 'fscEditorLeftPane', (FSCView, $compile)->
  replace: true
  restrict: "EA"
  scope: true
  template: """
    <div class='fsc-editor--leftPane'>

    </div>
  """
  link: (scope, element, attrs)->
    _.each FSCView.leftViews(), (view)->
      childScope = scope.$new()
      element.append($compile(view)(childScope))
