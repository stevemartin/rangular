do (angular)->

  class FormController
    constructor: (@$scope, @$http)->
      $scope.submitForm = ->
        $http.post('/authors', author:{name:$scope.name, email:$scope.email})
        return false

  class ArticlesController
    constructor: (@$scope)->
      $scope.articles = [{}]
      $scope.addArticle = ->
        $scope.articles.push( {} )
      $scope.removeArticle = (index)->
        $scope.articles.splice(index, 1)

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

  angular.module('authorsApp.controllers',[])
    .controller( 'FormController', ['$scope','$http', FormController] )
    .controller( 'ArticlesController', ['$scope', ArticlesController] )

  angular.module('authorsApp.directives', [])
    .directive('peSubmit', (@$compile)->
      return {
        link: (scope, element, attrs)->
          @html = '<a ng-click="submitForm()">Save</a>'
          @e = $compile(@html)(scope)
          element.replaceWith(@e)
      }
    )
