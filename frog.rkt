#lang frog/config

;; Called early when Frog launches. Use this to set parameters defined
;; in frog/params.
(define/contract (init)
  (-> any)
  (current-scheme/host "http://people.cs.umass.edu/rnigam")
  (current-title "Strongly Untyped")
  (current-author "Rachit Nigam"))

;; Called once per post and non-post page, on the contents.
(define/contract (enhance-body xs)
  (-> (listof xexpr/c) (listof xexpr/c))
  ;; Here we pass the xexprs through a series of functions.
  (~> xs
      (syntax-highlight #:python-executable "python"
                        #:line-numbers? #t
                        #:css-class "source")))

;; Called from `raco frog --clean`.
(define/contract (clean)
  (-> any)
  (void))

(current-posts-index-uri "/blog.html")
