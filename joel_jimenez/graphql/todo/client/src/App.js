import React, { Component } from 'react';
import gql from 'graphql-tag';
import { Query } from 'react-apollo';

const GET_LISTS = gql`
	{
		lists{
			id
			name
		}
	}
`;

class App extends Component {
	render() {
		return (
			<div>
				<Query query={GET_LISTS}>
					{({ loading, error, data }) => {
						if (loading) return 'Loading...';

						if (error){
							console.log(error);
							return `Error! ${error.message}`;
						}

						return (
							<div>
								{data.lists.map(list => (
									<p key={list.id} value={list.name}>
									{list.name}
									</p>
								))}
							</div>
						);
					}}
				</Query>
			</div>
		);
	}
}

export default App;
