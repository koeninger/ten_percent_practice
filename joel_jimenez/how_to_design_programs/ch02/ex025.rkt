#! /usr/local/bin/racket
#lang racket

(require 2htdp/image)

(define (image-classify-old img)
  (cond
    [(>= (image-height img) (image-width img)) "tall"]
    [(= (image-height img) (image-width img)) "square"]
    [(<= (image-height img) (image-width img)) "wide"]))

(define (image-classify img)
  (cond
    [(> (image-height img) (image-width img)) "tall"]
    [(= (image-height img) (image-width img)) "square"]
    [(< (image-height img) (image-width img)) "wide"]))

(image-classify-old (rectangle 10 20 "solid" "blue"))
(image-classify-old (rectangle 15 15 "solid" "green"))
(image-classify-old (rectangle 20 10 "solid" "red"))

(image-classify (rectangle 10 20 "solid" "blue"))
(image-classify (rectangle 15 15 "solid" "green"))
(image-classify (rectangle 20 10 "solid" "red"))
