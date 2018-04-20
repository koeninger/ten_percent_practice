import React, { Component } from 'react';
import { Section, Notification, Title, Subtitle, Button } from 'bloomer';
import Layout from '../../../components/Layout';
import { Link } from '../../../routes';

class Requests extends Component {
	static async getInitialProps(props) {
		const address = props.query.address;

		return {address};
	}
	
	renderRequests() {
		return (
			<Section>
				<Title isSize={4}>Payment Requests</Title>
				<Subtitle isSize={5}>Payment Requests</Subtitle>
				<Link route={`/campaigns/${this.props.address}/requests/new`}>
					<Button isColor='info'>New Request</Button>
				</Link>

			</Section>
		);
	}

	render() {
		return (
			<Layout>{this.renderRequests()}</Layout>
		);
	}
}

export default Requests;