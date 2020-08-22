(test-group "byte order converison"
  (test "le->instr"
    lui-instr
    (le->instr lui-instr))

  (test "be->instr"
    lui-instr
    (be->instr #x37feffff))

  (test "instr->le"
    beq-instr
    (instr->le beq-instr))

  (test "instr->be"
    beq-instr
    (instr->be #x6300b502)))

(test-group "output conversion"
  (test "instr->bin hex"
    "#b100011"
    (instr->bin #x23))

  (test "instr->bin binary"
    "#b111111111111"
    (instr->bin #b111111111111))

  (test "instr->hex with beqi-instr"
    "#x2b50063"
    (instr->hex beq-instr))

  (test "instr->hex with large value"
    "#x2b3f67135a4"
    (instr->hex #x02b3f67135a4))

  (test "instr->hex with zero"
    "#x0"
    (instr->hex 0)))
