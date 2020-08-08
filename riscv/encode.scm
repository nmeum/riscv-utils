(import srfi-151)

(define new-instruction bitwise-ior)
(define (new-field startpos value)
  (arithmetic-shift value startpos))

(define (r-type opcode funct3 funct7
          rs1 rs2 rd)
  (new-instruction
    (new-field 25 funct7)
    (new-field 20 rs2)
    (new-field 15 rs1)
    (new-field 12 funct3)
    (new-field 07 rd)
    opcode))
