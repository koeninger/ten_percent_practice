import React from 'react';
import { Input } from 'semantic-ui-react';

const UserInput = (props) => {
	return (
		<Input 
			placeholder='User Input' 
			onChange={props.change} 
			value={props.name} 
		/>
	);
};

export default UserInput;