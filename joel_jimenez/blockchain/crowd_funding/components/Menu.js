import React, { Component } from 'react';
import { Container, Tabs, Tab, TabList, TabLink } from 'bloomer';
import { Link } from '../routes';

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
			<Tabs isBoxed isToggle isSize="medium">
				<Container>
					<TabList>
						<Tab isActive={this.state.isTabActive}>
							<Link route="/">
								<a title="Created Campaigns">Campaigns</a>
							</Link>
						</Tab>
						<Tab>
							<TabLink title="New Campaign" onClick={this.props.onClickNewCampaign}>&#10010;</TabLink>
						</Tab>
					</TabList>
				</Container>
			</Tabs>
		);
	}
}
export default Menu;