angular.module('starter.controllers', [])

.controller('DashCtrl', function($scope, MainFeed) {
  MainFeed.query().$promise.then(function(response){
    $scope.feed_entries = response;
  });
})

.controller('TrendingCtrl', function($scope) {
})

.controller('SavedCtrl', function($scope) {
})

.controller('AccountCtrl', function($scope) {
  $scope.settings = {
    enableFriends: true
  };
});
