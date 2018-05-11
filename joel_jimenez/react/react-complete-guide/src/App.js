import React, { Component } from 'react';
import { Container, Button } from 'semantic-ui-react';
import List from './List';

class App extends Component {
	state = {
		list: [
			{
				name: "Take out the trash",
				completed: false
			},
			{
				name: "Pay credit card bill",
				completed: true
			},
			{
				name: "Work on ten percent",
				completed: false
			}
		]
	};
	
	render() {
		return (
			<Container>
				<List items={this.state.list} />
			</Container>
		);
	}
}

export default App;
