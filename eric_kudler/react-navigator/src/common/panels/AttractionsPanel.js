import React from 'react';
import ReactDOM from 'react-dom';
import { Panel, Jumbotron, Button } from 'react-bootstrap';
import { Row, Col } from 'react-bootstrap';
import { Navbar, Nav, NavItem, NavDropdown, MenuItem} from 'react-bootstrap';
import DatePicker from 'react-datepicker';
import moment from 'moment';
import uniqueId from 'lodash/uniqueId';
import Sortable from 'react-sortablejs';

export default class AttractionsPanel extends React.Component {
	constructor(props) {
		super(props);
		this.state = {
			items: ['Apple', 'Banana', 'Cherry', 'Guava', 'Peach', 'Strawberry']
		};
		this.onSortChange = this.onSortChange.bind(this)
	}
	onSortChange(order, sortable, evt) {
		this.setState({ items: order });
	}
	render() {
		const items = this.state.items.map(function(val) {
			return (<div key={uniqueId()} data-id={val}>{val}</div>)
		});
		return (
			<Panel>
				<h4>All Attractions</h4>
				<hr />
				<div>
					<Sortable
	
						onChange={this.onSortChange}
						options={{
                                    animation: 150,
                                    group: {
                                        name: 'shared',
                                        pull: true,
                                        put: true
                                    }
                                }}>
						{items}
					</Sortable>
				</div>
			</Panel>
		);
	}
}