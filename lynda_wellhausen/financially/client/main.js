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
            var opensData = $scope.td.opensArray;
            var hoursData = $scope.td.hoursArray;
            var x = d3.scaleLinear()
                .domain([d3.max(opensData), 50])
                .range([50, 0]);

            var svgContainer = d3.select(".opens-container")
                                .append("svg")
                                .attr("width", 400)
                                .attr("height", 100);

            var y_scale = d3.scaleLinear()
                            .domain([d3.min(0), d3.max(24)])
                            .range([20 / 2, 0]);

            var y_axis = d3.axisLeft()
                            .scale(y_scale);

    

                d3.select(".opens-data")
                .selectAll("div")
                .data(opensData)
                    .enter().append("div")
                    .style("width", function(d) { return x(d) * 10 + "px"; })
                    .text(function (d) { return d; })
                },

        this.helpers({
            todaysData() {
                // console.log('testing', Stocks.find({ date: 15 }).fetch());
                return Stocks.find({ date: 5 }).fetch();
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