import React, { Component } from 'react';
import { Container } from 'semantic-ui-react';
import Header from './Header';
import Tasks from './Tasks';

class App extends Component {
	state = {
		selectedList: "1"
	}

	setList = (e, {value}) => {
		this.setState({
			selectedList: value
		});
	}

	render() {
		return (
			<Container>
				<Header setList={this.setList} listId={this.state.selectedList} />
				<Tasks listId={this.state.selectedList} />
			</Container>
		);
	}
}

export default App;
