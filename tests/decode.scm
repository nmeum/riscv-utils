(test-group "decode R-type"
  (test "parse add instruction opcode"
    (get-opcode 'ADD)
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
    (get-funct3 'ADD)
    (instr-funct3 add-instr))

  (test "parse add instruction func7"
    (get-funct7 'ADD)
    (instr-funct7 add-instr)))

(test-group "decode I-type"
  (test "parse addi instruction opcode"
    (get-opcode 'ADDI)
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
    (get-funct3 'ADDI)
    (instr-funct3 addi-instr)))

(test-group "decode S-type"
  (test "parse sw instruction opcode"
    (get-opcode 'SW)
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
    (get-funct3 'SW)
    (instr-funct3 sw-instr)))

(test-group "decode U-type"
  (test "parse lui instruction opcode"
    (get-opcode 'LUI)
    (instr-opcode lui-instr))

  (test "parse lui instruction rd"
    28
    (instr-rd lui-instr))

  (test "parse lui imm"
    #xfffff
    (instr-u-imm lui-instr)))

(test-group "decode B-type"
  (test "parse beq instruction opcode"
    (get-opcode 'BEQ)
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
    (get-funct3 'BEQ)
    (instr-funct3 beq-instr)))

(test-group "decode J-type"
  (test "parse jal instruction opcode"
    (get-opcode 'JAL)
    (instr-opcode jal-instr))

  (test "parse jal instruction rd"
    1
    (instr-rd jal-instr))

  (test "parse jal instruction imm"
    32
    (instr-j-imm jal-instr)))
