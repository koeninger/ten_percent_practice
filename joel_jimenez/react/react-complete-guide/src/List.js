import React, { Component } from 'react';
import { Table, Header } from 'semantic-ui-react';
import Task from './Task';

class ListGroup extends Component {
	state = {
		list: []
	};

	static getDerivedStateFromProps(props) {
		return {
			list: props.items
		};
	}

	clickTask = (task_id) => {
		const task_index = this.state.list.findIndex( i => {
			return i.id === task_id;
		});

		const task = {
			...this.state.list[task_index]
		};
		task.completed = !task.completed;

		const tasks = [...this.state.list];
		tasks[task_index] = task;

		this.setState({
			list: tasks
		});
	}

	deleteTask = (task_id) => {
		const task_index = this.state.list.findIndex( i => {
			return i.id === task_id;
		});

		const tasks = [...this.state.list];
		tasks.splice(task_index, 1);

		this.setState({
			list: tasks
		});
	}

	render(){
		if(this.state.list){
			const list = this.state.list.map( (task, index) => {
				return (
					<Task 
						key={"task_" + task.id} 
						name={task.name} 
						completed={task.completed} 
						clickTask={() => this.clickTask(task.id)} 
						deleteTask={() => this.deleteTask(task.id)} 
					/>
				);
			});
	
			return (
				<Table unstackable collapsing fixed size='large'>
					<Table.Body>{list}</Table.Body>
				</Table>
			);
		} else{
			return (
				<Header>No tasks found.</Header>
			);
		}
	}
}

export default ListGroup;