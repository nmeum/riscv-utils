(import riscv test)
(import (chicken condition))

(define exception-raised #t)
(define-syntax test-exception
  (syntax-rules ()
    ((test-exception body ...)
     (call-with-current-continuation
       (lambda (con)
         (with-exception-handler
           (lambda (e) (con exception-raised))
           (lambda ()
             (begin
              (begin body ...)
              (con (not exception-raised))))))))))

(test-group "encode R-type"
  (test "encode add instruction"
    add-instr
    (r-type (get-opcode 'ADD) (get-funct3 'ADD) (get-funct7 'ADD)
            12 10 11))

  (test "encode add instruction with invalid RD"
    exception-raised
    (test-exception
      (r-type (get-opcode 'ADD) (get-funct3 'ADD) (get-funct7 'ADD) 12 10 42))))

(test-group "encode I-type"
  (test "encode addi instruction"
    addi-instr
    (i-type (get-opcode 'ADDI) (get-funct3 'ADDI) 6 5 42))

  (test "encode addi with negative immediate"
    -23
    (instr-i-imm (i-type (get-opcode 'ADDI) (get-funct3 'ADDI) 6 5 -23)))

  (test "encode addi with invalide immediate"
    exception-raised
    (test-exception
      (i-type (get-opcode 'ADDI) (get-funct3 'ADDI) 6 5 2048))))

(test-group "encode S-type"
  (test "encode sw instruction"
    sw-instr
    (s-type (get-opcode 'SW) (get-funct3 'SW) 9 1 23))

  (test "encode sw instruction with invalid immediate"
    exception-raised
    (test-exception
      (s-type (get-opcode 'SW) (get-funct3 'SW) 9 1 (expt 2 12)))))

(test-group "encode B-type"
  (test "encode beq instruction"
    beq-instr
    (b-type (get-opcode 'BEQ) (get-funct3 'BEQ) 10 11 32))

  (test "encode beq instruction with negative immediate"
    -2048
    (instr-b-imm (b-type (get-opcode 'BEQ) (get-funct3 'BEQ) 10 11 -2048))))

(test-group "encode U-type"
  (test "encode lui instruction"
    lui-instr
    (u-type (get-opcode 'LUI) 28 #xfffff))

  (test "encode lui instruction with invalid immediate"
    exception-raised
    (test-exception
      (u-type (get-opcode 'LUI) 28 (expt 2 20)))))

(test-group "encode J-type"
  (test "encode jal instruction"
    jal-instr
    (j-type (get-opcode 'JAL) 1 32)))
