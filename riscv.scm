(module riscv ()
  (import scheme (chicken base) (chicken module))

  ;; Decoder procedures
  (export instr-opcode instr-funct3 instr-funct7 instr-rs1
          instr-rs2 instr-rd instr-i-imm instr-s-imm
          instr-b-imm instr-u-imm instr-j-imm)

  ;; Encoder procedures
  (export r-type i-type s-type b-type u-type j-type)

  ;; Converter procedures
  (export le->instr be->instr instr->le instr->be)

  ;; Opcode procedures
  (export get-opcode get-funct3 get-funct7)

  (include "riscv/decode.scm")
  (include "riscv/encode.scm")
  (include "riscv/convert.scm")
  (include "riscv/opcodes.scm"))
