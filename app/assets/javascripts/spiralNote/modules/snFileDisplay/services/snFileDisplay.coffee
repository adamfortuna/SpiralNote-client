angular.module('sn:fileDisplay').factory 'snFileDisplay', (snApi)->
  activeFile = null
  
  saveActiveBuffer: ->
    path = activeFile.path
    fileName = activeFile.fileName

    snApi.file.write(activeFile.path, activeFile.editor.getValue()).then ->
      snApi.event.emit('fileDisplay:fileSaved', {path: path, fileName: fileName})
    
  setActiveFile: (path, fileName, editorDoc)->
    activeFile = {path: path, fileName: fileName, editor: editorDoc}
