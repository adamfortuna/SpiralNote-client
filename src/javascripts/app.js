angular.module('app', ['ngRoute', 'firebase', 'spiral']);

// Router
angular.module('app').config(['$locationProvider', '$routeProvider', function($locationProvider, $routeProvider) {
  $locationProvider.html5Mode(false);
  $routeProvider.when('/', {
      templateUrl: 'templates/app/index.html',
      controller: 'WorkspaceController'
    }).when('/workspace/:id', {
      templateUrl: 'templates/app/index.html',
      controller: 'WorkspaceController'
    });
}]);
