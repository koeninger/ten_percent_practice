import React from 'react';

const UserOutput = (props) => {
	return (
		<div>
			<p>User Output:</p>
			<p>{props.username}</p>
		</div>
	);
};

export default UserOutput;