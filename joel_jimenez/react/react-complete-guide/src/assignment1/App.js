import React, { Component } from 'react';
import { Container, Header, Input } from 'semantic-ui-react';
import UserInput from './UserInput';
import UserOutput from './UserOutput';

class Assignment1 extends Component {
	state = {
		name: ""
	}

	onChangeName = (newName) => {
		this.setState({
			name: newName
		})
	}

	render() {
		return (
			<Container>
				<Header>Assignment 1</Header>
				<UserInput name={this.state.name} change={(event) => this.onChangeName(event.target.value)} />
				<UserOutput name={this.state.name} />
			</Container>
		);
	}
}

export default Assignment1;