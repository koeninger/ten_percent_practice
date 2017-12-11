import { Meteor } from 'meteor/meteor';
import { Stocks } from '../collections/stocks';

Meteor.startup(() => {
  //if (Stocks.find().count() === 0) {
    const stocks = [{
      'name': 'Dubstep-Free Zone',
      'high': 'Fast just got faster with Nexus S.'
    }, {
      'name': 'All dubstep all the time',
      'high': 'Dance!'
    }, {
      'name': 'Savage lounging',
      'high': 'Leisure suit required. And only fiercest manners.'
    }];
  
    stocks.forEach((stock) => {
        Stocks.insert(stock)
    });
  //}
});