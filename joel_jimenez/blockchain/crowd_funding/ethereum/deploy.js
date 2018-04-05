const HDWalletProvider = require('truffle-hdwallet-provider');
const Web3 = require('web3');
const CampaignFactory = require('./build/CampaignFactory.json');

const provider = new HDWalletProvider(
	'asset pumpkin shy fatal exist bar frozen under sand oppose salon sniff',
	'https://rinkeby.infura.io/4uYclcyWpdLVHH0hwyej'
);
const web3 = new Web3(provider);

const deploy = async () => {
	const accounts = await web3.eth.getAccounts();
	console.log("Deploying contract from account ", accounts[0]);

	result = await new web3.eth.Contract(
		JSON.parse(CampaignFactory.interface)
	).deploy({
		data: CampaignFactory.bytecode
	}).send({
		from: accounts[0],
		gas: '1000000'
	});
	console.log("Contract has been deployed to " + result.options.address);
};
deploy();

// 1: 0x98E0A3dFdf02AcDf6D03F23090a2e8Baba8f97de