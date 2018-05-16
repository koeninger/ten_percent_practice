import React, { Component } from 'react';
import { Header, Grid, Confirm, Container } from 'semantic-ui-react';
import Task from './Task';

class ListGroup extends Component {
	state = {
		selected_list: [],
		lists: [
			{
				id: 1,
				tasks: [
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
			},
			{
				id: 2,
				tasks: [
					{
						id: 1,
						name: "Milk",
						completed: true
					},
					{
						id: 2,
						name: "Eggs",
						completed: false
					},
					{
						id: 3,
						name: "Bread",
						completed: false
					}
				]
			}
		],
		open_modal: false,
		task_to_delete: null
	};

	static getDerivedStateFromProps(nextProps, prevState) {
		const list_index = prevState.lists.findIndex( i => {
			return i.id === nextProps.listId;
		});

		return {
			selected_list: prevState.lists[list_index].tasks
		};
	}

	clickTask = (task_id) => {
		const task_index = this.state.selected_list.findIndex( i => {
			return i.id === task_id;
		});

		const task = {
			...this.state.selected_list[task_index]
		};
		task.completed = !task.completed;

		const tasks = [...this.state.selected_list];
		tasks[task_index] = task;

		this.setState({
			selected_list: tasks
		});
	}

	deleteTask = (task_id) => {
		const task_index = this.state.selected_list.findIndex( i => {
			return i.id === task_id;
		});

		const tasks = [...this.state.selected_list];
		tasks.splice(task_index, 1);

		this.setState({
			selected_list: tasks
		});
	}

	openDeleteTask = (task_id) => {
		this.setState({
			open_modal: true,
			task_to_delete: task_id
		});
	}

	confirmDeleteTask = () => {
		this.deleteTask(this.state.task_to_delete);
		this.closeDeleteTask();
	}

	closeDeleteTask = () => {
		this.setState({
			open_modal: false,
			task_to_delete: null
		});
	}

	render(){
		let lists = (<Header>No tasks found.</Header>);

		if(this.state.selected_list){
			const list = this.state.selected_list.map( (task, index) => {
				return (
					<Task 
						key={"task_" + task.id} 
						name={task.name} 
						completed={task.completed} 
						clickTask={() => this.clickTask(task.id)} 
						deleteTask={() => this.openDeleteTask(task.id)} 
					/>
				);
			});
	
			lists = (
				<Grid divided='vertically' columns='equal' verticalAlign="middle">{list}</Grid>
			);
		}

		return (
			<Container>
				{lists}
				<Confirm
					open={this.state.open_modal}
					onCancel={this.closeDeleteTask}
					onConfirm={this.confirmDeleteTask}
				/>
			</Container>
		)
	}
}

export default ListGroup;