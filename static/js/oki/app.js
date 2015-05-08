'use strict';

/**
 * @ngdoc overview
 * @name okiApp
 * @description
 * # okiApp
 *
 * Main module of the application.
 */
angular
  .module('okiApp', [
    'ngRoute',
	'ngSanitize',
	'wu.masonry',
	'angularMoment'
  ])
  .constant('ENDPOINT_URI', '/api')
  .config(['$routeProvider', function($routeProvider){
    $routeProvider
      .when('/main', {
        templateUrl: '/static/views/main.html',
        controller: 'MainCtrl'
      })
      .otherwise({
        redirectTo: '/main'
      });
  }]);
