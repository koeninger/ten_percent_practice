angular.module('app', [
    // array of dependencies
    ])
    .controller('MainCtrl', function (){
        var self = this;
        self.dogOptions = [
            "Poodle",
            "Shih-tzu",
            "Samoyed",
            "Maltese",
            "Havanese",
            "Basenji",
            "Irish Water Spaniel",
            "Yorkshire Terrier",
            "Bischon Frisee",
            "Scottish Terrier",
            "Labradoodle",
            "Schnauzer"
        ];
        self.dogSelections = [];

        self.selectionIndex = function(dog) {
            return self.dogSelections.indexOf(dog);
        };

        self.addDog = function(dog) {
            if(self.selectionIndex(dog) == -1){
                self.dogSelections.push(dog);
            }
        };

        self.removeDog = function(dog) {
            var index = self.selectionIndex(dog);
            if(index !== -1){
                self.dogSelections.splice(index, 1);
            }
        };
    });