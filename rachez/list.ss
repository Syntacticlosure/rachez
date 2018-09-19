(library (rachez list)
         (export build-list check-duplicates remove-duplicates)
         (import (chezscheme))

         (define (build-list n proc)
           (let loop ([s 0])
             (if (>= s n)
                 '()
                 (cons (proc s) (loop (+ s 1))))))

         (define (check-duplicates lst)
           (if (null? lst) #f
               (or (member (car lst)
                           (cdr lst))
                   (check-duplicates (cdr lst)))))

         (define (remove-duplicates lst)
           (define (remove ele lst)
             (cond
               [(null? lst) '()]
               [(equal? ele (car lst)) (remove ele (cdr lst))]
               [else (cons (car lst) (remove ele (cdr lst)))]))
           (if (null? lst)
               '()
               (cons (car lst) (remove-duplicates (remove (car lst) (cdr lst))))))
         )
         