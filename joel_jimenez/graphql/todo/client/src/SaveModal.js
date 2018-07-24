import React from 'react';
import { Modal, Button, Form, Input } from 'semantic-ui-react';

const SaveModal = (props) => {
	return (
		<Modal centered={false} open={props.isOpen}>
			<Modal.Content>
				<Form>
					<Form.Field inline>
						<label>{props.modalTypeName} Name</label>
						<Input placeholder={props.modalTypeName + ' Name'} value={props.modalValue} onChange={props.onChangeModalValue} />
					</Form.Field>
				</Form>
			</Modal.Content>
			<Modal.Actions>
				<Button positive onClick={() => props.saveModalValue(props.currentModal)} content={'Save ' + props.modalTypeName} />
				<Button negative onClick={props.closeModal} content="Cancel" />
			</Modal.Actions>
		</Modal>
	);
}

export default SaveModal;