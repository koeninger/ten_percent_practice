import React, { Component } from 'react';
import { Container } from 'semantic-ui-react';
// import List from './List';
import UserInput from './UserInput';
import UserOutput from './UserOutput';

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
		],
		username: "Joel"
	};

	changeUsernameHandler = (event) => {
		this.setState({
			username: event.target.value
		});
	}
	
	render() {
		return (
			<Container>
				{/* <List items={this.state.list} /> */}
				<UserInput change={this.changeUsernameHandler} username={this.state.username} />
				<UserOutput username={this.state.username} />
			</Container>
		);
	}
}

export default App;
