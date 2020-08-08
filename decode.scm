(import srfi-151)

;; The instr-field function from SRFI-151 returns a bit field in the
;; interval [start, end - 1]. Contrary to bit, this function returns a
;; field in the interval [start, end] to allow using the same
;; instruction indices as specified by the RISC-V specification.
(define (instr-field instr start end)
  (bit-field instr start (+ end 1)))

(define (instr-opcode instr)
  (instr-field instr 0 6))

(define (instr-funct3 instr)
  (instr-field instr 12 14))

(define (instr-funct7 instr)
  (instr-field instr 25 31))

(define (instr-rs1 instr)
  (instr-field instr 15 19))

(define (instr-rs2 instr)
  (instr-field instr 20 24))

(define (instr-rd instr)
  (instr-field instr 7 11))

(define (instr-i-imm instr)
  (instr-field instr 20 31))

(define (instr-s-imm instr)
  (bitwise-ior
    (arithmetic-shift (instr-field instr 25 31) 5)
    (instr-field instr 7 11)))

(define (instr-b-imm instr)
  (bitwise-ior
    (arithmetic-shift (instr-field instr 31 31) 12)
    (arithmetic-shift (instr-field instr 7 7) 11)
    (arithmetic-shift (bit-field instr 25 30) 5)
    (arithmetic-shift (instr-field instr 8 11) 1)))

(define (instr-u-imm instr)
  (instr-field instr 12 31))
