/*
	Compiles both CampaingFactory and Campaign contracts and saves them in a build directory
*/

const path = require('path');
const solc = require('solc');
const fs = require('fs-extra');

// Read in contract file and compile
const campaignPath = path.resolve(__dirname, 'Campaign.sol');
const source = fs.readFileSync(campaignPath, 'utf8');
const output = solc.compile(source, 1).contracts;

// Delete and rebuild build directory
const buildPath = path.resolve(__dirname, 'build');
fs.removeSync(buildPath);
fs.ensureDirSync(buildPath);

// Parse contract output
for (let contract in output) {
	// Parse contract name
	let contractName = contract.replace(':', '') + '.json';

	// Save contract output as JSON inside build directory
	fs.outputJsonSync(
		path.resolve(buildPath, contractName),
		output[contract]
	);
}