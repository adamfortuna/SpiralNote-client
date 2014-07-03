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
    scope.saved = false
    firstLoadFinished = false
  
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
      
    scope.textEditor.on 'change', (cm, changeObj)->
      return if changeObj.origin == 'PLAY'

      snApi.event.emit 'fileDisplay:change', {path: scope.file.path, fileName: scope.file.fileName, changes: changeObj}
      if scope.saved && firstLoadFinished
        snApi.event.emit 'fileDisplay:file:dirty', {path: scope.file.path, fileName: scope.file.fileName}
        scope.saved = false
      else
        firstLoadFinished = true
        scope.saved = true
    
    playBackContent = (data)->
      console.log(data.changes)
      scope.textEditor.replaceRange(data.changes.text, data.changes.from, data.changes.to, "PLAY")
      scope.textEditor.refresh()
    
    if snApi.event.playing()
      scope.playing = true
      console.log('activate')
      snApi.event.on 'fileDisplay:change', playBackContent
      
    snApi.event.on 'fileDisplay:file:saved', (data)->
      if data.path == scope.file.path
        scope.saved = true

    unless snApi.event.playing()
      snApi.file.read(scope.file.path).then (fileData)->
        scope.textEditor.setValue(fileData.content)
