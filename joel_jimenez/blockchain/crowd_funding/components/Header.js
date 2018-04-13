import React, { Component } from 'react';
import { Container, Hero, HeroBody, HeroFooter, Title, Subtitle, Tabs, Tab, TabList, TabLink } from 'bloomer';
import Menu from './Menu';

export default props => {
	return (
		<Hero isColor='primary' isSize='large'>
			<HeroBody>
				<Container>
					<Title>CrowdCoin</Title>
					<Subtitle>CrowdCoin interacts with a live smart-contract deployed in the Rinkeby Ethereum test network.</Subtitle>
				</Container>
			</HeroBody>
			<HeroFooter>
				<Menu onClickNewCampaign={props.onClickNewCampaign} />
			</HeroFooter>
		</Hero>
	);
}