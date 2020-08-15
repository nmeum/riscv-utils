(import srfi-151)

(define (get-byte value nth)
  (bitwise-and (arithmetic-shift value
                                 (* -1 (* nth 8)))
               #xff))

(define (from-le instr)
  instr)

(define (from-be instr)
  (bitwise-ior
    (arithmetic-shift (get-byte instr 1) 8)
    (get-byte instr 0)))
