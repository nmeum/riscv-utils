(import srfi-151)

(define (get-byte value nth)
  (bitwise-and (arithmetic-shift value
                                 (* -1 (* nth 8)))
               #xff))

(define (from-le instr)
  instr)

(define (from-be instr)
  (bitwise-ior
    (arithmetic-shift (get-byte instr 0) 24)
    (arithmetic-shift (get-byte instr 1) 16)
    (arithmetic-shift (get-byte instr 2) 8)
    (get-byte instr 3)))
