import angular from 'angular';
import angularMeteor from 'angular-meteor';
 
class stockData {
  constructor($scope, $reactive) {
    'ngInject';
 
    $reactive(this).attach($scope);
 
    this.helpers({
      stocks() {
        return Stocks.find({});
      }
    });
  }
}
 
const name = 'stockData';
 
// create a module
export default angular.module(name, [
  angularMeteor
]).component(name, {
  templateUrl: `imports/ui/components/${name}/${name}.html`,
  controllerAs: name,
  controller: StockData
});