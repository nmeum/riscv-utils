(module riscv ()
  (import scheme (chicken base) (chicken module))

  ;; Decoder procedures
  (export instr-opcode instr-funct3 instr-funct7 instr-rs1
          instr-rs2 instr-rd instr-i-imm instr-s-imm
          instr-b-imm instr-u-imm instr-j-imm)

  ;; Encoder procedures
  (export r-type i-type s-type b-type u-type)

  ;; Converter procedures
  (export from-le from-be to-le to-be)

  (include "riscv/decode.scm")
  (include "riscv/encode.scm")
  (include "riscv/convert.scm"))
