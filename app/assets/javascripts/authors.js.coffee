do (angular)->

  class FormController
    constructor: (@$scope, @$http, FormData)->
      $scope.data = FormData
      $scope.submitForm = ->
        $http.post('/authors', author:$scope.data)
        return false

  class ArticlesController
    constructor: (@$scope, FormData)->
      $scope.articles = FormData['articles']
      $scope.addArticle = ->
        $scope.articles.push( {} )
      $scope.removeArticle = (index)->
        $scope.articles.splice(index, 1)

  angular.module 'authorsApp', [
    'authorsApp.controllers',
    'authorsApp.services',
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
    .controller( 'FormController', ['$scope','$http', 'FormData', FormController] )
    .controller( 'ArticlesController', ['$scope', 'FormData', ArticlesController] )

  angular.module('authorsApp.directives', [])
    .directive('peSubmit', (@$compile)->
      return {
        link: (scope, element, attrs)->
          @html = '<a ng-click="submitForm()">Save</a>'
          @e = $compile(@html)(scope)
          element.replaceWith(@e)
      }
    ).directive('peAddArticle', (@$compile)->
      return {
        link: (scope, element, attrs)->
          @html = '<a ng-click="addArticle()">Add Article</a>'
          @e = $compile(@html)(scope)
          element.replaceWith(@e)
      }
    ).directive('peRemoveArticle', (@$compile)->
      return {
        scope: {
          eventHandler: '&ngClick'
        },
        link: (scope, element, attrs)->
          @html = '<a ng-click="eventHandler()">Remove Article</a>'
          @e = $compile(@html)(scope)
          element.replaceWith(@e)
      }
    )

  class FormData
    constructor: (data)->
      formData = data or {articles:[{}]}
      return formData

  angular.module('authorsApp.services', [])
    .factory('FormData', [FormData])
