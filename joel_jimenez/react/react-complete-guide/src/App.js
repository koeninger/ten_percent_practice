import React, { Component } from 'react';
import { Container, Dropdown, Header, Button } from 'semantic-ui-react';
import TaskList from './List';
import './App.css';

class App extends Component {
	state = {
		list_id: 0,
		selected_list: [],
		lists: [
			{
				key: 1,
				value: 1,
				text: "Tasks",
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
				key: 2,
				value: 2,
				text: "Shopping",
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
		]
	}

	componentDidMount(){
		this.changeList(1);
	}

	changeList = (list_id) => {
		// Update the ID of selected list
		this.setState({
			list_id: list_id
		});

		// Get list with matching ID
		const list_index = this.state.lists.findIndex( i => {
			return i.key === list_id;
		});

		// Update list
		const list = this.state.lists[list_index];
		this.setState({
			selected_list: list.tasks
		});
	}

	render() {
		return (
			<Container>
				<Header></Header>
				<Header>To Do List</Header>
				<Dropdown search selection placeholder='List' options={this.state.lists} value={this.state.list_id} onChange={(event, data) => this.changeList(data.value)} />
				<Button primary content='New List' icon='add' labelPosition='left' />
				<Button secondary content='New Task' icon='add' labelPosition='left' />
				<TaskList items={this.state.selected_list} />
			</Container>
		);
	}
}

export default App;
