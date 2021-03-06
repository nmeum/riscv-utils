(import srfi-151)

;; Size of instruction in bits.
;; XXX: Compressed instructions currently not supported.
(define INSTR_SIZE 32)

;; Wrapper around bit-field to support the imm[end:start]
;; syntax used in the RISC-V specification.
(define (imm-field instr end start)
  (bit-field instr start (+ end 1)))
(define (imm-field-single instr pos)
  (imm-field instr pos pos))

(define (to-twocomp numbits input)
  (let ((max (/ (expt 2 numbits) 2)))
    (if (or (>= input max)
            (< input (* -1 max)))
      (error "given signed value too large for field")
      (if (negative? input)
        (+ (expt 2 numbits) input)
        input))))

(define (new-field value size position)
  (if (> value (- (expt 2 size) 1))
    (error "given value too large for field")
    (arithmetic-shift value position)))

(define-syntax new-instr
  (syntax-rules (field)
    ((new-instr N (field val siz))
     (new-field val siz (- N siz)))
    ((new-instr N (field val siz) fields ...)
     (bitwise-ior
       (new-instr N (field val siz))
       (new-instr (- N siz) fields ...)))))

(define (r-type opcode funct3 funct7
          rs1 rs2 rd)
  (new-instr INSTR_SIZE
    (field funct7 7)
    (field rs2 5)
    (field rs1 5)
    (field funct3 3)
    (field rd 5)
    (field opcode 7)))

(define (i-type opcode funct3 rs1 rd imm)
  (let ((imm-signed (to-twocomp 12 imm)))
    (new-instr INSTR_SIZE
      (field imm-signed 12)
      (field rs1 5)
      (field funct3 3)
      (field rd 5)
      (field opcode 7))))

(define (s-type opcode funct3 rs1 rs2 imm)
  (let ((imm-signed (to-twocomp 12 imm)))
    (new-instr INSTR_SIZE
      (field (imm-field imm-signed 11 5) 7)
      (field rs2 5)
      (field rs1 5)
      (field funct3 3)
      (field (imm-field imm-signed 4 0) 5)
      (field opcode 7))))

(define (b-type opcode funct3 rs1 rs2 imm)
  (let ((imm-signed (to-twocomp 12 imm)))
    (new-instr INSTR_SIZE
      (field (imm-field-single imm-signed 12) 1)
      (field (imm-field imm-signed 10 5) 6)
      (field rs2 5)
      (field rs1 5)
      (field funct3 3)
      (field (imm-field imm-signed 4 1) 4)
      (field (imm-field-single imm-signed 11) 1)
      (field opcode 7))))

(define (u-type opcode rd imm)
  (new-instr INSTR_SIZE
    (field imm 20)
    (field rd 5)
    (field opcode 7)))

(define (j-type opcode rd imm)
  (new-instr INSTR_SIZE
    (field (imm-field-single imm 20) 1)
    (field (imm-field imm 10 1) 10)
    (field (imm-field-single imm 11) 1)
    (field (imm-field imm 19 12) 8)
    (field rd 5)
    (field opcode 7)))
