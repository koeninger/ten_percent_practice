var a = 2;

{
	let a = 3;
	console.log( a );	// 3
}

console.log( a );		// 2

var funcs = [];

for (let i = 0; i < 5; i++) {
	funcs.push( function(){
		console.log( i );
	} );
}

funcs[3]();		// 3