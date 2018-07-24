import React from 'react';
import { Segment, Grid, Button, Icon } from 'semantic-ui-react';
import Lists from './Lists';

const Header = (props) => {
	return (
		<Segment size='large'>
			<Grid stackable verticalAlign='middle'>
				<Grid.Row columns={2}>
					<Grid.Column width='6'>
						<Lists {...props} />
					</Grid.Column>
					<Grid.Column width='10'>
						<Button.Group labeled icon size='large' widths='3' className='auto-height'>
							<Button animated='fade' basic color='blue' onClick={() => props.openModal('new_task')}>
								<Button.Content visible>
									<Icon name='plus' />
								</Button.Content>
								<Button.Content hidden>New Task</Button.Content>
							</Button>
							<Button animated='fade' basic color='teal' onClick={() => props.openModal('new_list')}>
								<Button.Content visible>
									<Icon name='plus' />
								</Button.Content>
								<Button.Content hidden>New List</Button.Content>
							</Button>
							<Button animated='fade' basic color='orange' onClick={props.deleteList}>
								<Button.Content visible>
									<Icon name='delete' />
								</Button.Content>
								<Button.Content hidden>Delete List</Button.Content>
							</Button>
						</Button.Group>
					</Grid.Column>
				</Grid.Row>
			</Grid>
		</Segment>
	);
};

export default Header;