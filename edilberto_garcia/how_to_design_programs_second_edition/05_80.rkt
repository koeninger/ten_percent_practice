;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 05_80) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 80. Create templates for functions that consume instances of the following structure types:
(require 2htdp/batch-io)

(define-struct movie [title director year])
    (define (print-title Movie) (write-file 'stdout (movie-title Movie)))

(define-struct pet [name number])
    (define (print-name Pet) (write-file 'stdout (pet-name Pet)))

(define-struct CD [artist title price])
    (define (print-album CD) (write-file 'stdout (CD-title CD)))

(define-struct sweater [material size color])
    (define (print-sweater Sweater) (write-file 'stdout (sweater-material Sweater)))