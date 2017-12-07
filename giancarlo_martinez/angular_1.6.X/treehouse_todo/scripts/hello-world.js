angular.module("todoListApp") // find the app's module
.directive('helloWorld', function() { // directive name, function
    return {
        template: "This is the hello world directive",
        restrict: "A" // restrict usage to attribute, E for element
    }
});

// Directive name is camelcase when defined, lowercase and hyphenated when invoked as html tag or attribute
// <hello-world></hello-world or <div hello-world></div>
