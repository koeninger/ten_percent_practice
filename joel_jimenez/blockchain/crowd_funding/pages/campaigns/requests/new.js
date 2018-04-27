import React, { Component } from 'react';
import { Link } from '../../../routes';
import { Section, Button } from 'bloomer';
import Layout from '../../../components/Layout';
import NewRequestForm from '../../../components/newRequest';

class NewRequest extends Component {
	static async getInitialProps(props) {
		const address = props.query.address;

		return {address};
	}

	render() {
		return (
			<Layout>
				<Section>
					<Link route={`/campaigns/${this.props.address}/requests`}>
						<Button isColor="info" isPulled='right'>&larr; View Requests</Button>
					</Link>
					<NewRequestForm address={this.props.address} />
				</Section>
			</Layout>
		);
	}
}

export default NewRequest;