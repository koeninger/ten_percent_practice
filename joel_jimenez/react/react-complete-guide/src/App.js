import React, { Component } from 'react';
import { Container, Tab, Header, Button } from 'semantic-ui-react';
import TaskList from './List';
import './App.css';
import NewList from './NewList';
import NewTask from './NewTask';

class App extends Component {
	state = {
		active_index: 0,
		lists: [
			{
				id: 1,
				menuItem: "Tasks",
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
				menuItem: "Shopping",
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
		new_list_name: "",
		is_creating_new_task: false,
		is_creating_new_task: false,
		is_creating_new_task: false,
		new_list_message_hidden: true,
		new_list_message_color: "",
		new_list_message_text: ""
	}

	componentDidMount(){
		this.changeList(0);
	}

	changeList = (list_index) => {
		// Update the index of selected list
		this.setState({
			active_index: list_index
		});
	}

	createNewList = () => {
		const lists = this.state.lists.slice();
		this.setState({
			is_creating_new_task: true,
			new_list_message_hidden: false,
			new_list_message_color: "blue",
			new_list_message_text: "Creating new list"
		});

		setTimeout(() => {
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
				is_creating_new_task: false,
				new_list_message_color: "green",
				new_list_message_text: "New list has been created"
			});
			console.log(this.state.lists);
		}, 2000);
	}

	changeNewList = (event) => {
		this.setState({
			new_list_name: event.target.value
		});
	}

	render() {
		return (
			<Container>
				<Header textAlign="center" className="padding-small">To Do List</Header>
				<Tab panes={this.state.lists} 
					activeIndex={this.state.active_index} 
					onTabChange={(event, data) => this.changeList(data.activeIndex)}  
					menu={{ secondary: true, pointing: true }} 
				/>
				<Container textAlign="center">
					<NewList value={this.state.new_list_name} 
						click={this.createNewList} 
						change={this.changeNewList} 
						is_loading={this.state.is_creating_new_task}
						message_hidden={this.state.new_list_message_hidden} 
						message_color={this.state.new_list_message_color} 
						message_text={this.state.new_list_message_text} />
					<NewTask />
				</Container>
				<Tab.Pane>
					<TaskList list={this.state.lists[this.state.active_index].tasks} />
				</Tab.Pane>
			</Container>
		);
	}
}

export default App;
