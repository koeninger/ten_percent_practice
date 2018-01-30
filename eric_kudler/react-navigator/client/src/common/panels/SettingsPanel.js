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
			<Panel className="settings-panel">
				<Panel.Heading>
					<Panel.Title>
						Your Vacation
					</Panel.Title>
				</Panel.Heading>
				<Panel.Body>
					<form>
						<div className="form-group">
							<Row>
								<Col md={3}>
								<ControlLabel>From</ControlLabel>
									<DatePicker
										className="form-control"
										selected={this.state.startDate}
										onChange={this.setStartDate} />
								</Col>
								<Col md={3}>
									<ControlLabel>To</ControlLabel>
									<DatePicker
										className="form-control" 
										selected={this.state.endDate}
										onChange={this.setEndDate} />
								</Col>
							</Row>
							<Row>
								<Col md={12}>
									<Button className="pull-right" bsStyle="success">Make My Itinerary!</Button>
								</Col>
							</Row>
						</div>
					</form>
				</Panel.Body>
			</Panel>
		);
	}
}