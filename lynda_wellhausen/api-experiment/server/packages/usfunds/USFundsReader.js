
Meteor.publish('usFundsSearch', function(symbol) {
    var self = this;
    var symbol = {};
    var hourlyData = [];
    var symbolData = {};

    HTTP.get('https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=AMAT&interval=60min&apikey=B7KCRRWX0P2ONSWL', {}, function (error, response) {
    if ( error ) {
        console.log( error );
    } else {
        symbol = response.data['Time Series (60min)'];

        _.forEach(symbol, function (data, timeStamp) {
            var stockData = symbol[timeStamp];

            symbolData[timeStamp] = {
                open: stockData['1. open'],
                high: stockData['2. high'],
                low: stockData['3. low'],
                close: stockData['4. close']
            };
        });

        //console.log('symbolData', symbolData);

        }
    });
});