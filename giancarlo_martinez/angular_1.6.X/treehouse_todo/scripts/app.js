angular.module("todoListApp", [])
.controller('mainCtrl', function($scope){ // Attach main controller
    $scope.helloConsole = function() {
        console.log("Hello There!")
    };

    $scope.todos = [
        {"name": "Mow the lawn"},
        {"name": "Feed the bunnies"},
        {"name": "Do laundry"},
        {"name": "Take out the trash"}
    ]
});