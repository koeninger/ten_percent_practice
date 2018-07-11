const express = require('express');
const cors = require('cors');
const expressGraphQL = require('express-graphql');
const schema = require('./schema')

const PORT = 4000;
const app = express();
app.use(cors());
app.use('/', expressGraphQL({
	schema,
	graphiql: false
}));

app.listen(PORT, () => {
	console.log("Listening on port " + PORT);
});