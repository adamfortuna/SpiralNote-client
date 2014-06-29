angular.module("sn:fileDisplay").directive "snFileDisplayBuffer", ($timeout, snApi)->
  replace: true
  restrict: "E"
  scope: true
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
    
    snApi.file.read(scope.file.path).then (fileData)->
      scope.textEditor.setValue(fileData.content)

    # snApi.event.on 'file:selected', (data)->
    #   scope.filePath = data.path
    #   autoModeForPath(scope.filePath)
    #   
    #   # Make api call to read the specified file. I'll need to figure out some sort
    #   # of client caching so we don't refetch and overwrite the browser content
    #   # until after a save or something.
    #   snApi.file.read(data.path).then (fileData)->
    #     scope.textEditor.setValue(fileData.content)
    
    # scope.save = ->
    #   snSocket.func "fsSaveFileBuffer", {path: scope.filePath, contents: scope.textEditor.getValue()}
      
    
