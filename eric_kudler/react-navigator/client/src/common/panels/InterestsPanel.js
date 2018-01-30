import React from 'react';
import {Panel} from 'react-bootstrap';
import uniqueId from 'lodash/uniqueId';
import Sortable from 'react-sortablejs';

export default class InterestsPanel extends React.Component {
	constructor(props) {
		super(props);
		this.state = {
			items: []
		};
		this.onSortChange = this.onSortChange.bind(this)
		this.setCurrentAttraction = this.setCurrentAttraction.bind(this)
	}
	onSortChange(order, sortable, evt) {
		let self = this;
		let items = [];
		order.forEach(function(val) {
			items[val] = self.props.attractions[val];
		})
		this.setState({ items: items });
	}
	setCurrentAttraction(attraction_id) {
		this.props.setCurrentAttraction(attraction_id);
	}
	render() {
		const self = this;
		let items = []
		for (var id in this.state.items) {
			items.push(
				<div className="attraction" key={uniqueId()} data-id={id} data-name={this.state.items[id].name} onClick={(e) => self.setCurrentAttraction(this.state.items[id]._id)}>
					{this.state.items[id].name}
				</div>
			);
		}
		return (
			<Panel className="interests-panel">
				<Panel.Heading>
					<Panel.Title>
						My Attractions
					</Panel.Title>
				</Panel.Heading>
				<Panel.Body>
					<Sortable
						onChange={this.onSortChange}
						className="attractions-list"
						options={{
									animation: 150,
									group: {
										name: 'attractions',
										pull: true,
										put: true
									}
								}}>
							{items}
					</Sortable>
				</Panel.Body>
			</Panel>
		);
	}
}