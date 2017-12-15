
Meteor.publish('usFundsSearch', function(symbol) {
    var self = this;
    var stockData = {};

    HTTP.get('https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=AMAT&interval=60min&apikey=B7KCRRWX0P2ONSWL', {}, function (error, response) {
    if ( error ) {
        console.log( error );
    } else {
        var response = response.data['Time Series (60min)'];

        _.forEach(response, function (dataPoints, timeStamp) {
            var data = response[timeStamp];

            stockData = {
                open: data['1. open'],
                high: data['2. high'],
                low: data['3. low'],
                close: data['4. close'],
                timeStamp: timeStamp
            };
        });
        self.ready();
        }
    });
});