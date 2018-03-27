import React, { Component } from 'react';

class SearchBar extends Component {
	constructor(props) {
		super(props);

		this.state = { search_term: '' };
	}

	render() {
		return (
			<div className="section">
				<input onChange={ event => this.setState( {search_term: event.target.value} ) } className="input is-medium" type="text" />
			</div>
		);
	}

	onKeyPress(target) {
		if(target.charCode == 13){
			console.log('ENTER!');
		}
	}
}

export default SearchBar;