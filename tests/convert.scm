(test-group "conversion from functions"
  (test "from-le"
    lui-instr
    (from-le lui-instr))

  (test "from-be"
    lui-instr
    (from-be #x37feffff)))

(test-group "conversion to functions"
  (test "to-le"
    beq-instr
    (to-le beq-instr))

  (test "to-be"
    beq-instr
    (to-be #x6300b502)))
