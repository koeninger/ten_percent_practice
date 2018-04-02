pragma solidity ^0.4.17;

contract Campaign {
	// Structure that defines a spending request
	struct Requests{
		string description;
		uint value;
		address recipient;
		bool complete;
	}


	address public manager;			// Creator of the campaign
	uint public minimumContribution;// Minimum amount of Wei required to contribute to campaign
	address[] public approvers;		// List of contributors of the campaign
	Request[] private requests;		// List of created spending requests


	// A modifier to be added to functions that only the manager should have access to
	modifier restricted() {
		require(msg.manager == manager);
		_;
	}


	// Constructor that initiates a campaign
	function Campaign(uint minimum) public {
		manager = msg.sender;
		minimumContribution = minimum;
	}

	// Allows users to contribute to campaign if enough ether is sent
	function contribute() public payable {
		// The contribution must be greater than minimumContribution
		require(msg.value > minimumContribution);
		// Store contributors address
		approvers.push(msg.sender);
	}

	// Creates a spending request (restricted to managers only)
	function createRequest(string description, uint value, address recipient) public restricted {
		// New spending request from manager
		Request newRequest = Request({
			description: description,
			value: value,
			recipient: recipient,
			complete: false
		});
		// Store new request
		requests.push(newRequest);
	}

	// Returns a list of the current contributor's address
	function getApprovers() public view returns (address[]) {
		return approvers;
	}
}