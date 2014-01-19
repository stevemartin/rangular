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

  angular.module('authorsApp.directives', [])
    .directive('peSubmit', (@$compile)->
      return {
        link: (scope, element, attrs)->
          @html = '<a ng-click="submitForm()">Save</a>'
          @e = $compile(@html)(scope)
          element.replaceWith(@e)
      }
    )
