angular.module('app', [])
    .directive("welcome", function() {
        return {
            restrict: "E",
            // isolate scope. allows the directive to be used repeatedly with its own scope.
            scope: {},
            controller: function($scope) {
                $scope.words = [];

                this.sayHello = function() {
                    $scope.words.push("hello");
                };

                this.sayHowdy = function() {
                    $scope.words.push("howdy");
                };

                this.sayHi = function() {
                    $scope.words.push("hi");
                };
            },

            link: function(scope, element){
                element.bind("mouseenter", function() {
                    console.log(scope.words);
                });
            }
        }
    })

    .directive("hello", function() {
        return {
            require: "welcome",
            link: function (scope, element, attrs, welcomeCtrl) {
                welcomeCtrl.sayHowdy();
            }
        };
    })

    .directive("howdy", function() {
        return {
            require: "welcome",
            link: function (scope, element, attrs, welcomeCtrl) {
                welcomeCtrl.sayHowdy();
            }
        };
    })

    .directive("hi", function() {
        return {
            require: "welcome",
            link: function (scope, element, attrs, welcomeCtrl) {
                welcomeCtrl.sayHi();
            }
        };
    });
