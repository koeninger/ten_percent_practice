angular.module("todoListApp", [])
.controller('mainCtrl', function($scope){ // Attach main controller
    $scope.helloWorld = function() {
        console.log("Hello There! This is the helloWorld controller function in the mainCtrl")
    }
});