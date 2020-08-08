(import riscv test)

;; Test data, used by the test cases
(include-relative "testdata.scm")

;; Include test cases
(test-group "decoder"
  (include-relative "decode.scm"))
