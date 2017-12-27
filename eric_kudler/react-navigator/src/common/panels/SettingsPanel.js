import React from 'react';
import ReactDOM from 'react-dom';
import { Panel, Jumbotron, Button } from 'react-bootstrap';
import { Row, Col } from 'react-bootstrap';
import { Navbar, Nav, NavItem, NavDropdown, MenuItem} from 'react-bootstrap';
import DatePicker from 'react-datepicker';
import moment from 'moment';

export default class SettingsPanel extends React.Component {
	constructor (props) {
    	super(props)
    	this.state = {
			startDate: moment().add(7, 'days'),
			endDate: moment().add(12, 'days')
		};
    	this.setStartDate = this.setStartDate.bind(this);
    	this.setEndDate = this.setEndDate.bind(this);
  	}
	setStartDate(date) {
    	this.setState({
			startDate: date
		});
  	}
  	setEndDate(date) {
    	this.setState({
			endDate: date
		});
  	}
	render() {
		return (
			<Panel>
				<h4>Your Vacation</h4>
				<hr />
				<div>
					<DatePicker
						selected={this.state.startDate}
						onChange={this.setStartDate} />
					<span>To</span>
					<DatePicker
						selected={this.state.endDate}
						onChange={this.setEndDate} />
				</div>
			</Panel>
		);
	}
}