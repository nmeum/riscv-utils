(test-group "conversion from functions"
  (test "le->instr"
    lui-instr
    (le->instr lui-instr))

  (test "be->instr"
    lui-instr
    (be->instr #x37feffff)))

(test-group "conversion to functions"
  (test "instr->le"
    beq-instr
    (instr->le beq-instr))

  (test "instr->be"
    beq-instr
    (instr->be #x6300b502)))
