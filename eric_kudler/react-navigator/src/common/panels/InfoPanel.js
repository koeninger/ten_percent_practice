import React from 'react';
import {Panel} from 'react-bootstrap';

export default class InfoPanel extends React.Component {
	render() {
		let body = 'Click on an attraction for more information, times and location!';
		if (this.props.current) {
			let attraction = this.props.attractions[this.props.current];
			body = (
				<h3>{attraction.name}</h3>
			)
		}
		return (
			<Panel>
				<h4>More Info</h4>
				<hr />
				<div>
					{body}
				</div>
			</Panel>
		);
	}
}