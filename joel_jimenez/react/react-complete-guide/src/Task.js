import React from 'react';
import { Table, Header, Icon, Button } from 'semantic-ui-react';

const Task = (props) => {
	let checkbox = 'square';
	let task_name = props.name;

	if(props.completed){
		checkbox = 'check square';
		task_name= (<s>{props.name}</s>);
	}

	return (
		<Table.Row>
			<Table.Cell onClick={props.clickTask}>
				<Icon name={checkbox} size='large' />
			</Table.Cell>
			<Table.Cell onClick={props.clickTask} width={12}>
				<Header>{task_name}</Header>
			</Table.Cell>
			{/* <Table.Cell textAlign='right'>
				<Button icon='edit' color='teal' onClick={props.editTask} />
			</Table.Cell> */}
			<Table.Cell>
				<Button icon='delete' color='red' onClick={props.deleteTask} />
			</Table.Cell>
		</Table.Row>
	);
};

export default Task;