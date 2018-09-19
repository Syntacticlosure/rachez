(library (rachez for)
         (export in-list in-vector in-alist for <-
                 for/sum for/list)
         (import (chezscheme))

         (define-syntax in-list (syntax-rules ()))
         (define-syntax in-vector (syntax-rules ()))
         (define-syntax in-alist (syntax-rules ()))
         (define-syntax <- (syntax-rules ()))
         (define-syntax for
           (syntax-rules (in-list in-vector in-alist <-)
             [(_ var <- (in-list val) block ...)
              (let loop ((lst val))
                (if (null? lst)
                    (void)
                    (let ([var (car lst)])
                      block ...
                      (loop (cdr lst)))))]
             [(_ var <- (in-vector val) block ...)
              (let loop ((pos 0))
                (if (>= pos (vector-length val))
                    (void)
                    (let ([var (vector-ref val pos)])
                      block ...
                      (loop (+ pos 1)))))]
             [(_ (key val) <- (in-alist alist) block ...)
              (let loop ((pos alist))
                (if (null? pos)
                    (void)
                    (let ([key (car (car pos))]
                          [val (cdr (car pos))]
                          )
                      block ...
                      (loop (cdr pos)))))]
             ))

         (define-syntax for/sum
           (syntax-rules (<-)
             [(_ matcher <- val do ...)
              (let ([acc 0])
                (for matcher <- val
                  (set! acc (+ acc (let ()
                                     do ...))))
                acc)]
              ))

         (define-syntax for/list
           (syntax-rules (<-)
             [(_ matcher <- val do ...)
              (let ([acc '()])
                (for matcher <- val
                  (set! acc (cons (let () do ...) acc)))
                (reverse acc))]))
              
                 
         )