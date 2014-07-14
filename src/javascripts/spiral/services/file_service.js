angular.module('spiral').factory('FileService', ['$emit', '$on', '$rootScope', function ($emit, $on, $rootScope) {
  // Returns an array of files meeting the given condition
  // Condition in the form { property: 'active', value: true}
  function filesByCondition(files, condition) {
    if(!files || files.length == 0) { return []; }
    return _.reduce(files, function(result, file) {
      if(file[condition.property] === condition.value) {
        result.push(file);
      } else if(file.files) {
        var foundFiles = filesByCondition(file.files, condition);
        if(foundFiles.length > 0) {
          result = result.concat(foundFiles);
        }
      }
      return result;
    }, []);
  }

  var fileService = {
    syntax: function(file) {
      var pathArr = file.name.split("."),
          extension = pathArr[pathArr.length - 1];

      return (function() {
        switch (extension) {
          case "js":
            return "javascript";
          case "html":
            return "htmlmixed";
          case "css":
            return "css";
          default:
            return "default";
        }
      })();
    },
    // Close an open file
    close: function(file) {
      $emit('file:close', file.uid);
    },
    // Click
    activate: function(file) {
      $emit('file:activate', file.uid);
    },
    deactivate: function(file) {
      $emit('file:deactivate', file.uid);
    },
    setEditor: function(editor, file, preventDefault) {
      $emit('file:editor', { "uid": file.uid, "editor": editor });
    },
    expand: function(file) {
      $emit('file:expand', file.uid);
    },
    uid: function(files, uid) {
      var found = filesByCondition(files, { "property": "uid", "value": uid });
      return found ? found[0] : null;
    },
    // Filter for only open files
    openFiles: function(files) {
      return filesByCondition(files, { "property": "open", "value": true });
    },
    openFileNames: function(files) {
      return _.collect(this.openFiles(files), function(file) {
        return file.name;
      }).join(',');
    },
    activeFiles: function(files) {
      return filesByCondition(files, { "property": "active", "value": true });
    },
    activeFileNames: function(files) {
      return _.collect(this.activeFiles(files), function(file) {
        return file.name;
      }).join(',');
    },
  };

  return fileService;
}]);
