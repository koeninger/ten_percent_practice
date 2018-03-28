import React, { Component } from 'react';

class SearchBar extends Component {
	constructor(props) {
		super(props);

		this.state = { searchTerm: '' };
	}

	render() {
		return (
			<div className="input-group input-group-lg mb-3">
				<input type="text" className="form-control" placeholder="Search YouTube"
					onChange={ event => this.onInputChange(event.target.value) }
					onKeyPress={ (target) => this.onKeyPress(target.charCode) } />
			</div>
		);
	}

	onInputChange(searchTerm) {
		this.setState({searchTerm})
		this.props.onSearchTermChange(searchTerm);
	}

	onKeyPress(charCode) {
		if (charCode == 13){
			this.onInputChange(this.state.searchTerm);
		}
	}
}

export default SearchBar;