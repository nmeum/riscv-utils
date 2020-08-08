(import srfi-151)

(define (new-r-type opcode funct3 funct7
          rs1 rs2 rd)
  (bitwise-ior
    (arithmetic-shift funct7 25)
    (arithmetic-shift rs2 20)
    (arithmetic-shift rs1 15)
    (arithmetic-shift funct3 12)
    (arithmetic-shift rd 7)
    opcode))
