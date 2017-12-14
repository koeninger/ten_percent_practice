import angular from 'angular';
import angularMeteor from 'angular-meteor';
import { Stocks } from '../collections/stocks';

angular.module('financially', [
    angularMeteor
  ])
  .component('stockData', {
    templateUrl: 'client/stockData.html',
    controllerAs: 'stockData',
    controller($scope, $reactive) {
        'ngInject';
 
        $reactive(this).attach($scope);
 
        this.helpers({
            stocks() {
                return Stocks.find({});
            }
        });
    }
});