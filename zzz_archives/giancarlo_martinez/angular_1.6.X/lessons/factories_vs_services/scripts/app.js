angular.module('app', []);
// Service
function loggingService() {
    // services have access to 'this' because they are constructor functions
    this.words = [
        {text: "Ello"},
        {text: "there"},
        {text: "Guv'nor"}
    ];

    // Services can be easily converted to ES6 classes
    // https://blog.thoughtram.io/angularjs/es6/2015/01/23/exploring-angular-1.3-using-es6.html
}

angular.module('app')
    .service('LoggingService', loggingService);

// Factory
function loggingFactory() {
    // instantiate an object
    var factory = {};
    factory.words = [
        {text: "Ello"},
        {text: "there"},
        {text: "Guv'nor"}
    ];

    return factory;
    // Or simply:
    // return {
    //     samples: [
    //         {text: "well"},
    //         {text: "ello"},
    //         {text: "there"},
    //         {text: "Guv'nor"}
    //     ]
    // };
}

angular.module('app')
    .factory('LoggingFactory', loggingFactory);


// set up controllers to interact with service / factory
angular.module('app')
    .controller('MainCtrl', function(LoggingFactory){
        var self = this;
        this.loggingFactory = LoggingFactory;
    });