import React, { Component } from 'react';
import { Container } from 'semantic-ui-react';

import Header from './Header';
import Tasks from './Tasks';
import ModalConductor from './ModalConductor';

class App extends Component {
	state = {
		selectedList: "1",
		selectedTask: null,
		modalOpen: false,
		currentModal: null,
		modalValue: ""
	}

	setList = (e, {value}) => {
		this.setState({
			selectedList: value
		});
	}

	toggleTask = (test) => {
		console.log(test);
	}

	openModal = (modal) => {
		this.setState({
			modalOpen: true,
			currentModal: modal
		});
	}
	closeModal = () => {
		this.setState({
			modalOpen: false,
			modalValue: "",
			selectedTask: null,
			currentModal: null
		});
	}
	onChangeModalValue = (e, { value }) => {
		this.setState({
			modalValue: value
		});
	}
	saveModalValue = (modalType) => {
		console.log("Save", modalType);
		console.log(this.state.modalValue);
		this.closeModal();
	}
	deleteItem = () => {
		console.log("DELETE", this.state.selectedList);
		this.closeModal();
	}

	updateSelectedTask = (taskId, taskName) => {
		this.setState({
			modalValue: taskName,
			selectedTask: taskId
		});
	}

	deleteListConfirm = () => {
		this.setState({
			modalOpen: true,
			currentModal: "delete_list",
			modalValue: this.state.selectedList
		});
	}

	render() {
		return (
			<Container>
				<Header 
					setList={this.setList} 
					listId={this.state.selectedList} 
					openModal={this.openModal} 
					deleteList={this.deleteListConfirm} 
				/>
				<Tasks 
					listId={this.state.selectedList} 
					toggleTask={this.toggleTask} 
					openModal={this.openModal} 
					updateSelectedTask={this.updateSelectedTask} 
				/>
				<ModalConductor 
					currentModal={this.state.currentModal}
					isOpen={this.state.modalOpen} 
					closeModal={this.closeModal} 
					modalValue={this.state.modalValue} 
					saveModalValue={this.saveModalValue} 
					onChangeModalValue = {this.onChangeModalValue} 
					deleteItem = {this.deleteItem} 
					selectedList={this.state.selectedList} 
					selectedTask={this.state.selectedTask} 
				/>
			</Container>
		);
	}
}

export default App;
