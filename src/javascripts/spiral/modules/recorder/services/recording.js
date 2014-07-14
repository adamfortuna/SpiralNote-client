// ex: new Recording(workspace)
angular.module('spiral:recorder').factory('SpiralRecording', ['$on', 'FileService', function($on, FileService) {

  function Recording(workspace) {
    this.workspace = workspace;
    this.isRecording = false;
    this.initialFiles = [];
    this.changes = [];
    this.startingTime = null;
    this.watchers = [];
    this.editor = null;
    this.file = null;
  }

  Recording.prototype.record = function() {
    console.log('SpiralRecording Start');
    this.isRecording = true;
    this.initialFiles = _.cloneDeep(this.workspace.files);
    this.startingTime = new Date();
    this._watchEvents();
  }

  Recording.prototype.stop = function() {
    this.isRecording = false;
    console.log('SpiralRecording Stop');
    console.log(this.changes);
    this._stopWatchingEvents();
  }

  // Start watching for all events to capture changes
  Recording.prototype._watchEvents = function() {
    var events = ['file:close', 'file:expand', 'file:activate', 'file:open', 'file:deactivate'];
    this.watchers = _.collect(events, function(event) {
      return $on(event, function(event, payload) {
        this.changes.push({
          time: (new Date() - this.startingTime),
          event: event.name,
          payload: payload
        });
      }.bind(this));
    }.bind(this));

    this.watchers.push($on('file:editor', function(event, payload) {
      if(this.editor) { this.editor.off(this._logChange); }
      this.editor = payload.editor;
      this.file = FileService.uid(this.workspace.files, payload.uid);

      this.editor.on('change', function(editor, change) {
        this.changes.push({
          time: (new Date() - this.startingTime),
          event: 'file:changed',
          payload: { "uid": this.file.uid, "change": change }
        });
      }.bind(this));

    }.bind(this)));
  };

  // Unregister all watchers
  Recording.prototype._stopWatchingEvents = function() {
    for(var watcher in this.watchers) {
      this.watchers[watcher]();
    }
  };

  return Recording;
}]);
