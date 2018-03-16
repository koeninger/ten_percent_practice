const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');

const web3 = new Web3(ganache.provider());
const { interface, bytecode } = require('../compile');

let ether_list;
beforeEach(async () => {
	// Get list of all accounts
	const accounts = await web3.eth.getAccounts();

	// Use one account to deploy contract
	ether_list = await new web3.eth.Contract(JSON.parse(interface))
		.deploy({ data: bytecode, arguments: ['Hello, World!'] })
		.send({ from: accounts[0], gas: '1000000' });
});

describe("EtherList", () => {
	it('Deploy contract', () => {
		console.log(ether_list);
	});
})