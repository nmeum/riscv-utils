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

(define (from-le instr)
  instr)

(define (from-be instr)
  (byte-swap instr))

(define (to-le instr)
  instr)

(define (to-be instr)
  (byte-swap instr))
