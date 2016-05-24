angular.module('starter.services', [])

.factory('MainFeed', function($resource) {
  return $resource("http://localhost:3000/feeds.json");
});
