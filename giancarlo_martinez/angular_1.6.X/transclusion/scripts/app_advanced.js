angular.module('app', [])
    .directive("welcome", function() {
        return {
            restrict: "AE",
            transclude: true,
            require: "setTransclusion",
            template: "<div>This is the welcome component</div>{{ childContent }}",
            link: function(scope, element, attrs, transclusionCtrl, transcludeFn) {
                var status = transclusionCtrl.tc;
                scope.$watch(
                    function( status ){
                        console.log("watched: ", transclusionCtrl.tc);
                    }
                )
            }
                // console.log(transclusionCtrl.tc);
                // if (transclusionCtrl.tc == true){
                //     scope.childContent = "Include Me instead";
                // }
                // else {
                //     scope.childContent = transcludeFn()[0].textContent;
                // }

        }
    })
    .directive("setTransclusion", function() {
        return {
            restrict: "A",
            controller: function ($scope) {
                $scope.tc = true;
                this.toggleTrans = function () {
                    $scope.tc = !$scope.tc;
                    console.log("toggling", $scope.tc)
                }
            }
        }
    })
    .directive("toggleButton", function() {
        return {
            restrict: "E",
            require: "setTransclusion",
            template: "<button>toggle transclusion</button>",
            link: function (scope, element, attrs, transclusionCtrl) {
                element.bind("click", function() {
                    transclusionCtrl.toggleTrans();
                });
            }
        }
    });

//
// angular.module('app', [])
//     .directive("welcome", function() {
//         return {
//             restrict: "E",
//             // isolate scope. allows the directive to be used repeatedly with its own scope.
//             scope: {},
//             controller: function($scope) {
//                 $scope.words = [];
//
//                 this.sayHello = function() {
//                     $scope.words.push("hello");
//                 };
//
//                 this.sayHowdy = function() {
//                     $scope.words.push("howdy");
//                 };
//
//                 this.sayHi = function() {
//                     $scope.words.push("hi");
//                 };
//             },
//
//             link: function(scope, element){
//                 element.bind("mouseenter", function() {
//                     console.log(scope.words);
//                 });
//             }
//         }
//     })
//
//     .directive("hello", function() {
//         return {
//             require: "welcome",
//             link: function (scope, element, attrs, welcomeCtrl) {
//                 welcomeCtrl.sayHowdy();
//             }
//         };
//     });


