
Meteor.publish('usFundsSearch', function(symbol) {
    var self = this;
    var fundData = {};
    var fundDataArray = [];
    var hourlyData = [];
    var i = 1;

    HTTP.get('https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=AMAT&interval=60min&apikey=B7KCRRWX0P2ONSWL', {}, function (error, response) {
    if ( error ) {
        console.log( error );
    } else {
        //console.log(response.data['Time Series (60min)']);
        fundData = response.data['Time Series (60min)'];
        //console.log('Fund Data: ', fundData);
        fundDataArray = _.values(fundData);
        //console.log('fundDataArray[0]', fundDataArray[1]);
        console.log('fundDataArray', fundDataArray.length);
        _.each(fundDataArray, function (data) {
            hourlyData[i] = {
                open: data['1. open'],
                close: data['4. close'],
                low: data['3. low'],
                high: data['2. high']
            }
            //console.log('i: ', i);
            //console.log('hourlyData[i]', hourlyData[i]);
            i++
        });
        //console.log(hourlyData);
        //console.log('i: ',i);
        }
    });
});