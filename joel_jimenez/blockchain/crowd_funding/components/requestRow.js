import React, { Component } from 'react';
import { Button } from 'bloomer';
import web3 from '../ethereum/web3';

class RequestRow extends Component{
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
					<Button isColor='success'>Aprrove</Button>
				</td>
				<td>
					<Button isColor='warning'>Finalize</Button>
				</td>
			</tr>
		);
	}
}

export default RequestRow;