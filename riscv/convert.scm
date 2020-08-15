(import srfi-151)

;;;;
;; Utility procedures
;;;;

(define (get-byte value nth)
  (bitwise-and (arithmetic-shift value
                                 (* -1 (* nth 8)))
               #xff))

(define (byte-swap u32)
  (bitwise-ior
    (arithmetic-shift (get-byte u32 0) 24)
    (arithmetic-shift (get-byte u32 1) 16)
    (arithmetic-shift (get-byte u32 2) 8)
    (get-byte u32 3)))

(define (byte-length number)
  (let* ((bit-length (integer-length number))
         (rem (modulo bit-length 8)))
    (/
      (if (zero? rem)
        bit-length
        (+ (- bit-length rem) 8))
      8)))

(define (byte-fold proc seed number)
  (define (recur n)
     (if (>= n (byte-length number))
       seed
       (proc (get-byte number n)
             (recur (+ n 1)))))

  (recur 0))

;;;;
;; Byte order conversion
;;;;

(define (le->instr instr)
  instr)

(define (be->instr instr)
  (byte-swap instr))

(define (instr->le instr)
  instr)

(define (instr->be instr)
  (byte-swap instr))

;;;;
;; Output format conversion
;;;;

(define (instr->bin instr)
  (string-append "#b"
    (bitwise-fold (lambda (bit output)
      (string-append (if bit "1" "0") output)) "" instr)))

(define (instr->hex instr)
  (let ((chars #("0" "1" "2" "3" "4" "5" "6" "7" "8" "9"
                 "a" "b" "c" "d" "e" "f")))
    ;; TODO: Leading zeros are not stripped currently
    (byte-fold (lambda (digit str)
                 (string-append
                   str
                   (vector-ref chars (arithmetic-shift digit -4))
                   (vector-ref chars (bitwise-and digit #x0f))))
               "#x" instr)))
