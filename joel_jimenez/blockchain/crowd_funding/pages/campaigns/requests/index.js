import React, { Component } from 'react';
import { Section, Notification, Title, Subtitle, Button } from 'bloomer';
import Campaign from '../../../ethereum/campaign';
import Layout from '../../../components/Layout';
import { Link } from '../../../routes';

class Requests extends Component {
	static async getInitialProps(props) {
		const address = props.query.address;
		let requests = [];

		const campaign = Campaign(address);
		const description = await campaign.methods.campaignDescription().call();

		for(let i = 0; true; i++){
			try{
				let request = await campaign.methods.requests(i).call();
				console.log(request);
				requests.append(request);
			} catch(err){
				// console.log(err);
				break;
			}
		}

		return { address, description, requests };
	}
	
	renderRequests() {
		let requests = '';

		if(!this.props.requests.length){
			return <Title hasTextAlign="centered">No Requests found.</Title>;
		}
		for (let request in this.props.requests){
			console.log(request);
		}
		return (
			<Title isSize={4}>Payment Requests</Title>
		);
	}

	render() {
		return (
			<Layout>
				<Section>
					<Title isSize={4}>Payment Requests</Title>
					<Subtitle isSize={5}>
						<Link route={`/campaigns/${this.props.address}`}>{this.props.description}</Link>
					</Subtitle>
					<Section>{this.renderRequests()}</Section>
					<Link route={`/campaigns/${this.props.address}/requests/new`}>
						<Button isColor='info'>New Request</Button>
					</Link>
				</Section>
			</Layout>
		);
	}
}

export default Requests;