import React from 'react';

const Validation = (props) => {
	let message = "Text long enough";
	
	if(props.text.length < 5){
		message = "Text too short";
	}

	return (
		<p>{message}</p>
	);
};

export default Validation;