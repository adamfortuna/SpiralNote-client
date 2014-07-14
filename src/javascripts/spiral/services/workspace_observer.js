angular.module('spiral').factory('WorkspaceObserver', ['$rootScope', '$timeout', '$on', 'FileService', function ($rootScope, $timeout, $on, FileService) {

  // Recursively deactivate all files that aren't activeFile
  function deactivateFiles(files, activeFile) {
    _.each(FileService.activeFiles(files), function(file) {
      if(file.uid !== activeFile.uid) {
        deactivate(file);
      }
    });
  }
  function activate(file) {
    file.active = true;
  }
  function deactivate(file) {
    file.active = false;
  }
  function openFile(file) {
    file.open = true;
  }
  function closeFile(file) {
    file.open = false;
  }

  function done() {
    $timeout(function() {
      $rootScope.$apply();
    });
  }


  function WorkspaceObserver(workspace) {
    this.workspace = workspace;
    this.setupListeners();
  }

  WorkspaceObserver.prototype.stopListening = function() {
    _.each(this.listeners, function(listener) {
      listener();
    });
    this.listeners = [];
  }

  WorkspaceObserver.prototype.setupListeners = function() {
    this.listeners = [];

    this.listeners.push($on('file:activate', function(event, uid) {
      var file = FileService.uid(this.workspace.files, uid);
      openFile(file);
      activate(file);
      deactivateFiles(this.workspace.files, file);

      done();
    }.bind(this)));

    this.listeners.push($on('file:expand', function(event, uid) {
      var file = FileService.uid(this.workspace.files, uid);
      file.expanded = !file.expanded;
      done();
    }.bind(this)));

    this.listeners.push($on('file:editor', function(event, options) {
      var file = FileService.uid(this.workspace.files, options.uid);
      // Start the editor out with the files contents
      options.editor.setValue(file.contents);

      // Keep the file and the editor in sync
      options.editor.on('change', function(doc) {
        file.contents = doc.getValue();
      });
      done();
    }.bind(this)));

    this.listeners.push($on('file:deactivate', function(event, uid) {
      var file = FileService.uid(this.workspace.files, uid);
      deactivate(file);
      done();
    }.bind(this)));

    this.listeners.push($on('file:close', function(event, uid) {
      var file = FileService.uid(this.workspace.files, uid);
      closeFile(file);
      deactivate(file);

      // If an active file is closed, set the next file as active
      // Close it from the active
      var openFiles = FileService.openFiles(this.workspace.files);
      if(openFiles.length > 0 && FileService.activeFiles(this.workspace.files).length === 0) {
        activate(openFiles[openFiles.length-1]);
      }
      done();
    }.bind(this)));

    this.listeners.push($on('workspace:files:set', function(event, files) {
      this.workspace.files = files;
      this.stopListening();
      this.setupListeners();
      done();
    }.bind(this)));
  };

  return WorkspaceObserver;
}]);

