import React from 'react';
import gql from 'graphql-tag';
import { Query } from 'react-apollo';
import { Dimmer, Loader } from 'semantic-ui-react';

import SaveModal from './SaveModal';
import ConfirmModal from './ConfirmModal';

const GET_LIST = gql`
	query list($listId: String!) {
		list(id: $listId) {
			name
		}
	}
`;

const ModalConductor = (props) => {
	let new_props = {...props};

	switch (props.currentModal) {
		case 'new_list':
			new_props.modalTypeName = "List";
			return <SaveModal {...new_props} />;

		case 'delete_list':
			return (
				<Query query={GET_LIST} variables={{ listId: props.modalValue }} skip={!props.modalValue}>
					{({ loading, error, data }) => {
						if (loading){
							return (
								<Dimmer active>
									<Loader />
								</Dimmer>
							);
						}

						new_props.content = "Are you sure you want to delete the list \"" + data.list.name + "\"?";
						return <ConfirmModal {...new_props} />;
					}}
				</Query>
			);

		case 'new_task':
			new_props.modalTypeName = "Task";
			return <SaveModal {...new_props} />;

		case 'edit_task':
			new_props.modalTypeName = "Task";
			return <SaveModal {...new_props} />;

		case 'delete_task':
			new_props.content = "Are you sure you want to delete the task \"" + props.modalValue + "\"?";
			return <ConfirmModal {...new_props} />;

		default:
			// console.log(props);
			return null;
	}
}

export default ModalConductor;