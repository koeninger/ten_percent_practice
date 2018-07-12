import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';
import ApolloClient from "apollo-boost";
import { ApolloProvider } from 'react-apollo';
import 'semantic-ui-css/semantic.min.css';
import './index.css';

const client = new ApolloClient({
	uri: "http://10.116.52.223:4000/"
});

ReactDOM.render(
    <ApolloProvider client={client}>
        <App />
    </ApolloProvider>, 
    document.getElementById('root')
);