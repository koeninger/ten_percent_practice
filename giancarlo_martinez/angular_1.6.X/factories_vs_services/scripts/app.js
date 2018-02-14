angular.module('app', []);
// Service
function loggingService() {
    this.logType = function logType() {
        return console.log("This is a service")
    };
}

angular.module('app')
    .service('LoggingService', loggingService);

// Factory
function loggingFactory() {
    return {
        samples: [
            {text: "well"},
            {text: "ello"},
            {text: "there"},
            {text: "Guv'nor"}
        ]
    };
}

angular.module('app')
    .factory('LoggingFactory', loggingFactory);


// set up controllers to interact with service / factory
angular.module('app')
    .controller('MainCtrl', function($scope){
        $scope.samples = [1,2,3,4,5];
    });