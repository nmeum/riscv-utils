(import riscv test)

;; Test data, used by the test cases
(include-relative "testdata.scm")

;; Include test cases
(test-group "decode"
  (include-relative "decode.scm"))
(test-group "encode"
  (include-relative "encode.scm"))
