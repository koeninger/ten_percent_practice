import React, { Component } from 'react';
import { Title, Section, Field, Columns, Column, Label, Control, Input, Button, Notification } from 'bloomer';
import Campaign from '../ethereum/campaign';
import web3 from '../ethereum/web3'
import { Router } from '../routes';

class NewRequestForm extends Component {
    static async getInitialProps() {
        const address = props.query.address;
        return { address };
    }
	state = {
		requestDescription: '',
        valueAmount: '',
        recipient: '',
		messageText: '',
		messageaColor: '',
		messageHidden: true,
        isCreating: false,
        hideMessage: true
	};

	onSubmit = async (event) => {
		this.setState({
			messageText: 'Creating Request . . .',
			messageColor: 'primary',
			isCreating: true,
            hideMessage: false
		});

		event.preventDefault();
		try{
            // Get values for new requests
            const { requestDescription, valueAmount, recipient } = this.state;
            console.log(requestDescription, valueAmount, recipient);

            // Get instance of campaign
            const campaign = Campaign(this.props.address);

			// Get accounts from web3
			const accounts = await web3.eth.getAccounts();

			// Create request
			await campaign.methods
				.createRequest(requestDescription, web3.utils.toWei(valueAmount, 'ether'), recipient)
				.send({
					from: accounts[0]
				});

			// New request was created successfully!
			this.setState({
				messageText: 'Request was created successfully!',
				messageColor: 'success',
				isCreating: false,
				requestDescription: '',
				valueAmount: '',
				recipient: '',
			});

			// Redirect back to requests page
			Router.replaceRoute(`/campaigns/${this.props.address}/requests/new`);
			// window.location.reload();

		} catch(error){
			console.log(error);
			this.setState({
				messageText: 'Error: Unable to create new request.',
				messageColor: 'danger',
				isCreating: false
			});
		}
	};

	render() {
		return (
			<Section>
				<Title isSize={4} hasTextAlign="centered">Create Payment Request</Title>
				<Columns isVCentered>
					<Column isSize='1/4'>
						<Label>Request Description:</Label>
					</Column>
					<Column>
						<Field>
							<Control isExpanded>
								<Input type="text" placeholder='Name or description of request' value={this.state.requestDescription} onChange={event => this.setState({ requestDescription: event.target.value})} />
							</Control>
						</Field>
					</Column>
				</Columns>
				<Columns isVCentered>
					<Column isSize='1/4'>
						<Label>Requested amount:</Label>
					</Column>
					<Column>
						<Field hasAddons>
							<Control isExpanded>
								<Input type="text" placeholder='The value amount of etheruem being requested' value={this.state.valueAmount} onChange={event => this.setState({ valueAmount: event.target.value})} />
							</Control>
							<Control>
								<Button isStatic>ether</Button>
							</Control>
						</Field>
					</Column>
				</Columns>
				<Columns isVCentered>
					<Column isSize='1/4'>
						<Label>Recipient:</Label>
					</Column>
					<Column>
						<Field hasAddons>
							<Control isExpanded>
								<Input type="text" placeholder='The address of the recipient for the request' value={this.state.recipient} onChange={event => this.setState({ recipient: event.target.value})} />
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
				<Notification isHidden={this.state.hideMessage} hasTextAlign="centered" isColor={this.state.messageColor}>{this.state.messageText}</Notification>
			</Section>
		);
	}
}

export default NewRequestForm;