import React, { Component } from 'react';
import { Container, Tab, Header, Button } from 'semantic-ui-react';
import TaskList from './List';
import './App.css';

class App extends Component {
	state = {
		active_index: 0,
		lists: [
			{
				id: 1,
				menuItem: "Tasks"
			},
			{
				id: 2,
				menuItem: "Shopping"
			}
		],
		open_list_modal: false
	}

	componentDidMount(){
		this.changeList(0);
	}

	changeList = (list_index) => {
		// Update the index of selected list
		this.setState({
			active_index: list_index
		});

		// Update list
		const list = this.state.lists[list_index];
		this.setState({
			selected_list: list.tasks
		});
	}

	openListModal(){
		this.setState({
			openListModal: true
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
					<Button primary className="margin-small" content='New List' icon='add' labelPosition='left' onClick={() => this.openListModal()} />
					<Button secondary className="margin-small" content='New Task' icon='add' labelPosition='left' />
				</Container>
				<Tab.Pane>
					<TaskList listId={this.state.lists[this.state.active_index].id} />
				</Tab.Pane>
			</Container>
		);
	}
}

export default App;
