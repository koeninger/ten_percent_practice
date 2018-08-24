Welcome to DrRacket, version 7.0 [3m].
Language: Beginning Student [custom]; memory limit: 128 MB.
Teachpacks: 2htdp/image.rkt and universe.rkt.
> (string-insert "hello" 5)
"hello_"
> (string-insert "hello" 10)
substring: ending index is out of range
  ending index: 10
  starting index: 0
  valid range: [0, 5]
  string: "hello"
> (string-insert "" 1)
substring: ending index is out of range
  ending index: 1
  starting index: 0
  valid range: [0, 0]
  string: ""
> (string-insert "" 0)
"_"
> (string-insert "hello" 3)
"hel_lo"
> 