import React from 'react';
import { Header, Grid, Container } from 'semantic-ui-react';
import Task from './Task';

const List = (props) => {
	let lists = (<Header>No tasks found.</Header>);

	if(props.list){
		const list = props.list.map( (task, index) => {
			return (
				<Task 
					key={"task_" + task.id} 
					name={task.name} 
					completed={task.completed} 
					clickTask={() => props.clickTask(task.id)} 
					deleteTask={() => props.openDeleteTask(task.id)} 
				/>
			);
		});

		lists = (
			<Grid divided='vertically' columns='equal' verticalAlign="middle">{list}</Grid>
		);
	}

	return (
		<Container>{lists}</Container>
	);
}

export default List;