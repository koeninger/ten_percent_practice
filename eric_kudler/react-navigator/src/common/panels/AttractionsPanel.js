import React from 'react';
import {Panel} from 'react-bootstrap';
import uniqueId from 'lodash/uniqueId';
import Sortable from 'react-sortablejs';

export default class AttractionsPanel extends React.Component {
	constructor(props) {
		super(props);
		this.state = {
			items: props.attractions
		};
		this.onSortChange = this.onSortChange.bind(this);
	}
	onSortChange(order, sortable, evt) {
		let self = this;
		let items = [];
		order.forEach(function(val) {
			items.push(self.props.attractions[val]);
		})
		this.setState({ items: items });
	}
	setCurrentAttraction(attraction_id) {
		this.props.setCurrentAttraction(attraction_id);
	}
	render() {
		const self = this;
		const items = this.state.items.map(function(val) {
			return (
				<div className="attraction" key={uniqueId()} data-id={val.id} data-name={val.name} onClick={(e) => self.setCurrentAttraction(val.id)}>
					{val.name}
				</div>
			);
		});
		return (
			<Panel>
				<h4>All Attractions</h4>
				<hr />
				<Sortable
					className="attractions-list"
					onChange={this.onSortChange}
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
			</Panel>
		);
	}
}