var mongoose = require('mongoose');
var Schema = mongoose.Schema;
mongoose.connect('mongodb://localhost/wdw-navigator');

// create a schema
var attractionSchema = new Schema({
    name: String,
    image: String,
    description: String,
    created_at: Date,
    updated_at: Date
});

// on every save, add the date
attractionSchema.pre('save', function(next) {
  // get the current date
  var currentDate = new Date();

  // change the updated_at field to current date
  this.updated_at = currentDate;

  // if created_at doesn't exist, add to that field
  if (!this.created_at)
    this.created_at = currentDate;

  next();
});
// the schema is useless so far
// we need to create a model using it
var Attraction = mongoose.model('Attraction', attractionSchema);

// make this available to our Attractions in our Node applications
module.exports = Attraction;