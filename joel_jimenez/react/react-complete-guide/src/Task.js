import React from 'react';
import { List, Header } from 'semantic-ui-react';

const Task = (props) => {
	let checkbox = 'square';
	if(props.completed){
		checkbox = 'check square';
	}
	return (
		<List.Item onClick={props.click}>
			<List.Icon name={checkbox} verticalAlign="middle" size='large' />
			<List.Content>
				<List.Description>
					<Header>{props.name}</Header>
				</List.Description>
			</List.Content>
		</List.Item>
	);
};

export default Task;