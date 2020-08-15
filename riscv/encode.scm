(import srfi-151)

;; Wrapper around bit-field to support the imm[end:start]
;; syntax used in the RISC-V specification.
(define (imm-field instr end start)
  (bit-field instr start (+ end 1)))

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
    ((new-instr N (TYPE val siz) fields ...)
     (bitwise-ior
       (new-instr N (TYPE val siz))
       (new-instr (- N siz) fields ...)))))

(define (r-type opcode funct3 funct7
          rs1 rs2 rd)
  (new-instr 32
    (field funct7 7)
    (field rs2 5)
    (field rs1 5)
    (field funct3 3)
    (field rd 5)
    (field opcode 7)))

(define (i-type opcode funct3 rs1 rd imm)
  (let ((imm-signed (to-twocomp 12 imm)))
    (new-instr 32
      (field imm-signed 12)
      (field rs1 5)
      (field funct3 3)
      (field rd 5)
      (field opcode 7))))

(define (s-type opcode funct3 rs1 rs2 imm)
  (let ((imm-signed (to-twocomp 12 imm)))
    (new-instr 32
      (field (imm-field imm-signed 11 5) 7)
      (field rs2 5)
      (field rs1 5)
      (field funct3 3)
      (field (imm-field imm-signed 4 0) 5)
      (field opcode 7))))

(define (u-type opcode rd imm)
  (new-instr 32
    (field imm 20)
    (field rd 5)
    (field opcode 7)))
