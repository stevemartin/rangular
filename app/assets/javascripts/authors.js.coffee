do (angular)->
  angular.module 'authorsApp', [
    'authorsApp.controllers',
    'authorsApp.directives'
  ]

  class FormController
    constructor: (@$scope, @$http)->
      $scope.submitForm = ->
        $http.post('/authors')
        return false

  angular.module('authorsApp.controllers',[])
    .controller 'FormController',['$scope','$http', FormController
    ]

