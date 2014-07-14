// Plays a recording
angular.module('spiral:recorder').factory('SpiralPlayer', ['$rootScope', '$emit', '$on', function($rootScope, $emit, $on) {

  function Player(recording) {
    this.recording = recording;
    this.changes = this.recording.changes;
    this.isPlaying = false;
    this.isPaused = false;
    this._currentStep = 0;
  }

  Player.prototype.play = function(callback) {
    $emit('workspace:files:set', _.cloneDeep(this.recording.initialFiles));
    this.isPlaying = true;
    this.isPaused = false;
    this._callback = callback;
    this._startWatch();
    this._playStep(0);
  }

  Player.prototype.pause = function() {
    this._donePlaying(); // Remove all listeners
    this.isPaused = true;
  }

  Player.prototype.resume = function() {
    this.isPaused = false;
    this._startWatch();
    this._playStep(this.currentStep);
  }

  Player.prototype._playStep = function(step) {
    if(step >= this.changes.length) {
      return this._donePlaying();
    }
    var change = this.changes[step],
        previousTime = (step > 0) ? this.changes[step-1].time : 0,
        timeUntilNextStep = change.time - previousTime;

    // Set a timeout on when to apply the next event
    setTimeout(function() {
      console.log('Playing step ' + change.event);
      $emit(change.event, change.payload);
      //if(!$rootScope.$$phase) { $rootScope.$apply(); }

      this.currentStep = step;
      this._playStep(step+1);
    }.bind(this), timeUntilNextStep);
  };

  Player.prototype._startWatch = function() {
    this._listeners = [];
    this._listeners.push($on('file:editor', function(event, options) {
      // Cache the editor for later use
      // Save the listener to remove it after
      this._editor = {
        listener: $on('file:changed', this._playChange.bind(this)),
        editor: options.editor
      };
    }.bind(this)));
  }

  Player.prototype._donePlaying = function() {
    this.isPlaying = false;
    _.each(this._listeners, function(listener) {
      listener();
    });
    this._listeners = [];
    this._callback(this);
  }

  Player.prototype._playChange = function(event, payload) {
    var data = payload.change;
    this._editor.editor.replaceRange(data.text, data.from, data.to, "PLAY")
    this._editor.editor.refresh();
  }

  return Player;

}]);
