(import srfi-151)

(define new-instruction bitwise-ior)
(define (new-field start size value)
  (if (> value (expt 2 (- size 1)))
    (error "given value too large for field"))
    (arithmetic-shift value start))

(define (r-type opcode funct3 funct7
          rs1 rs2 rd)
  ;; TODO: Only pass the size, not the position.
  ;; The position can be infered from size of previous field.
  (new-instruction
    (new-field 25 07 funct7)
    (new-field 20 05 rs2)
    (new-field 15 05 rs1)
    (new-field 12 03 funct3)
    (new-field 07 05 rd)
    (new-field 00 07 opcode)))
