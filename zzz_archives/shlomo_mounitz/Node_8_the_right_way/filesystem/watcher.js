'use strict'
const fs = require('fs')
const spawn = require('child_process').spawn;

const program = require('commander');

program
  .version('0.1.0')
  .option('-t, --target', 'target to watch')
  .option('-c, --command', 'commnad to run')
  .parse(process.argv);

if (!program.target) {
    throw Error('Missing target arg');
}
console.log(program.target);
fs.watch(program.target, () => {
    const cmd = spawn(program.command, [program.command]);
    let output = '';
    cmd.stdout.on('data', chunk => output += chunk);
    cmd.on('close', () => {
        console.log(output);
    });
    cmd.stdout.pipe(process.stdout);
});
console.log('Now watching file for changes...');


