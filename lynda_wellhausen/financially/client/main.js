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
        $scope.show = false;
        $scope.hoursArray = function () {
            var hoursArray = [];
            var i = 0;
            todaysData = Stocks.find({ date: 15 }).fetch();
            _.forEach(todaysData, function() {
                //console.log('todaysData: ', todaysData);
                hoursArray.push(todaysData[i].hour);
                i++;
            });
            return hoursArray.reverse();
        },

        $scope.test = function () {
            d3.selectAll("li").style("background-color", "pink");
        },

        $scope.todaysData = function () {
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
                var hoursArray = [];
                var i = 0;
                todaysData = Stocks.find({ date: 15 }).fetch();
                _.forEach(todaysData, function() {
                    //console.log('todaysData: ', todaysData);
                    hoursArray.push(todaysData[i].hour);
                    i++;
                });
                hoursArray.reverse();
            },
        });
    }
});