import React, { Component } from 'react';
import gql from 'graphql-tag';
import { Query } from 'react-apollo';

const GET_USERS = gql`
  {
    users{
      id
      name
    }
  }
`;

class App extends Component {
  render() {
    return (
      <Query query={GET_USERS}>
        {({ loading, error, data }) => {
          if (loading) return 'Loading...';
          if (error) return `Error! ${error.message}`;

          return (
            <div>
              {data.users.map(user => (
                <p key={user.id} value={user.name}>
                  {user.name}
                </p>
              ))}
            </div>
          );
        }}
      </Query>
    );
  }
}

export default App;
