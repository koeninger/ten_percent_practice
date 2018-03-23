const path = require('path');
const fs = require('fs');
const solc = require('solc');

// Get relative path of solidity script
const lottery_path = path.resolve(__dirname, 'contracts', 'Lottery.sol');
const source = fs.readFileSync(lottery_path, 'utf8');

// Compile solidity script
const compiled_contracts = solc.compile(source, 1);
module.exports = compiled_contracts.contracts[':Lottery'];