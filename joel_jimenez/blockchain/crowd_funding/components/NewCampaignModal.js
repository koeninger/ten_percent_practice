import React, { Component } from'react';
import { Modal, ModalBackground, ModalContent, Notification, Delete } from 'bloomer';
import NewCampaign from './new';

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
			<div>
				<Modal isActive={this.state.isModalActive}>
					<ModalBackground />
					<ModalContent>
						<Notification>
							<Delete onClick={this.closeModal} />
							<NewCampaign />
						</Notification>
					</ModalContent>
				</Modal>
			</div>
		);
	}
};

export default NewCampaignModal;