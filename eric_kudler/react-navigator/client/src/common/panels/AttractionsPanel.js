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
			items[val] = self.props.attractions[val];
		})
		this.setState({ items: items });
	}
	setCurrentAttraction(attraction_id) {
		this.props.setCurrentAttraction(attraction_id);
	}
	componentWillReceiveProps(nextProps) {
		this.setState({
			items: nextProps.attractions
		});
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
			<Panel className="attractions-panel">
				<Panel.Heading>
					<Panel.Title>
						All Attractions
					</Panel.Title>
				</Panel.Heading>
				<Panel.Body>
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
				</Panel.Body>
			</Panel>
		);
	}
}