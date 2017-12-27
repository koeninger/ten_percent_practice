import React from 'react';
import ReactDOM from 'react-dom';
import { Panel, Jumbotron, Button } from 'react-bootstrap';
import { Row, Col } from 'react-bootstrap';
import { Navbar, Nav, NavItem, NavDropdown, MenuItem} from 'react-bootstrap';
import DatePicker from 'react-datepicker';
import moment from 'moment';
import uniqueId from 'lodash/uniqueId';
import Sortable from 'react-sortablejs';
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