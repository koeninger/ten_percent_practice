import React, { Component } from'react';
import { Modal, ModalBackground, ModalContent, Notification, Delete } from 'bloomer';
import NewCampaign from './NewCampaign';

class NewCampaignModal extends Component {
	openModal = () => {
		this.setState({
			isModalActive: true
		});
	};

	closeModal = () => {
		this.setState({
			isModalActive: false
		});
	};

	state = {
		isModalActive: false
	};

	render(){
		return (
			<Modal isActive={this.state.isModalActive}>
				<ModalBackground />
				<ModalContent>
					<Notification>
						<Delete isSize="large" onClick={this.closeModal} />
						<NewCampaign />
					</Notification>
				</ModalContent>
			</Modal>
		);
	}
};

export default NewCampaignModal;