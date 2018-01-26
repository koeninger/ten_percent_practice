// set up ========================
var express = require('express');
var app = express();
var mongoose = require('mongoose');
var bodyParser = require('body-parser');

var Attraction = require('./models/Attraction');

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.set('port', (process.env.PORT || 3001));

mongoose.connect('mongodb://localhost/wdw-navigator');

// Express only serves static assets in production
if (process.env.NODE_ENV === 'production') {
  app.use(express.static('client/build'));
}

var router = express.Router();
router.get('/attractions', function(req, res) {
  Attraction.find(function(err, attractions) {
    res.json(attractions);  
  });
  
});

router.get('/generate', function(req, res) {
  res.json({
    ok: true

  });  
  
});


app.use('/api', router);

app.listen(app.get('port'), function() {
  console.log("Find the server at: http://localhost:${app.get('port')}/"); // eslint-disable-line no-console
});