do (angular)->

  angular.module 'authorsApp', [
    'authorsApp.controllers',
    'authorsApp.directives'
  ]

  angular.module('authorsApp').config(['$httpProvider', (@$httpProvider)->
    @metatag = document.querySelectorAll("meta[name=\"csrf-token\"]")[0]
    @authToken = if metatag then metatag.content else null
    $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = @authToken
    $httpProvider.defaults.headers['common']['Accept'] = 'application/json'
    $httpProvider.defaults.headers['common']['X-Requested-With'] = 'XMLHttpRequest'
    ])


  class FormController
    constructor: (@$scope, @$http)->
      $scope.submitForm = ->
        $http.post('/authors', author:{name:$scope.name, email:$scope.email})
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
