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
        $scope.show = true;
        $scope.arrayData = function () {
            var i = 0;
            var hoursArray = [];
            var todaysData = Stocks.find({ date: 26 }).fetch();
            $scope.td = {
                hoursArray: [],
                opensArray: [],
                closeArray: []
            };

            _.forEach(todaysData, function () {
                $scope.td.hoursArray.push(todaysData[i].hour);
                $scope.td.opensArray.push(todaysData[i].open);
                $scope.td.closeArray.push(todaysData[i].close);
                i++;
            });
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

            $scope.styleChart = function () {
                d3.select(".chart")
                    .selectAll("div")
                    .data(data)
                    .enter().append("div")
                    .style("width", function (d) { return d * 10 + "px"; })
                    .text(function (d) { return d; });
            },

        this.helpers({
            todaysData() {
                // console.log('testing', Stocks.find({ date: 15 }).fetch());
                return Stocks.find({ date: 15 }).fetch();
            },

            arrayData() {
                var i = 0;
                var hoursArray = [];
                var todaysData = Stocks.find({ date: 26 }).fetch();
                $scope.td = {
                    hoursArray: [],
                    opensArray: [],
                    closeArray: []
                };

                _.forEach(todaysData, function () {
                    $scope.td.hoursArray.push(todaysData[i].hour);
                    $scope.td.opensArray.push(todaysData[i].open);
                    $scope.td.closeArray.push(todaysData[i].close);
                    i++;
                });

                return $scope.td;
            }
        });
    }
});