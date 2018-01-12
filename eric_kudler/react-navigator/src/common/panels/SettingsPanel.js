import React from 'react';
import {Panel, Button, ControlLabel} from 'react-bootstrap';
import {Row, Col} from 'react-bootstrap';
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
				<form className="form-inline">
					<div className="form-group">
						<DatePicker
							className="form-control"
							selected={this.state.startDate}
							onChange={this.setStartDate} />
						<span>To</span>
						<DatePicker
						className="form-control" 
							selected={this.state.endDate}
							onChange={this.setEndDate} />
					</div>
				</form>
			</Panel>
		);
	}
}