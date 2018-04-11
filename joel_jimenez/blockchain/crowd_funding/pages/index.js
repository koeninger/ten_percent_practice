import React, {Component} from 'react';
import factory from '../ethereum/factory';
import Layout from '../components/Layout';
import { Title, Section, Card, CardContent, Button, Columns, Column, Field, Control, Input } from 'bloomer';

class CampaignIndex extends Component {
	static async getInitialProps() {
		const campaigns = await factory.methods.getCampaigns().call();
		return { campaigns };
	}

	renderCampaigns() {
		const campaigns = this.props.campaigns.map(address => {
			return (
				<Card key={address}>
					<CardContent>
						<Title isSize={5}>{address}</Title>
						<a>View campaign</a>
					</CardContent>
				</Card>
			);
		});

		return campaigns;
	}

	render() {
		return (
			<Layout>
				<Section style={{ paddingBottom: 0 }}>
					<Field hasAddons>
						<Control isExpanded>
							<Input type="text" placeholder="Search Campaigns" isSize="large" />
						</Control>
						<Control>
							<Button isColor="info" isSize="large">Search</Button>
						</Control>
					</Field>
				</Section>
				<Section style={{ paddingBottom: 0 }}>
					<Columns>
						<Column isSize={{tablet: 4}}>
							<Title isSize={3}>Campaigns</Title>
						</Column>
						<Column>
							<Button isColor="info">+ Create Campaign</Button>
						</Column>
					</Columns>
				</Section>
				<Section>{this.renderCampaigns()}</Section>
			</Layout>
		);
	}
}

export default CampaignIndex;