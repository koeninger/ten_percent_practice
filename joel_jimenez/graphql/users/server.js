const express = require('express');
const expressGraphQL = require('express-graphql');
const schema = require('./schema/schema')

const PORT = 4000;
const app = express();
app.use('/graphql', expressGraphQL({
	graphiql: true,
	schema
}));

app.listen(PORT, () => {
	console.log("Listening on port " + PORT);
});