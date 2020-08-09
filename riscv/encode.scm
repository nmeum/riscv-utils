(import srfi-151)

;; TODO: This would be cleaner without a global variable.
;; Not proficient enough with macros to achieve this though.
(define field-pos 32)
(define-syntax new-instr
  (syntax-rules ()
    ((new-instr body ...)
     (begin
       (set! field-pos 32)
       (bitwise-ior body ...)))))
(define (new-field value size)
  (if (> value (expt 2 (- size 1)))
    (error "given value too large for field")
    (begin
      (set! field-pos (- field-pos size))
      (arithmetic-shift value field-pos))))

(define (r-type opcode funct3 funct7
          rs1 rs2 rd)
  (new-instr
    (new-field funct7 7)
    (new-field rs2 5)
    (new-field rs1 5)
    (new-field funct3 3)
    (new-field rd 5)
    (new-field opcode 7)))

(define (i-type opcode funct3 rs1 rd imm)
  (new-instr
    (new-field imm 12)
    (new-field rs1 5)
    (new-field funct3 3)
    (new-field rd 5)
    (new-field opcode 7)))
