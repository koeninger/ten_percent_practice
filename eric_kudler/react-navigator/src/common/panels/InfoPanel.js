import React from 'react';
import ReactDOM from 'react-dom';
import { Panel, Jumbotron, Button } from 'react-bootstrap';
import { Row, Col } from 'react-bootstrap';

export default class InfoPanel extends React.Component {
	render() {
		return (
			<Panel>
				<h4>More Info</h4>
				<hr />
				<div>
					Click on an attraction for more information, times and location!
				</div>
			</Panel>
		);
	}
}