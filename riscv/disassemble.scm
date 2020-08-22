(import srfi-151)

(define (decode-r instr)
  (list
    (cons 'funct7 (instr-funct7 instr))
    (cons 'funct3 (instr-funct3 instr))
    (cons 'rd     (instr-rd instr))
    (cons 'rs1    (instr-rs1 instr))
    (cons 'rs2    (instr-rs2 instr))
  ))

(define (decode-type type instr)
  (let ((decoders (list
          (cons 'rtype decode-r))))
    ;; TODO: Handle invalid types
    ((cdr (assoc type decoders)) instr)))

(define (disassemble instr)
  (let* ((op (instr-opcode instr))
         (type (get-type op)))
    (cons
      (cons 'opcode op)
      (decode-type type instr))))
