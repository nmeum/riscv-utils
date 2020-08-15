(import srfi-151)

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
