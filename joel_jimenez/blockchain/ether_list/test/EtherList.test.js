const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');

const provider = ganache.provider();
const web3 = new Web3(provider);
const { interface, bytecode } = require('../compile');

let ether_list;
let accounts;
const initial_message = 'Hello, World!';
beforeEach(async () => {
	// Get list of all accounts
	accounts = await web3.eth.getAccounts();

	// Use one account to deploy contract
	ether_list = await new web3.eth.Contract(JSON.parse(interface))
	.deploy({
		data: bytecode,
		arguments: [initial_message]
	})
	.send({
		from: accounts[0],
		gas: '1000000'
	});
});

describe("EtherList", () => {
	// Test that contract was successfully deployed
	it('Deploy contract', () => {
		assert.ok(ether_list.options.address);
	});

	// Test default variable when contract is deployed
	it('Default message', async () => {
		const message = await ether_list.methods.getMessage().call();
		assert.equal(initial_message, message);
	});

	// Test modify variable in contract
	it('Modify message', async () => {
		// Update variable
		const new_message = 'Hello Joel';
		await ether_list.methods.setMessage(new_message).send({
			from: accounts[0]
		});

		// Get variable
		const message = await ether_list.methods.getMessage().call();
		// Compare change
		assert.equal(new_message, message);
	});
})