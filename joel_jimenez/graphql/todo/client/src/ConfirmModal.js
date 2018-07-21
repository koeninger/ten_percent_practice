import React from 'react';
import { Confirm } from 'semantic-ui-react';

const ConfirmModal = (props) => {
	return (
		<Confirm size="tiny" 
			centered={false} 
			open={props.isOpen} 
			content={props.content} 
			onCancel={props.closeModal} 
			onConfirm={() => props.deleteItem(props.currentModal)} 
		/>
	);
}

export default ConfirmModal;