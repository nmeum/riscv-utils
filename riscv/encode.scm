(import srfi-151)

;; Wrapper around bit-field to support the imm[end:start]
;; syntax used in the RISC-V specification.
(define (imm-field instr end start)
  (bit-field instr start (+ end 1)))

(define (to-twocomp value size)
  (let ((max (/ (expt 2 size) 2)))
    (if (or (>= value max)
            (< value (* -1 max)))
      (error "given signed value too large for field")
      (if (negative? value)
        (+ (expt 2 size) value)
        value))))

(define signed-field to-twocomp)
(define (unsigned-field value size)
  (if (> value (- (expt 2 size) 1))
    (error "given value too large for field")
    value))

(define (new-field value position)
  (arithmetic-shift value position))

(define-syntax new-instr
  (syntax-rules (field field-signed)
    ((new-instr N (field val siz))
     (new-field (unsigned-field val siz) (- N siz)))
    ((new-instr N (field-signed val siz))
     (new-field (signed-field val siz) (- N siz)))
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
  (new-instr 32
    (field-signed imm 12)
    (field rs1 5)
    (field funct3 3)
    (field rd 5)
    (field opcode 7)))

(define (s-type opcode funct3 rs1 rs2 imm)
  (if (>= imm (expt 2 12))
    (error "immediate exceeds maximum value")
    (new-instr 32
      (field-signed (imm-field imm 11 5) 7)
      (field rs2 5)
      (field rs1 5)
      (field funct3 3)
      (field (imm-field imm 4 0) 5)
      (field opcode 7))))
