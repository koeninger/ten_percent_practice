// Depoly to the Rinkeby Ethereum network using Infura

const WalletProvider = require('truffle-hdwallet-provider');
const Web3 = require('web3');
const { interface, bytecode } = require('./compile');

const provider = new WalletProvider(
	'asset pumpkin shy fatal exist bar frozen under sand oppose salon sniff',
	'https://rinkeby.infura.io/4uYclcyWpdLVHH0hwyej'
);
const web3 = new Web3(provider);

const deploy = async () => {
	const accounts = await web3.eth.getAccounts();
	console.log('Deploying from account', accounts[0]);

	const result = await new web3.eth.Contract( JSON.parse(interface) )
	.deploy({
		data: bytecode
	}).send({
		from: accounts[0],
		gas: '1000000'
	});
	console.log('Contract deployed to', result.options.address);
};
deploy();