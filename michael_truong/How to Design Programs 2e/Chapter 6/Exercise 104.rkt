#lang racket

(define-struct autombile [passengers license-plate fuel-consumption])
(define-struct van [passengers license-plate fuel-consumption])
(define-struct bus [passengers license-plate fuel-consumption])
(define-struct SUV [passengers license-plate fuel-consumption])

(define (function-template vehicle)
  (cond
    [(autombile? vehicle) 0]
    [(van? vehicle) 0]
    [(bus? vehicle) 0]
    [(SUV? vehicle) 0]
    [else 0]))