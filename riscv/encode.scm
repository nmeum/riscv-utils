(import srfi-151)

(define (to-twocomp value size)
  (let ((max (/ (expt 2 size) 2)))
    (if (or (>= value max)
            (< value (* -1 max)))
      (error "given signed value too large for field")
      (if (negative? value)
        (+ (expt 2 size) value)
        value))))

(define (new-field value position size)
  (if (> value (- (expt 2 size) 1))
    (error "given value too large for field")
    (begin
      (arithmetic-shift value position))))

(define-syntax new-instr
  (syntax-rules ()
    ((new-instr N (var siz))
     (new-field var (- N siz) siz))
    ((new-instr N (var siz) fields ...)
     (bitwise-ior
       (new-instr N (var siz))
       (new-instr (- N siz) fields ...)))))

(define (r-type opcode funct3 funct7
          rs1 rs2 rd)
  (new-instr 32
    (funct7 7)
    (rs2 5)
    (rs1 5)
    (funct3 3)
    (rd 5)
    (opcode 7)))

(define (i-type opcode funct3 rs1 rd imm)
  (new-instr 32
    (imm 12)
    (rs1 5)
    (funct3 3)
    (rd 5)
    (opcode 7)))
