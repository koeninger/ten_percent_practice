import React, { Component } from 'react';
import axios from 'axios';
import { Container, Tab, Header, Dimmer, Loader, Button } from 'semantic-ui-react';
import List from './List';
import './App.css';
import NewList from './NewList';
import NewTask from './NewTask';
import ConfirmDelete from './ConfirmDelete';

class App extends Component {
	state = {
		active_index: 0,
		lists: [],
		getting_lists: false,
		new_list_name: "",
		is_creating_new_list: false,
		new_list_message_type: "hidden",
		new_list_message_content: "",
		new_task_name: "",
		is_creating_new_task: false,
		new_task_message_type: "hidden",
		new_task_message_content: ""
	}

	componentDidMount(){
		if(!this.state.lists.length){
			this.getLists().then(lists => this.setState({lists}))
				.catch(err => {
					console.log(err);
				});
		}
		this.changeList(0);
	}

	async getLists() {
		this.setState({
			getting_lists: true
		});
		const response = await axios('lists.json');

		await this.timeout(1000);
		this.setState({
			getting_lists: false
		});

		return await response.data;
	}

	// Mimic interaction to server
	timeout = (ms) => {
		return new Promise(resolve => setTimeout(resolve, ms));
	}


// LIST FUNCTIONS
	changeList = (list_index) => {
		// Update the index of selected list
		this.setState({
			active_index: list_index
		});
	}

	createNewList = async () => {
		const lists = [...this.state.lists];
		this.setState({
			is_creating_new_list: true,
			new_list_message_type: "info",
			new_list_message_content: "Creating new list..."
		});

		await this.timeout(1000);
		if(this.state.new_list_name === ""){
			this.setState({
				is_creating_new_list: false,
				new_list_message_type: "error",
				new_list_message_content: "There was a problem creating new list."
			});

		} else{
			const new_list = {
				id: lists.length + 1,
				menuItem: this.state.new_list_name,
				tasks: []
			};
			lists.push(new_list);
	
			this.setState({
				// active_index: lists.length - 1,
				lists: lists,
				new_list_name: "",
				is_creating_new_list: false,
				new_list_message_type: "success",
				new_list_message_content: "New list was created successfully!"
			});
		}
	}

	changeNewList = (event) => {
		this.setState({
			new_list_name: event.target.value,
			new_list_message_type: "hidden",
			new_list_message_content: ""
		});
	}

	confirmDeleteList = () => {
		this.setState({
			confirmDeleteOpen: true,
			nameToDelete: this.state.lists[this.state.active_index].menuItem,
			deleteFunction: () => {
				this.deleteList()
			}
		});
	}

	deleteList = () => {
		// Make a copy of lists
		const lists = [...this.state.lists];

		// Remove list by active index
		lists.splice(this.state.active_index, 1);

		// Save the changes in state
		this.setState({
			confirmDeleteOpen: false,
			nameToDelete: "",
			active_index: lists.length - 1,
			lists: lists
		});
	}


// TASK functions
	// Clicking on a task toggles marking it complete
	clickTask = (task_id) => {
		// Make a copy of lists
		const lists = [...this.state.lists];
		// Find the matching id of task in list
		const task_index = lists[this.state.active_index].tasks.findIndex( i => {
			return i.id === task_id;
		});
		// Toggle complete
		lists[this.state.active_index].tasks[task_index].completed = !lists[this.state.active_index].tasks[task_index].completed;
		this.setState(lists);
	}

	// Confirm delete task modal
	confirmDeleteTask = (task_index) => {
		this.setState({
			confirmDeleteOpen: true,
			nameToDelete: this.state.lists[this.state.active_index].tasks[task_index].name,
			deleteFunction: () => {
				this.deleteTask(task_index)
			}
		});
	}

	// Deleting a task removes it from a list
	deleteTask = (task_index) => {
		// Make a copy of lists
		const lists = [...this.state.lists];

		// Remove task from list
		lists[this.state.active_index].tasks.splice(task_index, 1);

		// Save the changes in state
		this.setState({
			confirmDeleteOpen: false,
			nameToDelete: "",
			lists: lists
		});
	}

	createNewTask = async () => {
		// Make a copy of lists
		const lists = [...this.state.lists];
		this.setState({
			is_creating_new_task: true,
			new_task_message_type: "info",
			new_task_message_content: "Creating new task..."
		});

		await this.timeout(1000);
		if(this.state.new_task_name === ""){
			this.setState({
				is_creating_new_task: false,
				new_task_message_type: "error",
				new_task_message_content: "There was a problem creating new task."
			});

		} else{
			const new_task = {
				id: lists[this.state.active_index].tasks.length + 1,
				name: this.state.new_task_name,
				completed: false
			};
			lists[this.state.active_index].tasks.push(new_task);
	
			this.setState({
				tasks: lists[this.state.active_index].tasks,
				new_task_name: "",
				is_creating_new_task: false,
				new_task_message_type: "success",
				new_task_message_content: "New task was created successfully!"
			});
		}
	}

	changeNewTask = (event) => {
		this.setState({
			new_task_name: event.target.value,
			new_task_message_type: "hidden",
			new_task_message_content: ""
		});
	}

	renderTasks = () => {
		let rendered_tasks = (
			<Header textAlign="center">No lists found.</Header>
		);
		if(this.state.lists.length){
			rendered_tasks = (
				<Header textAlign="center">No tasks found.</Header>
			);
			if(this.state.lists[this.state.active_index].tasks.length){
				rendered_tasks = (
					<Tab.Pane>
						<List 
							openDeleteTask={this.confirmDeleteTask} 
							clickTask={this.clickTask} 
							list={this.state.lists[this.state.active_index].tasks} 
						/>
					</Tab.Pane>
				);
			}
		}
		return rendered_tasks;
	}

	render() {
		return (
			<Container>
				<Dimmer active={this.state.getting_lists}>
					<Loader size='large'>Loading</Loader>
				</Dimmer>
				<Header textAlign="center" className="padding-small">To Do List</Header>
				{this.state.lists.length > 0 && (
					<Tab panes={this.state.lists} 
						activeIndex={this.state.active_index} 
						onTabChange={(event, data) => this.changeList(data.activeIndex)}  
						menu={{ secondary: true, pointing: true }} 
					/>
				)}
				<Container textAlign="center">
					<NewTask value={this.state.new_task_name} 
						click={this.createNewTask} 
						change={this.changeNewTask} 
						is_loading={this.state.is_creating_new_task}
						message_type={this.state.new_task_message_type} 
						message_content={this.state.new_task_message_content}
					/>
					<NewList value={this.state.new_list_name} 
						click={this.createNewList} 
						change={this.changeNewList} 
						is_loading={this.state.is_creating_new_list}
						message_type={this.state.new_list_message_type} 
						message_content={this.state.new_list_message_content}
					/>
					<Button negative 
						className="margin-small" content="Delete List" icon='delete' labelPosition='left' 
						onClick={ this.confirmDeleteList } 
					/>
					<ConfirmDelete 
						isOpen={this.state.confirmDeleteOpen} 
						name={this.state.nameToDelete} 
						cancel={() => this.setState({confirmDeleteOpen: false})} 
						delete={this.state.deleteFunction}
					/>
				</Container>
				{this.renderTasks()}
			</Container>
		);
	}
}

export default App;
