import angular from 'angular';
import angularMeteor from 'angular-meteor';
import { Stocks } from '../collections/stocks';

angular.module('financially', [
  angularMeteor
])
  .controller('StockDataCtrl', function ($scope) {
    'ngInject';

    $scope.helpers({
      stocks() {
        return Stocks.find({});
      }
    });
});