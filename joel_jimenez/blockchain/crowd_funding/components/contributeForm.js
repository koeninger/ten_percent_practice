import React, { Component } from 'react';
import { Section, Title, Columns, Column, Field, Control, Label, Input, Button, Notification } from 'bloomer';
import Campaign from '../ethereum/campaign';
import web3 from '../ethereum/web3';
import { Router } from '../routes';

class ContributeForm extends Component {
	state = {
		contribution: '',
		messageColor: '',
		messageText: '',
		isCreating: false,
		messageHidden: true
	};

	onSubmit = async (event) => {
		this.setState({
			messageText: 'Contributing to campaign...',
			messageColor: 'primary',
			isCreating: true,
			messageHidden: false
		});

		event.preventDefault();
		try{
			const etherAmount = web3.utils.toWei(this.state.contribution, 'ether')
			const campaign = Campaign(this.props.address);

			// Get accounts from web3
			const accounts = await web3.eth.getAccounts();

			// Contribute to campaign
			await campaign.methods.contribute().send({
				from: accounts[0],
				value: etherAmount
			});

			// New campaign was created successfully!
			this.setState({
				messageText: 'Contribution was successfull!',
				messageColor: 'success',
				isCreating: false
			});

			// Redirect back to campaign page
			Router.replaceRoute(`/campaigns/${this.props.address}`);
			window.location.reload();

		} catch(error){
			console.log(error);
			this.setState({
				messageText: 'Error: Unable to contribute to campaign.',
				messageColor: 'danger',
				isCreating: false
			});
		}
	};

	render() {
		return (
			<Section>
				<Label>Amount to contribute</Label>
				<Field hasAddons>
					<Control isExpanded>
						<Input type="text" placeholder='Amount to contribute to the campaign' value={this.state.contribution} onChange={event => this.setState({ contribution: event.target.value})} />
					</Control>
					<Control>
						<Button isStatic>ether</Button>
					</Control>
				</Field>
				<Field>
					<Control>
						<Button isColor='info' isLoading={this.state.isCreating} onClick={this.onSubmit}>Contribute</Button>
					</Control>
				</Field>
				<Notification isColor={this.state.messageColor} hasTextAlign="centered" isHidden={this.state.messageHidden}>{this.state.messageText}</Notification>
			</Section>
		);
	};
}

export default ContributeForm;