import React from 'react';
import { Container, Hero, HeroBody, Subtitle } from 'bloomer';

export default () => {
	const year = new Date().getFullYear();
	
	return (
		<Hero isColor='dark' isSize='medium'>
			<HeroBody>
				<Container hasTextAlign="centered">
					<Subtitle>&copy; {year} Joel Jimenez</Subtitle>
				</Container>
			</HeroBody>
		</Hero>
	);
}