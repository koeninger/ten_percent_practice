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

const formatListOptions = (lists) => {
	const listOptions = [];

	lists.forEach(function (list, index) {
		listOptions.push({
			key: list.id,
			value: list.id,
			text: list.name
		});
	});

	return listOptions;
};

const Lists = (props) => {
	return (
		<Query query={GET_LISTS}>
			{({ loading, error, data }) => {
				if (loading) return (<Dropdown fluid search selection options={[]} loading />);

				if (error){
					console.log(error.message);
					return `No lists found.`;
				}

				return (
					<Dropdown fluid search selection placeholder='Lists' 
						options={formatListOptions(data.lists)} 
						value={props.listId} 
						onChange={props.setList} 
					/>
				);
			}}
		</Query>
	);
};

export default Lists;