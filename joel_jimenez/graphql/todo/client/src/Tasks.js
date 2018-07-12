import React from 'react';
import gql from 'graphql-tag';
import { Query } from 'react-apollo';
import { List } from 'semantic-ui-react';

const Tasks = (props) => {

	const GET_TASKS = gql`
		query tasks($listId: String!) {
			list(id: $listId){
				tasks{
					id
					name
				}
			}
		}
	`;

	return (
		<Query query={GET_TASKS} variables={{ listId: props.listId.toString() }}>
			{({ loading, error, data }) => {
				if (loading) return 'Loading...';

				if (error){
					console.log(error);
					return `Error! ${error.message}`;
				}

				return (
					<List verticalAlign='middle' size='huge'>
						{data.list.tasks.map(task => (
							<List.Item className='padding-5' key={task.id}>{task.name}</List.Item>
						))}
					</List>
				);
			}}
		</Query>
	);
};

export default Tasks;