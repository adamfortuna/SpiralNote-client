angular.module('testApp').config ($stateProvider, $urlRouterProvider, $locationProvider) ->
  $locationProvider.html5Mode(true)

  $stateProvider
    .state 'root',
      url: '/'
      templateUrl: "assets/app/templates/index.html"
      # controller: (FSCSocket)->
      #   FSCSocket.establishConnection()
