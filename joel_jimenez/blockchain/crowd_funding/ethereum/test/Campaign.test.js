const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');

const web3 = new Web3( ganache.provider() );
const compiledFactory = require('../build/CampaignFactory.json');
const compiledCampaign = require('../build/Campaign.json');

let accounts;
let factory;
let campaignAddress;
let campaign;

beforeEach(async () => {
	// Get test accounts from web3 using ganache provider
	accounts = await web3.eth.getAccounts();

	// Deploy CampaignFactory with web3 using ganache provider
	factory = await new web3.eth.Contract(
		JSON.parse(compiledFactory.interface)
	).deploy({
		data: compiledFactory.bytecode
	}).send({
		from: accounts[0],
		gas: '3000000'
	});

	// Create a new campaign using CampaignFactory
	await factory.methods.createCampaign(100,"Test campaign").send({
		from: accounts[0],
		gas: '1000000'
	});

	// Get first campaign
	campaign = await factory.methods.campaigns(0).call();

	// Pull created campaign into web3
	campaign = await new web3.eth.Contract(
		JSON.parse(compiledCampaign.interface),
		campaign[0]
	);
});

describe('Campaigns', () => {
	it('deploys a factory and a campaign', () => {
		assert.ok(factory.options.address);
		assert.ok(campaign.options.address);
	});

	it('checks that manager is the creator of campaign', async () => {
		const manager = await campaign.methods.manager().call();
		assert.equal(accounts[0], manager);
	});

	it('allows users to contribute and marks them as approvers', async () => {
		await campaign.methods.contribute().send({
			value: '100',
			from: accounts[1]
		});
		const isApprover = await campaign.methods.approvers(accounts[1]).call();
		assert(isApprover);
	});

	it('requires a minimum contribution', async () => {
		let pass = false;
		try{
			await campaign.methods.contribute().send({
				value: '0',
				from: accounts[1]
			});
		} catch (err) {
			pass = true;
		}
		assert(pass);
	});

	it('allows manager to make a payment request', async () => {
		const desc = "Test payment request";

		await campaign.methods.createRequest(desc, '100', accounts[2]).send({
			from: accounts[0],
			gas: '1000000'
		});

		const request = await campaign.methods.requests(0).call();
		assert.equal(desc, request.requestDescription);
	});

	it('proccess requests', async () => {
		await campaign.methods.contribute().send({
			value: web3.utils.toWei('10', 'ether'),
			from: accounts[1]
		});

		await campaign.methods.createRequest('Test proccess request', web3.utils.toWei('5', 'ether'), accounts[2]).send({
			from: accounts[0],
			gas: '1000000'
		});

		await campaign.methods.approveRequest(0).send({
			from: accounts[1],
			gas: '1000000'
		});

		await campaign.methods.finalizeRequest(0).send({
			from: accounts[0],
			gass: '100000'
		});

		let balance = await web3.eth.getBalance(accounts[2]);
		balance = web3.utils.fromWei(balance, 'ether');
		balance = parseFloat(balance);
		assert(balance == 105);
	});

	it('prevents payment requests without approvals to be finalized', async () => {
		await campaign.methods.contribute().send({
			value: web3.utils.toWei('10', 'ether'),
			from: accounts[1]
		});

		await campaign.methods.createRequest('Test payment requests without approvals', web3.utils.toWei('5', 'ether'), accounts[2]).send({
			from: accounts[0],
			gas: '1000000'
		});

		let pass = false;
		try{
			await campaign.methods.finalizeRequest(0).send({
				from: accounts[0],
				gass: '1000000'
			});
		} catch(err){
			pass = true;
		}
		assert(pass);
	});

	it('prevents users who have not contributed to approve requests', async () => {
		await campaign.methods.createRequest('Test payment requests without approvals', web3.utils.toWei('5', 'ether'), accounts[2]).send({
			from: accounts[0],
			gas: '1000000'
		});

		let pass = false;
		try{
			await campaign.methods.approveRequest(0).send({
				from: accounts[1],
				gas: '1000000'
			});
		} catch(err){
			pass = true;
		}
		assert(pass);
	});

	it('checks that summary of campaign is available', async () => {
		const campaignSummary = await campaign.methods.getSummary().call();
		
		assert(campaignSummary[0]);
		assert(campaignSummary[1]);
		assert(campaignSummary[2]);
		assert(campaignSummary[3]);
		assert(campaignSummary[4]);
		assert(campaignSummary[5]);
	});

	it('checks that summary of campaign is available', async () => {
		const campaignSummary = await campaign.methods.getSummary().call();
		
		assert(campaignSummary[0]);
		assert(campaignSummary[1]);
		assert(campaignSummary[2]);
		assert(campaignSummary[3]);
		assert(campaignSummary[4]);
		assert(campaignSummary[5]);
	});

	it('checks that contributor has approved campaign', async () => {
		await campaign.methods.contribute().send({
			value: web3.utils.toWei('10', 'ether'),
			from: accounts[1]
		});

		await campaign.methods.createRequest('Test payment requests approvals', web3.utils.toWei('5', 'ether'), accounts[2]).send({
			from: accounts[0],
			gas: '1000000'
		});

		await campaign.methods.approveRequest(0).send({
			from: accounts[1],
			gas: '1000000'
		});

		const isApproved = await campaign.methods.isContributorApprover(0, accounts[1]).call();
		console.log(isApproved);
		assert(isApproved);
	});
});