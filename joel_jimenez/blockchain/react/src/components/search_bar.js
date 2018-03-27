import React, { Component } from 'react';

class SearchBar extends Component {
	constructor(props) {
		super(props);

		this.state = { search_term: '' };
	}

	render() {
		return (
			<div className="form-group">
				<input onChange={ event => this.setState( {search_term: event.target.value} ) } className="form-control" type="text" />
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