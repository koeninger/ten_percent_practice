//Exercise 1
(sqrt (+ (* x x) (* y y)))

//Exercise 2
(string-append prefix "_" suffix)

//Exercise 3
(string-append (substring str 0 i) "_" (substring str i (string-length str)))

//Exercise 4
(string-append (substring str 0 (- i 1)) (substring str i (string-length str)))

//Exercise 5
(overlay/offset
   (triangle 20 "solid" "green")
   0 18
   (rectangle 10 20 "solid" "brown"))
   
 //Exercise 6
 (* (image-width cat) (image-height cat))
 
 //Exercise 7
 (or (not sunny) friday)
 
 //Exercise 8
 (if (> (image-height cat) (image-width cat)) "tall"
      (if (> (image-width cat) (image-height cat)) "wide"
      "square"))
      
//Exercise 9
(if (string? in) (string-length in)
      (if (image? in) (* (image-height in) (image-width in))
          (if (number? in) (if (> 0 in) (- in 1) in)
              (if (boolean? in) (if in 10 20) false))))
              
//Exercise 11
(define (distance-to-origin x y)
  (sqrt (+ (* x x) (* y y))))

//Exercise 12
(define (cvolume l)
  (* l l l))
  
 (define (csurface l)
  (* 6 (* l l)))
  
 //Exercise 13
 (define (string-first s)
  (if (and (string? s) (> (string-length s) 0))
      (substring s 0 1)
      ""))

//Exercise 14
(define (string-last s)
  (if (and (string? s) (> (string-length s) 0))
      (substring s (- (string-length s) 1) (string-length s))
      ""))

//Exercise 15
(define (==> sunny friday)
  (or (not sunny) friday))
  
//Exercise 16
(define (image-area img)
  (* (image-width img) (image-height img)))

//Exercise 17
(define (image-classify img)
   (if (> (image-height img) (image-width img)) "tall"
      (if (> (image-width img) (image-height img)) "wide"
      "square")))
      
//Exercise 18
(define (string-join prefix suffix)
  (string-append prefix "_" suffix))
  
//Exercise 19
(define (string-insert str i)
  (string-append (substring str 0 i) "_" (substring str i (string-length str))))
  
//Exercise 20
(define (string-delete str i)
  (string-append (substring str 0 (- i 1)) (substring str i (string-length str))))
