#lang racket
(require 
  "debug.rkt"
  (prefix-in u: "util.rkt"))

(set-textual-debug)
;;(enable-debug! 'ALL)

(define GCC 'avr-gcc)
(define AR 'avr-ar)
(define STRIP 'avr-strip)

;                                                                       
;                                                                       
;                                                                       
;                                                                       
;                                                                       
;                                                                       
;                                                                       
;                                                                       
;   ;;     ;;  ;;;;;;;;  ;;       ;;;;;;;   ;;;;;;;;  ;;;;;;;    ;;;;;  
;   ;;     ;;  ;;        ;;       ;;    ;;  ;;        ;;    ;;  ;;   ;  
;   ;;     ;;  ;;        ;;       ;;     ;  ;;        ;;     ;  ;       
;   ;;     ;;  ;;        ;;       ;;     ;  ;;        ;;     ;; ;       
;   ;;     ;;  ;;        ;;       ;;    ;;  ;;        ;;    ;;  ;;;     
;   ;;;;;;;;;  ;;;;;;;   ;;       ;;;;;;;   ;;;;;;;   ;;;;;;;    ;;;;;  
;   ;;     ;;  ;;        ;;       ;;        ;;        ;;   ;         ;; 
;   ;;     ;;  ;;        ;;       ;;        ;;        ;;   ;;         ; 
;   ;;     ;;  ;;        ;;       ;;        ;;        ;;    ;        ;; 
;   ;;     ;;  ;;        ;;       ;;        ;;        ;;    ;;  ;;  ;;  
;   ;;     ;;  ;;;;;;;;  ;;;;;;;  ;;        ;;;;;;;;  ;;     ;;  ;;;;   
;                                                                       
;                                                                       
;                                                                       
;                                                                       
;                                                                       

(define (system-call prog flags)
  (debug 'SC "~a ~s" prog flags)
  (define parsed (map parse flags))
  (debug 'SC "~s" parsed)
  (define rendered (render parsed))
  (debug 'SC "~s" rendered)
  (define call (format "~a ~a" prog rendered))
  (debug 'SC "~s" call)
  call)


(struct cmd (app args) #:transparent)
(struct arg2 (flag value) #:transparent)
(struct arg1 (flag) #:transparent)
(struct set (param value) #:transparent)
(struct nospace (flag value) #:transparent)

(define (parse sexp)
  (debug 'PARSE "~s" sexp)
  (match sexp
    [`(= ,rand1 ,rand2)
     (debug 'PARSE "SET ~s" sexp)
     (set rand1 rand2)]
    [`(nospace ,flag ,val)
     (nospace flag val)]
    [`(,command ,args ...)
     (debug 'PARSE "CMD ~s" sexp)
     (cmd command (map parse args))]
    ;; FIXME: The list of length two is subsumed by
    ;; the previous rule... unnecessary?
    [`(,flag ,value)
     (arg2 flag value)]
    [flag/value
     (arg1 flag/value)]))


(define (render ast)
  (match ast
    [(? list? ast)
     (apply string-append
            (u:list-intersperse (map render ast) " "))]
    [(struct cmd (command args))
     (format "~a ~a" 
             command
             (apply string-append
                    (u:list-intersperse (map render args) " ")))]
    [(struct set (param value))
     (format "~a=~a" param value)]
    [(struct arg2 (flag value))
     (format "~a ~a" flag value)]
    [(struct arg1 (flag/value))
     (format "~a" flag/value)]
    [(struct nospace (flag value))
     (format "~a~a" flag value)]
    ))

(define (.c str)
  (format "~a.c" str))

(define (.o str)
  (format "~a.o" str))


;                                                                              
;                                                                              
;                                                                              
;                                                                              
;                                                                              
;                                                                              
;                                                                              
;                                                                              
;   ;;;;;;;    ;;     ;;  ;;  ;;       ;;;;;;;     ;;;;;;;;  ;;;;;;;    ;;;;;  
;   ;;    ;;   ;;     ;;  ;;  ;;       ;;    ;;    ;;        ;;    ;;  ;;   ;  
;   ;;     ;   ;;     ;;  ;;  ;;       ;;     ;;   ;;        ;;     ;  ;       
;   ;;     ;   ;;     ;;  ;;  ;;       ;;      ;   ;;        ;;     ;; ;       
;   ;;    ;;   ;;     ;;  ;;  ;;       ;;      ;;  ;;        ;;    ;;  ;;;     
;   ;;;;;;;    ;;     ;;  ;;  ;;       ;;      ;;  ;;;;;;;   ;;;;;;;    ;;;;;  
;   ;;     ;   ;;     ;;  ;;  ;;       ;;      ;;  ;;        ;;   ;         ;; 
;   ;;     ;;  ;;     ;;  ;;  ;;       ;;      ;   ;;        ;;   ;;         ; 
;   ;;     ;;   ;     ;   ;;  ;;       ;;     ;;   ;;        ;;    ;        ;; 
;   ;;    ;;    ;;   ;;   ;;  ;;       ;;    ;;    ;;        ;;    ;;  ;;  ;;  
;   ;;;;;;;       ;;;     ;;  ;;;;;;;  ;;;;;;;     ;;;;;;;;  ;;     ;;  ;;;;   
;                                                                              
;                                                                              
;                                                                              
;                                                                              
;                                                                              

(define (dot-o flags source)
  (system/exit-code
   (system-call
    GCC
    `(,@flags
      -c ,(.c source)))))

;; avr-gcc -mmcu=atmega32u4 -DTVM_WORD_LENGTH=2 -DTVM_INTERNALS -DTVM_DISPATCH_SWITCH -DTVM_EMULATE_T2 -DTVM_LITTLE_ENDIAN -DTVM_MEM_INTF_AVR -DTVM_PACKED_ECTX -DTVM_OS_NONE -DTVM_USE_INLINE -I. -c ins_pri.c

(define (dot-o* flags sources)
  (for ([s sources])
    (dot-o flags s)))

(define (ar name objects)
  (system/exit-code
   (format "~a rcs lib~a.a ~a"
           AR
           name
           (apply string-append
                  (u:list-intersperse (map .o objects) " ")))))
           
(define (library name flags sources)
  (dot-o* flags sources)
  (ar 'tvm sources))  

(define (strip name)
  (system/exit-code
   (format "~a lib~a.a"
           STRIP
           name)))

;                                                 
;                                                 
;                                                 
;                                                 
;                                                 
;                                                 
;                                                 
;                                                 
;   ;;;;;;;    ;;     ;;  ;;  ;;       ;;;;;;;    
;   ;;    ;;   ;;     ;;  ;;  ;;       ;;    ;;   
;   ;;     ;   ;;     ;;  ;;  ;;       ;;     ;;  
;   ;;     ;   ;;     ;;  ;;  ;;       ;;      ;  
;   ;;    ;;   ;;     ;;  ;;  ;;       ;;      ;; 
;   ;;;;;;;    ;;     ;;  ;;  ;;       ;;      ;; 
;   ;;     ;   ;;     ;;  ;;  ;;       ;;      ;; 
;   ;;     ;;  ;;     ;;  ;;  ;;       ;;      ;  
;   ;;     ;;   ;     ;   ;;  ;;       ;;     ;;  
;   ;;    ;;    ;;   ;;   ;;  ;;       ;;    ;;   
;   ;;;;;;;       ;;;     ;;  ;;;;;;;  ;;;;;;;    
;                                                 
;                                                 
;                                                 
;                                                 
;                                                 

(define sources
  '(ins_alt
    ins_barrier
    ins_chan
    ins_float
    ins_mobile
    ins_pi
    ins_pri
    ins_proc
    ins_sec
    ins_rmox
    ins_t9000
    ins_t800
    ins_timer
    instructions
    interpreter
    mem_avr
    mem
    scheduler
    ))

(define build-flags
  `((= -mmcu atmega32u4) (= -DTVM_WORD_LENGTH 2)
                        -DTVM_INTERNALS 
                        -DTVM_DISPATCH_SWITCH 
                        -DTVM_EMULATE_T2 
                        -DTVM_LITTLE_ENDIAN 
                        -DTVM_MEM_INTF_AVR 
                        -DTVM_PACKED_ECTX 
                        -DTVM_OS_NONE 
                        -DTVM_USE_INLINE
                        -I.))

(system/exit-code "python make-dispatch.py *.c")
(library 'tvm build-flags sources)
(strip 'tvm)