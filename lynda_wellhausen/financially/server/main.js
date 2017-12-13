import { Meteor } from 'meteor/meteor';
import { Stocks } from '../collections/stocks';

Meteor.startup(() => {
  //if (Stocks.find().count() === 0) {
    const stocks = [{
      'name': 'Dubstep-Free Zone',
      'high': 'Fast just got faster with Nexus S.',
      'low': '10'
    }, {
      'name': 'All dubstep all the time',
      'high': 'Fast just got faster with Nexus S.',
      'low': '9'

    }, {
      'name': 'Savage lounging',
      'high': 'Leisure suit required. And only fiercest manners.',
      'low': '8'

    }];

    stocks.forEach((stock) => {
        Stocks.insert(stock)
    });
  //}
});