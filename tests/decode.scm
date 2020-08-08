(import riscv test)

;; Machine code for a given instruction can be obtained
;; easily using: riscv32-unknown-elf-objdump -d <binary>.

;; add x11, x12, x10
(define add-instr #x00a605b3)
;; addi x5, x6, 42
(define addi-instr #x02a30293)
;; sw x1, 23(x9)
(define sw-instr #x0014aba3)
;; lui x28, 0xfffff
(define lui-instr #xfffffe37)
;; beq x10, x11, 32
(define beq-instr #x02b50063)
;; jal ra, 32
(define jal-instr #x020000ef)

(test-group "decode R-type"
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

(test-group "decode I-type"
  (test "parse addi instruction opcode"
    #b0010011
    (instr-opcode addi-instr))

  (test "parse addi instruction rd"
    5
    (instr-rd addi-instr))

  (test "parse addi instruction rs1"
    6
    (instr-rs1 addi-instr))

  (test "parse addi instruction imm"
    42
    (instr-i-imm addi-instr))

  (test "parse addi instruction funct3"
    #b000
    (instr-funct3 addi-instr)))

(test-group "decode S-type"
  (test "parse sw instruction opcode"
    #b0100011
    (instr-opcode sw-instr))

  (test "parse sw instruction rs1"
    9
    (instr-rs1 sw-instr))

  (test "parse sw instruction rs2"
    1
    (instr-rs2 sw-instr))

  (test "parse sw instruction imm"
    23
    (instr-s-imm sw-instr))

  (test "parse sw instruction funct3"
    #b010
    (instr-funct3 sw-instr)))

(test-group "decode U-type"
  (test "parse lui instruction opcode"
    #b0110111
    (instr-opcode lui-instr))

  (test "parse lui instruction rd"
    28
    (instr-rd lui-instr))

  (test "parse lui imm"
    -4096
    (instr-u-imm lui-instr)))

(test-group "decode B-type"
  (test "parse beq instruction opcode"
    #b1100011
    (instr-opcode beq-instr))

  (test "parse beq instruction rs1"
    10
    (instr-rs1 beq-instr))

  (test "parse beq instruction rs2"
    11
    (instr-rs2 beq-instr))

  (test "parse beq instruction imm"
    32
    (instr-b-imm beq-instr))

  (test "parse beq instruction funct3"
    #b000
    (instr-funct3 beq-instr)))

(test-group "decode J-type"
  (test "parse jal instruction opcode"
    #b1101111
    (instr-opcode jal-instr))

  (test "parse jal instruction rd"
    1
    (instr-rd jal-instr))

  (test "parse jal instruction imm"
    32
    (instr-j-imm jal-instr)))
