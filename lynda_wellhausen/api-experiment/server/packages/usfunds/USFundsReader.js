
Meteor.publish('usFundsSearch', function(symbol) {
    var self = this;
    var fundData = {};

    HTTP.get('https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=AMAT&interval=60min&apikey=B7KCRRWX0P2ONSWL', {}, function (error, response) {
    if ( error ) {
        console.log( error );
    } else {
        //console.log(response.data['Time Series (60min)']);
        fundData = response.data['Time Series (60min)'];
    }
    });
});