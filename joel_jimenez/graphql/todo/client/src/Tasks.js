import React from 'react';
import gql from 'graphql-tag';
import { Query } from 'react-apollo';
import { Grid, Segment, Header, Button, Icon } from 'semantic-ui-react';

const Tasks = (props) => {

	const GET_TASKS = gql`
		query tasks($listId: String!) {
			list(id: $listId){
				tasks{
					id
					name
					completed
				}
			}
		}
	`;

	const triggerModal = (modalType, taskId, taskName) => {
		props.updateSelectedTask(taskId, taskName);
		props.openModal(modalType);
	};
	
	return (
		<Query query={GET_TASKS} variables={{ listId: props.listId.toString() }}>
			{({ loading, error, data }) => {
				if (loading) return <Segment loading>Loading...</Segment>;

				if (error){
					console.log(error.message);
					return `No tasks found.`;
				}

				return (
					<Segment size='huge'>
						<Grid divided='vertically' verticalAlign='middle'>
							{data.list.tasks.map(task => (
								<Grid.Row columns={3} key={task.id} textAlign='center' className='no-margin-children no-padding small-padding-children'>
									<Grid.Column width={2} onClick={() => props.toggleTask(task.id)}>
										<Icon name={task.completed ? 'check square outline' : 'square outline'} />
									</Grid.Column>
									<Grid.Column mobile={8} computer={10} onClick={() => props.toggleTask(task.id)}>
										<Header size='small'>{task.completed ? (<s>{task.name}</s>) : task.name}</Header>
									</Grid.Column>
									<Grid.Column width={2}>
										<Button color='teal' icon onClick={() => triggerModal('edit_task', task.id, task.name)}>
											<Icon name='edit' />
										</Button>
									</Grid.Column>
									<Grid.Column width={2}>
										<Button color='orange' icon onClick={() => triggerModal('delete_task', task.id, task.name)}>
											<Icon name='delete' />
										</Button>
									</Grid.Column>
								</Grid.Row>
							))}
						</Grid>
					</Segment>
				);
			}}
		</Query>
	);
};

export default Tasks;