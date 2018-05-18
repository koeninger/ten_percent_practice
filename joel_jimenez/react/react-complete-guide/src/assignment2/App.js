import React, { Component } from 'react';
import { Container, Header, Input } from 'semantic-ui-react';
import Validation from './Validation';
import Char from './Char';

class Assignment2 extends Component {
	state = {
		text: ""
	}

	onChangeText = (newText) => {
		this.setState({
			text: newText
		});
	}

	// Removes character from text by index
	onLetterClick = (letterIndex) => {
		// Convert text to array
		const textArray = this.state.text.split('');

		// Remove character by index
		textArray.splice(letterIndex, 1);

		// Save array as text
		this.setState({
			text: textArray.join('')
		});
	}

	render(){
		const characters = this.state.text.split('').map((letter, index) => {
			return (
				<Char letter={letter} key={index} click={() => this.onLetterClick(index)} />
			);
		});

		return (
			<Container>
				<Header>Assignment 2</Header>
				<Input value={this.state.text} onChange={(event) => this.onChangeText(event.target.value)} />
				<p>{this.state.text}</p>
				<Validation text={this.state.text} />
				{characters}
			</Container>
		);
	}
}

export default Assignment2;