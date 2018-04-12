import React, { Component } from 'react';
import { Container, Tabs, Tab, TabList, TabLink } from 'bloomer';
import NewCampaignModal from './NewCampaignModal';

class Menu extends Component {
	componentDidMount() {
		try{
			if (document.location.pathname == '/'){
				this.setState({
					isTabActive: true
				});
			}
		} catch(error){
			console.log(error);
		}
	}

	state = {
		isTabActive: false
	};

	render() {
		return (
			<Tabs isBoxed isSize="large">
				<Container>
					<TabList>
						<Tab isActive={this.state.isTabActive}>
							<TabLink title="Created Campaigns" href="/">Campaigns</TabLink>
						</Tab>
						<Tab>
							<NewCampaignModal ref={instance => { this.child = instance; }} />
							<TabLink title="New Campaign" onClick={() => { this.child.openModal(); }}>&#10010;</TabLink>
						</Tab>
					</TabList>
				</Container>
			</Tabs>
		);
	}
}
export default Menu;