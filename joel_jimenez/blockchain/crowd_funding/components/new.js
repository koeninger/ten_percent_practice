import React, { Component } from 'react';
import { Title, Section, Field, FieldLabel, FieldBody, Label, Control, Input, Button, Notification } from 'bloomer';
import factory from '../ethereum/factory';
import web3 from '../ethereum/web3'

class CampaignNew extends Component {
	state = {
		minimumContribution: '',
		messageText: '',
		messageColor: '',
		messageHidden: true,
		isCreating: false
	};

	onSubmit = async (event) => {
		this.setState({
			messageText: '',
			messageColor: '',
			messageHidden: true,
			isCreating: true
		});

		event.preventDefault();
		try{
			const accounts = await web3.eth.getAccounts();

			await factory.methods
				.createCampaign(this.state.minimumContribution)
				.send({
					from: accounts[0]
				});

			this.setState({
				messageText: 'Campaign was created successfully!',
				messageColor: 'success',
				messageHidden: false,
				isCreating: false
			});

		} catch(error){
			console.log(error);
			this.setState({
				messageText: 'Error: Unable to create new campaign.',
				messageColor: 'danger',
				messageHidden: false,
				isCreating: false
			});
		}
	};

	render() {
		return (
			<Section>
				<Title isSize={4}>Create a New Campaign</Title>
				<Field isHorizontal>
					<FieldLabel isNormal>
						<Label>Contribution:</Label>
					</FieldLabel>
					<FieldBody>
						<Field hasAddons>
							<Control isExpanded>
								<Input type="text" placeholder='Minimum Contribution that will be required by users' value={this.state.minimumContribution} onChange={event => this.setState({ minimumContribution: event.target.value})} />
							</Control>
							<Control>
								<Button isStatic>wei</Button>
							</Control>
						</Field>
					</FieldBody>
				</Field>
				<Field isHorizontal>
					<FieldLabel />
					<FieldBody>
						<Field>
							<Control>
								<Button isColor='info' isLoading={this.state.isCreating} onClick={this.onSubmit}>Submit</Button>
							</Control>
						</Field>
					</FieldBody>
				</Field>
				<Notification isColor={this.state.messageColor} isHidden={this.state.messageHidden}>
					<span>{this.state.messageText}</span>
				</Notification>
			</Section>
		);
	}
}

export default CampaignNew;