import { Meteor } from 'meteor/meteor';
import { Stocks } from '../collections/stocks';
var stockData = {};
var ts;
var hour;
var date;
var month;
var year;

Meteor.startup(() => {
  //if (Stocks.find().count() === 0) {
  Stocks.remove({});

  HTTP.get('https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=AMAT&interval=60min&apikey=B7KCRRWX0P2ONSWL', {}, function (error, response) {
    if ( error ) {
        console.log( error );
    } else {
        var response = response.data['Time Series (60min)'];

        _.forEach(response, function (dataPoint, timeStamp) {
            ts = new Date(timeStamp);
            hour = ts.getHours();
            date = ts.getDate();
            month = ts.getMonth();
            year = ts.getFullYear();
            stockData[timeStamp] = {
                open: dataPoint['1. open'],
                high: dataPoint['2. high'],
                low: dataPoint['3. low'],
                close: dataPoint['4. close'],
                hour: hour,
                date: date,
                month: month,
                year: year
            };
            Stocks.insert(stockData[timeStamp]);
        });
        // console.log(stockData);
        }
  });
});