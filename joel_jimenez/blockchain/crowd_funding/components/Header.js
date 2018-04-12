import React, { Component } from 'react';
import { Container, Hero, HeroBody, HeroFooter, Title, Tabs, Tab, TabList, TabLink } from 'bloomer';
import Menu from './Menu';

class Header extends Component {
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
			<Hero isColor='info'>
				<HeroBody>
					<Container>
						<Title>CrowdCoin</Title>
					</Container>
				</HeroBody>
				<HeroFooter>
					<Menu />
				</HeroFooter>
			</Hero>
		);
	}
}

export default Header;