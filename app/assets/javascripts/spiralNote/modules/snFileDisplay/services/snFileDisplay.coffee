angular.module('sn:fileDisplay').factory 'snFileDisplay', (snApi)->
  activeFile = null
  
  saveActiveBuffer: ->
    return unless activeFile

    snApi.file.write(activeFile.path, activeFile.editor.getValue()).then ->
      snApi.event.emit('fileDisplay:file:saved', {path: activeFile.path, fileName: activeFile.fileName})
    
  setActiveFile: (path, fileName, editorDoc)->
    activeFile = {path: path, fileName: fileName, editor: editorDoc}
