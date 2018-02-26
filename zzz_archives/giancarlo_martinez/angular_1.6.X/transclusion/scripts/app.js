angular.module('app', [])
    .directive("welcome", function() {
        return {
            restrict: "E",
            scope: {},
            // set transclude to true to prevent the directive from overwriting child elements
            transclude: true,
            // insert the ng-transclude tag where you'd like the children inserted
            template: "<div>This is the welcome component</div><ng-transclude></ng-transclude>"
        }
    });