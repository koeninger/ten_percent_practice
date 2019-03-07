Welcome to DrRacket, version 7.0 [3m].
Language: Beginning Student [custom]; memory limit: 128 MB.
Teachpacks: 2htdp/image.rkt, batch-io.rkt, and universe.rkt.
All 123 tests passed!
> (si-main "b" 1)
check-with: the initial expression evaluated to (make-sigs (make-posn "b" 0) (make-tank 1 3) #false), which fails to pass check-with's SIGS? test
> (si-main 2 "b")
check-with: the initial expression evaluated to (make-sigs (make-posn 2 0) (make-tank "b" 3) #false), which fails to pass check-with's SIGS? test
> (si-main 2 2)
(make-sigs (make-posn 179 190) (make-tank 81 3) (make-posn 63 150))
> 