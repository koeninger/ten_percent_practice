# [How to Design Programs, Second Edition](https://htdp.org/2018-01-06/Book/index.html)
## Install Racket
```
sudo add-apt-repository ppa:plt/racket
sudo apt update && sudo apt install racket
```
## CLI Racket
```
$ racket
> (println "Hello, World!")
> (exit)
```
## Run Racket file
helloworld.rkt
```
#! /usr/local/bin/racket
#lang racket
(println "Hello, World!")
```
Run .rkt from command line
```
racket helloworld.rkt
```
