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
    (r-type #b0110011 #b000 #b0000000
            12 10 11))

  (test "encode add instruction with invalid RD"
    exception-raised
    (test-exception
      (r-type #b0110011 #b000 #b0000000 12 10 42))))

(test-group "encode I-type"
  (test "encode addi instruction"
    addi-instr
    (i-type #b0010011 #b000 6 5 42))

  (test "encode addi with negative immediate"
    -23
    (instr-i-imm (i-type #b0010011 #b000 6 5 -23)))

  (test "encode addi with invalide immediate"
    exception-raised
    (test-exception
      (i-type #b0010011 #b000 6 5 2048))))

(test-group "encode S-type"
  (test "encode sw instruction"
    sw-instr
    (s-type #b0100011 #b010 9 1 23))

  (test "encode sw instruction with invalid immediate"
    exception-raised
    (test-exception
      (s-type #b0100011 #b010 9 1 (expt 2 12)))))

(test-group "encode B-type"
  (test "encode beq instruction"
    beq-instr
    (b-type #b1100011 #b000 10 11 32))

  (test "encode beq instruction with negative immediate"
    -2048
    (instr-b-imm (b-type #b1100011 #b000 10 11 -2048))))

(test-group "encode U-type"
  (test "encode lui instruction"
    lui-instr
    (u-type #b0110111 28 #xfffff))

  (test "encode lui instruction with invalid immediate"
    exception-raised
    (test-exception
      (u-type #b0110111 28 (expt 2 20)))))
