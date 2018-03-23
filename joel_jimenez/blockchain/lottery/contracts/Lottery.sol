pragma solidity ^0.4.17;

contract Lottery {
	address public manager;
	address[] public players;

	function Lottery() public {
		manager = msg.sender;
	}

	function enter() public payable {
		// Set a required amount of ether to enter lottery 
		require(msg.value > .01 ether);
		// Add player to array
		players.push(msg.sender);
	}

	function pickWinner() public restricted {
		uint index = random() % 3;
		// "randomly" chose a player in the array and give them all the ether
		players[index].transfer(this.balance);

		// Empty players array to reset game
		players = new address[](0);
	}

	function getPlayers() public view returns (address[]) {
		return players;
	}

	function random() private view returns (uint) {
		// Generate a pseudo random number
		return uint( keccak256(block.difficulty, now, players) );
	}

	modifier restricted() {
		// Add restricted to functions that only a manager can run
		require(msg.sender == manager);
		_;
	}
}