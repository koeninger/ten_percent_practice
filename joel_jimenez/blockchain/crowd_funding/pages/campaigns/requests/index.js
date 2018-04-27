import React, { Component } from 'react';
import { Section, Title, Subtitle, Button, Table } from 'bloomer';
import { Link } from '../../../routes';
import Campaign from '../../../ethereum/campaign';
import Layout from '../../../components/Layout';
import RequestRow from '../../../components/requestRow';

class Requests extends Component {
	static async getInitialProps(props) {
		const { address } = props.query;
		const campaign = Campaign(address);
		const requestCount = await campaign.methods.getRequestsCount().call();
		const campaignDescription = await campaign.methods.campaignDescription().call();
		const approversCount = await campaign.methods.approversCount().call();

		// Create array of size requestCount. For each element, make a request to contract by index. Returns filled array
		const requests = await Promise.all(
			Array( parseInt(requestCount) ).fill()
			.map( (element, index) => {
				return campaign.methods.requests(index).call();
			})
		);

		return { address, campaignDescription, requests, approversCount };
	}
	
	renderRequests() {
		if(!this.props.requests.length){
			return <Title hasTextAlign="centered">No Requests found.</Title>;
		}

		// Create a row for a request in the table
		const requestRows = this.props.requests.map( (request, index) => {
			return <RequestRow
				id={index}
				key={index}
				request={request}
				address={this.props.address}
				approversCount={this.props.approversCount}
			/>;
		});

		return (
			<Table isBordered isStriped>
				<thead>
					<tr>
						<th>ID</th>
						<th>Request</th>
						<th>Amount (ether)</th>
						<th>Recipient</th>
						<th>Approval Count</th>
						<th>Approve</th>
						<th>Finalize</th>
					</tr>
				</thead>
				<tbody>{requestRows}</tbody>
			</Table>
		);
	}

	render() {
		return (
			<Layout>
				<Section>
					<Link  route={`/campaigns/${this.props.address}`}>
						<Button isColor='info' isPulled='right'>&larr; View Campaign</Button>
					</Link>
					<Title isSize={4}>Payment Requests</Title>
					<Subtitle isSize={5}>{this.props.campaignDescription}</Subtitle>
					{this.renderRequests()}
					<Link route={`/campaigns/${this.props.address}/requests/new`}>
						<Button isColor='info'>New Request</Button>
					</Link>
				</Section>
			</Layout>
		);
	}
}

export default Requests;