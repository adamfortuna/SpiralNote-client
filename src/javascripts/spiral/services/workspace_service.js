angular.module('spiral').factory('WorkspaceService', ['$q', '$firebase', 'FileScaffold', function ($q, $firebase, FileScaffold) {
  var ref = 'https://fortuna-spiral.firebaseio.com/workspaces/';
  var store, id;

  return {
    find: function(_id) {
      id = _id
      var workspaceRef = new Firebase(ref +id),
          deferred = $q.defer();
      store = $firebase(workspaceRef);
      store.$on('loaded', function(workspace) {
        if(workspace) {
          deferred.resolve(workspace);
        } else {
          deferred.reject('No workspace with id '+_id);
        }
      });
      return deferred.promise;
    },
    create: function(workspace) {
      var workspaceRef = new Firebase(ref),
          _store = $firebase(workspaceRef);
      return _store.$add(workspace);
    },
    update: function(workspace, _id) {
      if(_id !== id || !store) {
        store = new Firebase(ref+id);
      }

      return store.$set(workspace);
    },
    save: function(workspace, _id) {
      if(_id) {
        return this.update(workspace, _id);
      } else {
        return this.create(workspace);
      }
    },
    newSpace: function() {
      return {
        "name": "Example Workspace",
        "files": FileScaffold()
      }
    }
  };
}]);
