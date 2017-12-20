import angular from 'angular';
import angularMeteor from 'angular-meteor';
import { Stocks } from '../collections/stocks';
import * as d3 from 'd3';
var td = {
    hoursArray: [],
    opensArray: [],
    closeArray: []
};

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
        $scope.show = false;
        $scope.todaysData = function () {
            var i = 0;
            var hoursArray = [];
            todaysData = Stocks.find({ date: 19 }).fetch();
            console.log('todaysData', todaysData);

            _.forEach(todaysData, function () {
                //console.log('todaysData: ', todaysData);
                td.hoursArray.push(todaysData[i].hour);
                td.opensArray.push(todaysData[i].open),
                td.closeArray.push(todaysData[i].close)
                i++;
            });
        },

        $scope.test = function () {
            d3.selectAll("li").style("background-color", "pink");
        },

        $scope.toggleTodaysData = function () {
            if (this.show == false) {
                this.show = true;
            } else
                this.show = false;
        },

        $scope.allData = function () {
            data = Stocks.find({});

        },

        this.helpers({
            test() {
                console.log('test helper');
            },
            todaysData() {
                return Stocks.find({ date: 15 }).fetch();
                console.log( Stocks.find({ date: 15 }).fetch());
            },
        });
    }
});