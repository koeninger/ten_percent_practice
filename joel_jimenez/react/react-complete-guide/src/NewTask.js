import React from 'react';
import { Modal, Button, Input, Message } from 'semantic-ui-react';

const NewTask = (props) => {
	return (
		<Modal open={props.isOpen} size="tiny">
			<Modal.Header>Create new task</Modal.Header>
			<Modal.Content>
				<Modal.Description>
					<Input fluid placeholder='New Task' label="Task name" className="margin-small" onChange={props.change} loading={props.is_loading} value={props.value} />
					<Message info className={props.message_type} header={props.message_content} />
				</Modal.Description>
			</Modal.Content>
			<Modal.Actions>
				<Button onClick={props.cancel} className="margin-small">Cancel</Button>
				<Button primary onClick={props.click} loading={props.is_loading} className="margin-small">Create Task</Button>
			</Modal.Actions>
		</Modal>
	);
};

export default NewTask;