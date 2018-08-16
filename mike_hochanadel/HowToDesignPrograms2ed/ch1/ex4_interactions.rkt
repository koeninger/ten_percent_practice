Welcome to DrRacket, version 7.0 [3m].
Language: Beginning Student [custom]; memory limit: 128 MB.
Teachpacks: 2htdp/image.rkt and universe.rkt.
> (delete_hello str i)
"hellworld"
> delete_hello(str 0)
delete_hello: expected a function call, but there is no open parenthesis before this function
> (delete_hello(str 0))
delete_hello: expects 2 arguments, but found only 1
> (delete_hello str 0)
substring: expects an exact-nonnegative-integer as 3rd argument, given -1
> (delete_hello str 11)
substring: starting index is out of range
  starting index: 11
  valid range: [0, 10]
  string: "helloworld"
> (delete_hello str 8)
"hellowold"
> 