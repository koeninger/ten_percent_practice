import React, { Component } from 'react';
import { Section, Title, Subtitle, Button } from 'bloomer';
import Layout from '../../../components/Layout';

class NewRequests extends Component {
	static async getInitialProps(props) {
		const address = props.query.address;

		return {address};
	}
	
	renderNewRequest() {
		return (
			<Section>
				<Title isSize={4}>New Request</Title>
				<Subtitle isSize={5}>New Request</Subtitle>
			</Section>
		);
	}

	render() {
		return (
			<Layout>{this.renderNewRequest()}</Layout>
		);
	}
}

export default NewRequests;