(import srfi-151)

;;;;
;; Utility procedures
;;;;

(define (get-elem unit value nth)
  (let ((mask  (- (expt 2 unit) 1))
        (shamt (* -1 (* nth unit))))
    (bitwise-and (arithmetic-shift value shamt) mask)))

(define (get-byte value nth)   (get-elem 8 value nth))
(define (get-nibble value nth) (get-elem 4 value nth))

(define (byte-swap u32)
  (bitwise-ior
    (arithmetic-shift (get-byte u32 0) 24)
    (arithmetic-shift (get-byte u32 1) 16)
    (arithmetic-shift (get-byte u32 2) 8)
    (get-byte u32 3)))

(define (nibble-length number)
  (let* ((bit-length (integer-length number))
         (rem (modulo bit-length 4)))
    (/
      (if (zero? rem)
        bit-length
        (+ (- bit-length rem) 4)) ;; Round to next nibble boundary
      4)))

(define (nibble-fold proc seed number)
  (define (recur n)
    (if (>= n (nibble-length number))
      seed
      (proc (get-nibble number n)
            (recur (+ n 1)))))

  (if (zero? number)
    (proc 0 seed)
    (recur 0)))

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
  (define (bit->string bit)
    (if bit "1" "0"))

  (if (negative? instr)
    (error "not a valid RISC-V instruction")
    (string-append "#b"
      (bitwise-fold (lambda (bit output)
        (string-append (bit->string bit) output)) "" instr))))

(define (instr->hex instr)
  (define (nibble->string nibble)
    (vector-ref #(
      "0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "a" "b" "c" "d" "e" "f"
     ) nibble))

    (if (negative? instr)
      (error "not a valid RISC-V instruction")
      (nibble-fold (lambda (nibble str)
                     (string-append str (nibble->string nibble)))
                 "#x" instr)))
