import React from 'react';
import ReactDOM from 'react-dom';
import { Panel, Jumbotron, Button } from 'react-bootstrap';
import { Row, Col } from 'react-bootstrap';

export default class InfoPanel extends React.Component {
	constructor(props) {
		super(props);
	}
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