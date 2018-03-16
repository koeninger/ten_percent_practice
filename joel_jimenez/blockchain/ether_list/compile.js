const path = require('path');
const fs = require('fs');
const solc = require('solc');

// Get relative path of solidity script
const ether_path = path.resolve(__dirname, 'contracts', 'EtherList.sol');
const source = fs.readFileSync(ether_path, 'utf8');

// Compile solidity script
const compiled_contracts = solc.compile(source, 1);
module.exports = compiled_contracts.contracts[':EtherList'];