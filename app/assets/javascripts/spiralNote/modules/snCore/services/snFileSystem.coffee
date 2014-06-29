angular.module('sn:core').factory 'snFileSystem', (snSocket, $q)->
  class SnFileSystem
    copy: (srcPath, targetPath)->
      # TODO

    move: (srcPath, targetPath)->
      # TODO

    delete: (path)->
      # TODO

    mkdir: (path)->
      # TODO

    create: (path)->
      # TODO

    dirIndex: (path)->
      # TODO

    dirList: (path)->
      snSocket.func('fsGetDirectoryTree', path)

    read: (path)->
      deferred = $q.defer()
      snSocket.func('fsReadFile', path).then (fileData)->
        deferred.resolve(content: fileData.result, path: path)
      .catch (err)->
        deferred.reject(err)
      
      deferred.promise
    
    write: (path, content)->
      snSocket.func('fsSaveFileBuffer', {path: path, contents: content})
