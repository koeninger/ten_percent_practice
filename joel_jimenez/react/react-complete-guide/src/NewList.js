import React from 'react';
import { Modal, Button, Input, Message } from 'semantic-ui-react';

const NewList = (props) => {
	return (
		<Modal open={props.isOpen} size="tiny">
			<Modal.Header>Create new list</Modal.Header>
			<Modal.Content>
				<Modal.Description>
					<Input fluid placeholder='New List' label="List name" className="margin-small" onChange={props.change} loading={props.is_loading} value={props.value} />
					<Button primary onClick={props.click} loading={props.is_loading} className="margin-small">Create List</Button>
					<Message info className={props.message_type} header={props.message_content} />
				</Modal.Description>
			</Modal.Content>
		</Modal>
	);
};

export default NewList;