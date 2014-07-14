angular.module('spiral').factory('WorkspaceManager', ['$location', 'WorkspaceService', 'WorkspaceObserver', function ($location, WorkspaceService, WorkspaceObserver) {

  function WorkspaceManager(workspace) {
    this.workspace = workspace;
    this.observer = new WorkspaceObserver(workspace);
  }

  // Save using WorkspaceService, and redirect to new URL if creating
  WorkspaceManager.prototype.save = function() {
    var id = this.workspace.id;
    WorkspaceService.save(this.workspace).then(function(ref) {
      // Redirect if this workspace was assigned a new ID after creation
      if(ref.name() !== id) {
        $location.path('/workspace/'+ref.name());
      }
    })
  };

  return WorkspaceManager;
}]);
