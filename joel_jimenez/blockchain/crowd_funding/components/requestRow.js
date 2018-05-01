import React, { Component } from 'react';
import { Button, Tag, Notification } from 'bloomer';
import web3 from '../ethereum/web3';
import Campaign from '../ethereum/campaign';
import { Router } from '../routes';

class RequestRow extends Component{
	async componentWillMount(props) {
		const { id, request, approversCount } = this.props;
		const requestValue = web3.utils.fromWei(request.requestValue, 'ether');

		const campaign = Campaign(this.props.address);
		const accounts = await web3.eth.getAccounts();
		const isAproved = await campaign.methods.isContributorApprover(id, accounts[0]).call();

		this.setState({
			approveButtonHidden: isAproved,
			approveMessageHidden: !isAproved,
			finalizeButtonHidden: request.complete,
			finalizeMessageHidden: !request.complete,
			isApproving: false,
			isFinalizing: false
		});
	}

	state = {
		isApproving: true,
		approveMessage: 'Approved',
		approveMessageColor: 'success',
		approveMessageHidden: true,
		approveButtonHidden: false,
		isFinalizing: true,
		finalizeMessage: 'Complete',
		finalizeMessageColor: 'dark',
		finalizeMessageHidden: true,
		finalizeButtonHidden: false
	};

	onApprove = async () => {
		this.setState({
			isApproving: true,
			approveMessage: 'Request is being approved...',
			approveMessageHidden: false,
			approveMessageColor: 'primary'
		});

		try{
			const campaign = Campaign(this.props.address);
	
			const accounts = await web3.eth.getAccounts();
			await campaign.methods.approveRequest(this.props.id).send({
				from: accounts[0]
			});
	
			this.setState({
				isApproving: false,
				approveMessage: 'Approved!',
				approveMessageColor: 'success',
				approveButtonHidden: true
			});

			// Router.replaceRoute('/');
			// window.location.reload();

		} catch(error){
			console.log(error);

			this.setState({
				isApproving: false,
				approveMessage: 'Unable to approve request.',
				approveMessageColor: 'danger'
			});
		}
	};

	onFinalize = async () => {
		this.setState({
			isFinalizing: true,
			finalizeMessage: 'Request is being finalized...',
			finalizeMessageHidden: false,
			finalizeMessageColor: 'primary'
		});

		try{
			const campaign = Campaign(this.props.address);
	
			const accounts = await web3.eth.getAccounts();
			await campaign.methods.finalizeRequest(this.props.id).send({
				from: accounts[0]
			});
	
			this.setState({
				isFinalizing: false,
				finalizeMessage: 'Finalized!',
				finalizeMessageColor: 'dark',
				finalizeButtonHidden: true
			});

			// Router.replaceRoute('/');
			// window.location.reload();

		} catch(error){
			console.log(error);

			this.setState({
				isFinalizing: false,
				finalizeMessage: 'Unable to finalize request.',
				finalizeMessageColor: 'danger'
			});
		}
	};

	render() {
		const { id, request, approversCount } = this.props;
		const requestValue = web3.utils.fromWei(request.requestValue, 'ether');

		return (
			<tr>
				<td>{id}</td>
				<td>{request.requestDescription}</td>
				<td>{requestValue}</td>
				<td>{request.recipient}</td>
				<td>{request.approvalCount}/{approversCount}</td>
				<td>
					<Button isHidden={this.state.approveButtonHidden} isColor='success' isOutlined isLoading={this.state.isApproving} onClick={this.onApprove} isSize="small">Approve</Button>
					<Tag isHidden={this.state.approveMessageHidden} isColor={this.state.approveMessageColor}>{this.state.approveMessage}</Tag>
				</td>
				<td>
					<Button isHidden={this.state.finalizeButtonHidden} isColor='dark' isOutlined isLoading={this.state.isFinalizing} onClick={this.onFinalize} isSize="small">Finalize</Button>
					<Tag isHidden={this.state.finalizeMessageHidden} isColor={this.state.finalizeMessageColor}>{this.state.finalizeMessage}</Tag>
				</td>
			</tr>
		);
	}
}

export default RequestRow;