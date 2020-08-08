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
