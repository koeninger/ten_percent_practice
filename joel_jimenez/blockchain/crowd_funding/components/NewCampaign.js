import React, { Component } from 'react';
import { Title, Section, Field, Columns, Column, Label, Control, Input, Button, Notification } from 'bloomer';
import factory from '../ethereum/factory';
import web3 from '../ethereum/web3'
import { Router } from '../routes';

class NewCampaign extends Component {
	state = {
		campaignDescription: '',
		minimumContribution: '',
		messageText: '',
		messageColor: '',
		messageHidden: true,
		isCreating: false
	};

	onSubmit = async (event) => {
		this.setState({
			messageText: 'Creating Campaign . . .',
			messageColor: 'primary',
			isCreating: true,
			messageHidden: false
		});

		event.preventDefault();
		try{
			// Get accounts from web3
			const accounts = await web3.eth.getAccounts();

			// Create campaign
			await factory.methods
				.createCampaign(this.state.minimumContribution, this.state.campaignDescription)
				.send({
					from: accounts[0]
				});

			// New campaign was created successfully!
			this.setState({
				messageText: 'Campaign was created successfully!',
				messageColor: 'success'
			});

			// Redirect back to campaign page
			Router.replaceRoute('/');
			window.location.reload();
			this.setState({
				isCreating: false,
				messageHidden: true
			});

		} catch(error){
			console.log(error);
			this.setState({
				messageText: 'Error: Unable to create new campaign.',
				messageColor: 'danger',
				isCreating: false
			});
		}
	};

	render() {
		return (
			<Section>
				<Title isSize={4} hasTextAlign="centered">Create a New Campaign</Title>
				<Columns isVCentered>
					<Column isSize='1/4'>
						<Label>Campaign Description:</Label>
					</Column>
					<Column>
						<Field>
							<Control isExpanded>
								<Input type="text" placeholder='Name or description of campaign' value={this.state.campaignDescription} onChange={event => this.setState({ campaignDescription: event.target.value})} />
							</Control>
						</Field>
					</Column>
				</Columns>
				<Columns isVCentered>
					<Column isSize='1/4'>
						<Label>Minimum Contribution:</Label>
					</Column>
					<Column>
						<Field hasAddons>
							<Control isExpanded>
								<Input type="text" placeholder='Minimum Contribution that will be required by users' value={this.state.minimumContribution} onChange={event => this.setState({ minimumContribution: event.target.value})} />
							</Control>
							<Control>
								<Button isStatic>wei</Button>
							</Control>
						</Field>
					</Column>
				</Columns>
				<Columns>
					<Column isSize='1/4' style={{ padding: 0 }} />
					<Column>
						<Field>
							<Control>
								<Button isColor='info' isLoading={this.state.isCreating} onClick={this.onSubmit}>Create</Button>
							</Control>
						</Field>
					</Column>
				</Columns>
				<Notification isColor={this.state.messageColor} isHidden={this.state.messageHidden} hasTextAlign="centered">{this.state.messageText}</Notification>
			</Section>
		);
	}
}

export default NewCampaign;