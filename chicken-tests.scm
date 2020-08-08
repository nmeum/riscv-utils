(import srfi-151 test)

;; add a1, a2, a0
(define add-instr #x00a605b3)

;; Machine code for a given instruction can be obtained
;; easily using: riscv32-unknown-elf-objdump -d <binary>.
(include "decode.scm")
(test-group "decode"
  (test "parse add instruction opcode"
    #b0110011
    (instr-opcode add-instr))

  (test "parse add instruction rd"
    11
    (instr-rd add-instr))

  (test "parse add instruction rs1"
    12
    (instr-rs1 add-instr))

  (test "parse add instruction rs2"
    10
    (instr-rs2 add-instr))

  (test "parse add instruction func3"
    #b000
    (instr-funct3 add-instr))

  (test "parse add instruction func7"
    #b0000000
    (instr-funct7 add-instr)))
