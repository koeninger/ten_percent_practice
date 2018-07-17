import React from 'react';
import { Menu, Icon } from 'semantic-ui-react';
import Lists from './Lists';

const Header = (props) => {
	return (
		<Menu stackable icon='labeled' size='huge'>
			<Menu.Item header>
				<Lists setList={props.setList} listId={props.listId} />
			</Menu.Item>
			<Menu.Menu position='right'>
				<Menu.Item link onClick={props.newTask}>
					<Icon color='blue' name='plus' />
					New Task
				</Menu.Item>
				<Menu.Item link onClick={props.newList}>
					<Icon color='teal' name='plus' />
					New List
				</Menu.Item>
				<Menu.Item link onClick={props.deleteList}>
					<Icon color='orange' name='delete' />
					Delete List
				</Menu.Item>
			</Menu.Menu>
		</Menu>
	);
};

export default Header;