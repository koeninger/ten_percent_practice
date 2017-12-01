
Funds = new Mongo.Collection('usfunds');

Session.setDefault('symbol', 'AMAT');

Tracker.autorun(function() {
    if (Session.get('symbol')) {
        var searchHandle = Meteor.subscribe('usFundsSearch', Session.get('symbol'));
        //Session.set('searching', ! searchHandle.ready());
    }
});

Template.body.events({
    'submit form': function(e, t) {
        e.preventDefault();

        var symbol = t.$('input[type=text]').val();

        if (symbol) {
            Session.set('symbol', symbol);
        }
    },
});

Template.body.helpers({
    posts: function () {
        console.log(Funds);
        return Funds.find();
    },
});