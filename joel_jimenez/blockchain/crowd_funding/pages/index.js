import React, {Component} from 'react';
// import 'bulma/css/bulma.css';
import factory from '../ethereum/factory';

class CampaignIndex extends Component {
	static getInitialProps() {
		
	}

	async componentDidMount(){
		const campaigns = await factory.methods.getCampaigns().call();
		console.log(campaigns);
	}

	render() {
		return (
			<div>
				<h1>Campaigns</h1>
			</div>
		);
	}
}

export default CampaignIndex;