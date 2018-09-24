(library (rachez string)
         (export string-prefix? string-split build-string)
         (import (chezscheme))

         (define (string-prefix? str pre)
           (define len1 (string-length str))
           (define len2 (string-length pre))
           (cond
             [(> len2 len1) #f]
             [(string=? (substring str 0 len2) pre) #t]
             [else #f]))

         (define (string-split str sep)
           (define len (string-length sep))
           (define (split str acc)
             (cond
               [(string=? str "") (list (list->string (reverse acc)))]
               [(string-prefix? str sep) (cons (list->string (reverse acc))
                                               (split (substring str len
                                                                 (string-length str)) '()))]
               [else (split (substring str 1 (string-length str))
                            (cons (string-ref str 0) acc))]
               ))
           (split str '()))

         (define (build-string n proc)
           (list->string
            (let loop ((s 0))
              (if (>= s n)
                  '()
                  (cons (proc s) (loop (+ s 1)))))))                             
         )
             
