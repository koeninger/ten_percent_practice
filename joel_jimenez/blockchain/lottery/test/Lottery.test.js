const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');

const provider = ganache.provider();
const web3 = new Web3(provider);
const { interface, bytecode } = require('../compile');

let lottery;
let accounts;

beforeEach(async () => {
	accounts = await web3.eth.getAccounts();
	lottery = await new web3.eth.Contract(JSON.parse(interface))
		.deploy({ data: bytecode })
		.send({ from: accounts[0], gas: '1000000' });
});

describe('Lottery Contract', () => {
	// it('deploys the contract', () => {
	// 	assert.ok(lottery.options.address);
	// });

	// it('allows one player to enter lottery', async () => {
	// 	await lottery.methods.enter().send({
	// 		from: accounts[0],
	// 		value: web3.utils.toWei('0.11', 'ether')
	// 	});

	// 	const players = await lottery.methods.getPlayers().call({
	// 		account: accounts[0]
	// 	});

	// 	assert.equal(accounts[0], players[0]);
	// 	assert.equal(1, players.length);
	// });

	// it('allows multiple player to enter lottery', async () => {
	// 	await lottery.methods.enter().send({
	// 		from: accounts[0],
	// 		value: web3.utils.toWei('0.11', 'ether')
	// 	});
	// 	await lottery.methods.enter().send({
	// 		from: accounts[1],
	// 		value: web3.utils.toWei('0.11', 'ether')
	// 	});
	// 	await lottery.methods.enter().send({
	// 		from: accounts[2],
	// 		value: web3.utils.toWei('0.11', 'ether')
	// 	});

	// 	const players = await lottery.methods.getPlayers().call({
	// 		account: accounts[0]
	// 	});

	// 	assert.equal(accounts[0], players[0]);
	// 	assert.equal(accounts[1], players[1]);
	// 	assert.equal(accounts[2], players[2]);
	// 	assert.equal(3, players.length);
	// });

	// it('requires a minimum amount of ether to enter', async () => {
	// 	try{
	// 		await lottery.methodsenter().send({
	// 			from: accounts[0],
	// 			value: 0
	// 		});
	// 		assert(false);

	// 	} catch(err){
	// 		assert(err);
	// 	}
	// });

	it('allows only manager to pick winner', async () => {
		let pass = false;
		try{
			await lottery.methods.pickWinner().send({
				from: accounts[1]
			});

		} catch(err){
			pass = true;
		}
		assert(pass);
	});

	it('sends money to the winner and resets player array', async () => {
		const manager = await lottery.methods.manager().call();
		const player = accounts[1];

		const before_balance = await web3.eth.getBalance(player);
		await lottery.methods.enter().send({
			from: player,
			value: web3.utils.toWei('1', 'ether')
		});

		await lottery.methods.pickWinner().send({
			from: manager
		});
		const after_balance = await web3.eth.getBalance(player);

		const difference = before_balance - after_balance;
		assert.equal(difference, 1249139999997952);
		
		// // Check that the lottery has no balance after winner is picked
		// const lottery_balance = await lottery.methods.getBalance().call({
		// 	from: manager
		// });
		// console.log(lottery_balance);

		// Check that players array is emptied after winner is picked
		const players = await lottery.methods.getPlayers().call();
		assert.equal(0, players.length);
	});
});