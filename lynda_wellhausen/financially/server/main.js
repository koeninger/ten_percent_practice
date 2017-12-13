import { Meteor } from 'meteor/meteor';
import { Stocks } from '../collections/stocks';
var stockData = {};

Meteor.startup(() => {
  //if (Stocks.find().count() === 0) {
  Stocks.remove({});

  HTTP.get('https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=AMAT&interval=60min&apikey=B7KCRRWX0P2ONSWL', {}, function (error, response) {
    if ( error ) {
        console.log( error );
    } else {
        var response = response.data['Time Series (60min)'];

        _.forEach(response, function (dataPoint, timeStamp) {
            stockData[timeStamp] = {
                open: dataPoint['1. open'],
                high: dataPoint['2. high'],
                low: dataPoint['3. low'],
                close: dataPoint['4. close'],
                timeStamp: timeStamp
            };
            Stocks.insert(stockData[timeStamp]);
        });
        // console.log(stockData);
        }
  });
});