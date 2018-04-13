import React, {Component} from 'react';
import factory from '../ethereum/factory';
import { Title, Section, Box } from 'bloomer';
import Layout from '../components/Layout';

class CampaignIndex extends Component {
	static async getInitialProps() {
		const campaigns = await factory.methods.getCampaigns().call();
		return { campaigns };
	}

	renderCampaigns() {
		const campaigns = this.props.campaigns.map(address => {
			return (
				<Box key={address}>
					<Title isSize={5}>{address}</Title>
					<a>View campaign</a>
				</Box>
				
			);
		});

		return campaigns;
	}

	render() {
		return (
			<Layout>
				<Section>{this.renderCampaigns()}</Section>
			</Layout>
		);
	}
}

export default CampaignIndex;