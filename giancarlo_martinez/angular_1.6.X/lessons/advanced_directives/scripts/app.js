angular.module('app', [])
    .directive("entering", function(){
        return function(scope, element, attrs) {
            element.bind("mouseenter", function(){
                element.children().removeClass(attrs.leaving).addClass(attrs.entering);
            })
        }
    })

    .directive("leaving", function(){
        return function(scope, element, attrs) {
            element.bind("mouseleave", function(){
                element.children().removeClass(attrs.entering).addClass(attrs.leaving);
            })
        }
    });