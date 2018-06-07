import React from 'react';
import { Confirm } from 'semantic-ui-react';

const ConfirmDelete = (props) => {
	return (
		<Confirm 
			open={props.isOpen}
			content={"Are you sure you want to delete " + props.name + "?"} 
			confirmButton="Delete" 
			onCancel={props.cancel} 
			onConfirm={() => props.delete()} 
		/>
	);
};

export default ConfirmDelete;