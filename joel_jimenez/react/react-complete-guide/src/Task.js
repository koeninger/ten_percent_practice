import React from 'react';
import { List, Checkbox } from 'semantic-ui-react';

const Task = (props) => {
	return (
		<List.Item>
			<List.Content>
				<List.Description>
					<Checkbox 
						checked={props.completed} 
						label={props.name} 
						onChange={props.change} 
					/>
				</List.Description>
			</List.Content>
		</List.Item>
	);
};

export default Task;