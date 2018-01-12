import React from 'react';
import ReactDOM from 'react-dom';
import { Panel, Jumbotron, Button } from 'react-bootstrap';
import uniqueId from 'lodash/uniqueId';
import Sortable from 'react-sortablejs';

export default class InterestsPanel extends React.Component {
	constructor(props) {
		super(props);
		this.state = {
			items: []
		};
		this.onSortChange = this.onSortChange.bind(this)
	}
	onSortChange(order, sortable, evt) {
		this.setState({ items: order });
	}
	render() {
		const items = this.state.items.map(function(val) {
			return (<div className="attraction" key={uniqueId()} data-id={val}>{val}</div>)
		});
		return (
			<Panel>
				<h4>My Attractions</h4>
				<hr />
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
			</Panel>
		);
	}
}