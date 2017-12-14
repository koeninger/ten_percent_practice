import angular from 'angular';
import angularMeteor from 'angular-meteor';
import { Stocks } from '../collections/stocks';
import * as d3 from 'd3';

angular.module('financially', [
    angularMeteor
  ])
  .component('stockData', {
    templateUrl: 'client/stockData.html',
    controllerAs: 'stockData',
    
    controller($scope, $reactive) {
        'ngInject';

        $reactive(this).attach($scope);

        $scope.symbolName = 'AMAT';

        $scope.test = function () {
            d3.selectAll("li").style("background-color", "pink");
        },

        $scope.test1 = function () {
            var today = Stocks.find({"date": "14"});
            console.log('today', today);
        },

        this.helpers({
            stocks() {
                return Stocks.find({});
            },

            test() {
                console.log('test helper');
            },
        });
    }
});