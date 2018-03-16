const path = require('path');
const fs = require('fs');
const solc = require('solc');

// Get relative path of solidity script
const ether_path = path.resolve(__dirname, 'contracts', 'EtherList.sol');
const source = fs.readFileSync(ether_path, 'utf8');

// Compile solidity script
module.exports = solc.compile(source, 1).constracts['EtherList'];