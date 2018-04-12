import React from 'react';
import { Container, Hero, HeroBody, Subtitle } from 'bloomer';

export default () => {
	return (
		<Hero isColor='dark' isSize='medium'>
			<HeroBody>
				<Container hasTextAlign="centered">
					<Subtitle>CrowdCoin interacts with a live smart-contract deployed in the Rinkeby Ethereum test network.</Subtitle>
				</Container>
			</HeroBody>
		</Hero>
	);
}