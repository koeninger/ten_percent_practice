import React, { Component } from 'react';
import { Container, Dropdown } from 'semantic-ui-react';
import TaskList from './List';

class App extends Component {
	state = {
		selected_list: 1,
		lists: [
			{
				key: 1,
				value: 1,
				text: "Chores"
			}
		]
	}
	render() {
		return (
			<Container>
				<Dropdown placeholder='List' search selection options={this.state.lists} value={this.state.selected_list} />
				<TaskList list={this.state.selected_list} />
			</Container>
		);
	}
}

export default App;
