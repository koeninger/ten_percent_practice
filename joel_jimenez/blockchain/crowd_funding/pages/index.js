import React, {Component} from 'react';
import factory from '../ethereum/factory';
import { Title, Subtitle, Section, Notification } from 'bloomer';
import Layout from '../components/Layout';
import { Link } from '../routes';

class CampaignIndex extends Component {
	static async getInitialProps() {
		let campaigns = [];

		for (let i = 0; true; i++){
			try{
				let newCampaign = await factory.methods.campaigns(i).call();
				campaigns.push(newCampaign);

			} catch(err){
				// console.log(err);
				break;
			}
		}

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
					<Notification isColor="light" key={campaignAddress}>
						<Title isSize={5}>{description}</Title>
						<Subtitle>Minimum contribution: {minimum}</Subtitle>
						<Link route={`/campaigns/${campaignAddress}`}>
							<a>View campaign</a>
						</Link>
					</Notification>
					
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