(import srfi-151)

(define (instr-opcode instr)
  (bit-field instr 0 6))

(define (instr-funct3 instr)
  (bit-field instr 12 14))

(define (instr-funct7 instr)
  (bit-field instr 25 31))

(define (instr-rs1 instr)
  (bit-field instr 15 19))

(define (instr-rs2 instr)
  (bit-field instr 20 24))

(define (instr-rd instr)
  (bit-field instr 7 11))

(define (instr-i-imm instr)
  (bit-field instr 20 31))
