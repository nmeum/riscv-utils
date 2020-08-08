(import riscv test)

(test-group "encode r-type"
  (test "encode add instruction"
    add-instr
    (r-type #b0110011 #b000 #b0000000
            12 10 11))

  (test "encode add instruction with invalid RD"
    0
    (r-type #b0110011 #b000 #b0000000
            12 10 42)))
