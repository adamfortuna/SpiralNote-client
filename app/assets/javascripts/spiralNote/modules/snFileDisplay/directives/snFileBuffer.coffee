angular.module("sn:fileDisplay").directive "snFileBuffer", (snSocket, $rootScope, $timeout)->
  replace: true
  restrict: "E"
  scope: {}
  template: """
    <div class="sn-fileBuffer">
      <textarea></textarea>
      <div class="bg-overlay"></div>
    </div>
  """
  link: (scope, element, attrs)->
    autoModeForPath = (path)->
      pathArr = path.split(".")
      extension = pathArr[pathArr.length - 1]
      
      mode = switch extension
               when "js" then "javascript"
               when "html" then "htmlmixed"
               when "coffee" then "coffeescript"
               when "sass" then "sass"
               when "scss" then "scss"
               when "less" then "less"
               when "css" then "css"
               when "rb" then "ruby"
               when "md" then "markdown"
               when "haml" then "haml"
               when "yml" then "yaml"
               when "xml" then "xml"
               when "sql" then "sql"
               when "bash" then "shell"
               when "py" then "python"
               when "php" then "php"
               when "erb"
                 switch pathArr[pathArr.length - 2]
                   when "html" then "htmlembedded"    
               else
                 "default"
      scope.textEditor.setOption("mode", mode)
    
    scope.textEditor = CodeMirror.fromTextArea element.find("textarea")[0],
      tabSize: 2
      lineNumbers: true
      autofocus: false
    
    $timeout ->
      scope.textEditor.refresh()
    
    $rootScope.$on "file:show", (evt, data)->
      scope.filePath = data.path
      
      autoModeForPath(scope.filePath)
      scope.textEditor.setValue(data.content)
    
    scope.save = ->
      snSocket.func "fsSaveFileBuffer", {path: scope.filePath, contents: scope.textEditor.getValue()}
      
    
