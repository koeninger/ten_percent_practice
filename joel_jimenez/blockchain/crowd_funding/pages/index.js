import React, {Component} from 'react';
import factory from '../ethereum/factory';
import { Title, Subtitle, Section, Notification } from 'bloomer';
import Layout from '../components/Layout';
import { Link } from '../routes';

class CampaignIndex extends Component {
	static async getInitialProps() {
		// Get number of campaigns created in factory
		const campaignCount = await factory.methods.campaignCount().call();

		// Create array of size campaignCount. For each element, make a request to contract by index. Returns filled array
		const campaigns = await Promise.all(
			Array( parseInt(campaignCount) ).fill()
			.map( (element, index) => {
				return factory.methods.campaigns(index).call();
			})
		);

		return { campaigns };
	}

	renderCampaigns() {
		let campaigns;
		
		if (this.props.campaigns.length){
			campaigns = this.props.campaigns.map(campaign => {
				let campaignAddress = campaign[0];
				let description = campaign[1];
				let minimum = campaign[2];
				
				return (
					<Link route={`/campaigns/${campaignAddress}`}>
						<a>
							<Notification isColor="light" key={campaignAddress}>
								<Title isSize={5}>{description}</Title>
								<Subtitle>Minimum contribution: {minimum}</Subtitle>
							</Notification>
						</a>
					</Link>
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