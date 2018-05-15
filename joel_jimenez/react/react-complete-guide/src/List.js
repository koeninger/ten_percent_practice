import React, { Component } from 'react';
import { List } from 'semantic-ui-react';
import Task from './Task';

class ListGroup extends Component {
	state = {
		list: [
			{
				id: 1,
				name: "Take out the trash",
				completed: false
			},
			{
				id: 2,
				name: "Pay credit card bill",
				completed: true
			},
			{
				id: 3,
				name: "Work on ten percent",
				completed: false
			}
		]
	};

	clickTask = (task_id) => {
		const task_index = this.state.list.findIndex(i => {
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

	render(){
		const list = this.state.list.map( (task, index) => {
			return (
				<Task key={"task_" + task.id} name={task.name} completed={task.completed} click={() => this.clickTask(task.id)} />
			);
		});

		return (
			<List divided relaxed size="large">{list}</List>
		);
	}
}

export default ListGroup;