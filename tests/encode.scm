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

(test-group "encode r-type"
  (test "encode add instruction"
    add-instr
    (r-type #b0110011 #b000 #b0000000
            12 10 11))

  (test "encode add instruction with invalid RD"
    exception-raised
    (test-exception
      (r-type #b0110011 #b000 #b0000000
              12 10 42))))