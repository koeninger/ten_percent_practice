import React from 'react';
import { List } from 'semantic-ui-react';
import Task from './Task';

const ListGroup = (props) => {
	const list = props.items.map( (item, index) => {
		return (
			<Task name={item.name} completed={item.completed} />
		);
	});
	return (
		<List divided relaxed>{list}</List>
	);
};

export default ListGroup;