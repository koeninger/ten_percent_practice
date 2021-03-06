const { createServer } = require('http');
const next = require('next');

const app = next({
	dev: process.env.NODE_ENV !== 'production'
});

const routes = require('./routes');
const handler = routes.getRequestHandler(app);

const PORT = 8088;
app.prepare().then( () => {
	createServer(handler).listen(PORT, err => {
		if(err) throw err;
		console.log('Ready on port ' + PORT);
	});
});