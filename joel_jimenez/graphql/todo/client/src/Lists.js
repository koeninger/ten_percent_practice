import React from 'react';
import gql from 'graphql-tag';
import { Query } from 'react-apollo';
import { Dropdown } from 'semantic-ui-react';

const GET_LISTS = gql`
	{
		lists{
			id
			name
		}
	}
`;

const Lists = () => {
	return (
		<Query query={GET_LISTS}>
			{({ loading, error, data }) => {
				if (loading) return 'Loading...';

				if (error){
					console.log(error);
					return `Error! ${error.message}`;
				}

				return (
					<Dropdown placeholder='Lists' fluid search selection>
						<Dropdown.Menu>
							{data.lists.map(list => (
								<Dropdown.Item text={list.name} value={list.id} />
							))}
						</Dropdown.Menu>
					</Dropdown>
				);
			}}
		</Query>
	);
};

export default Lists;