import React from 'react';
import {Panel} from 'react-bootstrap';

export default class InfoPanel extends React.Component {
	render() {
		let body = 'Click on an attraction for more information, times and location!';
		if (this.props.current != null) {
			let attraction = this.props.attractions[this.props.current];
			body = (
				<div>
					<h4>{attraction.name}</h4>
					<hr />
					<p>{attraction.description}</p>
				</div>
			)
		}
		return (
			<Panel className="info-panel">
				<Panel.Heading>
					<Panel.Title>
					More Info
					</Panel.Title>
				</Panel.Heading>
				<Panel.Body>
					{body}
				</Panel.Body>
			</Panel>
		);
	}
}