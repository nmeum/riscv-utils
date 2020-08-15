(test-group "conversion from functions"
  (test "from-le"
    lui-instr
    (from-le lui-instr))

  (test "from-be"
    lui-instr
    (from-be #x37feffff)))
