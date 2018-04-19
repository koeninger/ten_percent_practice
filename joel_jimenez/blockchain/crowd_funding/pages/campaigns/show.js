import React, { Component } from 'react';
import { Section, Tile, Box, Title, Subtitle, Button } from 'bloomer';
import web3 from '../../ethereum/web3';
import Layout from '../../components/Layout';
import Campaign from '../../ethereum/campaign';
import ContributeForm from '../../components/contributeForm'

class ShowCampaign extends Component {
	static async getInitialProps(props) {
		const address = props.query.address;

		try{
			const campaign = Campaign(address);
			const summary = await campaign.methods.getSummary().call();

			return {
				address: address,
				description: summary[0],
				minimumContribution: summary[1],
				balance: summary[2],
				requestsCount: summary[3],
				approversCount: summary[4],
				manager: summary[5]
			};

		} catch(err){
			console.log(err);
			return {};
		}
	}

	renderSummary() {
		if(!this.props.manager){
			return <Title hasTextAlign="centered">Campaign not found.</Title>;
		}

		return (
			<Tile isAncestor>
				<Tile isVertical isSize={8}>
					<Tile isParent>
						<Tile isChild>
							<Title hasTextAlign="centered" isSize={3}>{this.props.description}</Title>
						</Tile>
					</Tile>
					<Tile isParent>
						<Tile isChild>
							<Box>
								<Title isSize={5}>{this.props.manager}</Title>
								<Subtitle isSize={5}>Campaign Manger</Subtitle>
								<Subtitle isSize={6}>The creator of the campaign and manger of payment requests.</Subtitle>
							</Box>
						</Tile>
					</Tile>
					<Tile>
						<Tile isParent isVertical>
							<Tile isChild>
								<Box>
									<Title isSize={4}>{this.props.minimumContribution}</Title>
									<Subtitle isSize={5}>Minimum Contribution (wei)</Subtitle>
									<Subtitle isSize={6}>The minimum amount of wei required to contribute to campaign.</Subtitle>
								</Box>
							</Tile>
							<Tile isChild>
								<Box>
									<Title isSize={4}>{web3.utils.fromWei(this.props.balance, 'ether')}</Title>
									<Subtitle isSize={5}>Total Balance (ether)</Subtitle>
									<Subtitle isSize={6}>The total amount of wei currently contributed to campaign.</Subtitle>
								</Box>
							</Tile>
						</Tile>
						<Tile isParent isVertical>
							<Tile isChild>
								<Box>
									<Title isSize={4}>{this.props.requestsCount}</Title>
									<Subtitle isSize={5}>Requests</Subtitle>
									<Subtitle isSize={6}>The current number of payment requests in the campaign.</Subtitle>
								</Box>
							</Tile>
							<Tile isChild>
								<Box>
									<Title isSize={4}>{this.props.approversCount}</Title>
									<Subtitle isSize={5}>Contributors</Subtitle>
									<Subtitle isSize={6}>The number of contributors that can aprove requests in this campaign.</Subtitle>
								</Box>
							</Tile>
						</Tile>
					</Tile>
					<Tile isParent>
						<Tile isChild hasTextAlign="centered">
							<Button isColor='info'>View Requests</Button>
						</Tile>
					</Tile>
				</Tile>
				<Tile isSize={4}>
					<ContributeForm address={this.props.address} />
				</Tile>
			</Tile>
		);
	}

	render() {
		return (
			<Layout>
				<Section>{this.renderSummary()}</Section>
			</Layout>
		);
	}
}

export default ShowCampaign;