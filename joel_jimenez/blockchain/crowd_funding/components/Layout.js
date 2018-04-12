import React, { Component } from'react';
import Head from 'next/head';
import { Container } from 'bloomer';
import Header from './Header';
import Footer from './Footer';

class Layout extends Component {
	render(){
		return (
			<div>
				<Head>
					<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.6.2/css/bulma.min.css" />
				</Head>
				<Header />
				<Container>{this.props.children}</Container>
				<Footer />
			</div>
		);
	}
};

export default Layout;