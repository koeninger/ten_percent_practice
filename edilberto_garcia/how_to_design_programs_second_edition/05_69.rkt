;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 05_69) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 69. Draw box representations for the solution of exercise 65.



(define-struct movie [title producer year])

(define-struct person [name hair eyes phone])

(define-struct pet [name number])

(define-struct CD [artist title price])

(define-struct sweater [material size producer])



;                    
;                         |movie|    
;  _____________________________                    
; | title  |producer  | year    |                   
; ______________________________                     
; |        |          |         | 
; |        |          |         |
;  _____________________________               

;                    
;                          |person|    
;  ________________________________                    
; | name  |hair  | eyes |phone    |                   
; _________________________________                     
; |        |     |      |         | 
; |        |     |      |         |
;  _______________________________               
                
;                          |pet|    
;  _____________________________                    
; | name       |number         |                   
; ______________________________                     
; |            |               | 
; |            |               |
;  _____________________________

;                    
;                            |CD|    
;  _____________________________                    
; | artist  |title      |price  |                   
; ______________________________                     
; |         |           |       | 
; |         |           |       |
;  _____________________________               


;                    
;                       |sweater|    
;  _____________________________                    
; | material  |size  | producer |                   
; ______________________________                     
; |           |          |      | 
; |           |          |      |
;  _____________________________   