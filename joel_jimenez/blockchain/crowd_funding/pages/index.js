import React, {Component} from 'react';
import factory from '../ethereum/factory';
import { Title, Section, Box } from 'bloomer';
import Layout from '../components/Layout';
import { Link } from '../routes';

class CampaignIndex extends Component {
	static async getInitialProps() {
		const campaigns = await factory.methods.getCampaigns().call();
		return { campaigns };
	}

	renderCampaigns() {
		let campaigns;
		
		if (this.props.campaigns.length){
			campaigns = this.props.campaigns.map(address => {
				return (
					<Box key={address}>
						<Title isSize={5}>{address}</Title>
						<Link route={`/campaigns/${address}`}>
							<a>View campaign</a>
						</Link>
					</Box>
					
				);
			});
		} else{
			campaigns = (
				<Title hasTextAlign="centered">No Campaigns found!</Title>
			);
		}

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