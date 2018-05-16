import React from 'react';
import { Grid, Header, Icon, Button } from 'semantic-ui-react';

const Task = (props) => {
	let checkbox = 'square';
	let task_name = props.name;

	if(props.completed){
		checkbox = 'check square';
		task_name= (<s>{props.name}</s>);
	}

	return (
		<Grid.Row className="padding-none">
			<Grid.Column onClick={props.clickTask} textAlign="right" className="click-column">
				<Icon name={checkbox} size='large' />
			</Grid.Column>
			<Grid.Column onClick={props.clickTask} textAlign="left" width={10} className="click-column">
				<Header>{task_name}</Header>
			</Grid.Column>
			{/* <Grid.Column>
				<Button icon='edit' color='teal' onClick={props.editTask} />
			</Grid.Column> */}
			<Grid.Column>
				<Button icon='delete' color='red' onClick={props.deleteTask} />
			</Grid.Column>
		</Grid.Row>
	);
};

export default Task;