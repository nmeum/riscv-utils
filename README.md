# riscv-utils

Scheme utility procedures for the [RISC-V][riscv website] instruction set architecture.

## Features

The feature set of provided procedures is centered around easing the
development of utilities for RISC-V (especially instruction set
simulators). Currently the following features are provided:

* `decode.scm`: Decoding of RISC-V instructions.
* `encode.scm`: Encoding of RISC-V instructions.
* `convert.scm`: Conversion from/to different representations.
* `opcodes.scm`: Constants for instruction opcodes (currently rv32i only).

## Usage

The code is supposed to be used from a Scheme REPL, no binaries are
provided. The Scheme files in the `riscv/` directory are mostly(?)
[R7RS][r7rs small] compatible. It should be possible to use them with any
standard compliant Scheme implementation which provides an
[SRFI-151][srfi-151] module. Just load the files you want to use
using `(load "riscv/<file>.scm")` from your Scheme REPL.

If your favorite Scheme implementation is [CHICKEN][call-cc], read on.

## Example

The API is intentionally very low-level. Nonetheless, many fun things
can be done with it. The following example takes an existing `JAL`
instruction (e.g. as extracted from a `riscv32-unknown-elf-objdump -d`
output) and modifies it to jump somewhere else.

	$ csi
	> (import riscv)
	> (set! jal #x0100056f)
	> (instr-j-imm jal)
	16
	> (j-type (instr-opcode jal) (instr-rd jal) 32)
	33555823

The value `33555823` (`0x200056f`) is RISC-V machine code for a JAL
instruction holing the value `32` (instead of `16`) as a J-immediate.
This can be easily verified using:

	> (set! jal-new 33555823)
	> (instr->hex jal-new)
	"#x0200056f"
	> (instr-j-imm jal-new)
	32

## Installation

In addition to standard compliant(?) Scheme source code, this repository
also contains the required files for using the code as a CHICKEN Scheme
[egg][call-cc eggs]. However, since the code is still in very early
stages of development I haven't published it as an egg yet. Nonetheless,
an egg can be built locally using:

	$ chicken-install -test

### Building without installing

If installation is not desired, build as follows:

	$ export CHICKEN_REPOSITORY_PATH="$(pwd):${CHICKEN_REPOSITORY_PATH}"
	$ chicken-install -n -test

Afterwards simply run `(import riscv)` in `csi(1)` as usual.

## License

This program is free software: you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the
Free Software Foundation, either version 3 of the License, or (at your
option) any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
Public License for more details.

You should have received a copy of the GNU General Public License along
with this program. If not, see <http://www.gnu.org/licenses/>.

[riscv website]: https://riscv.org/
[srfi-151]: https://srfi.schemers.org/srfi-151/srfi-151.html
[r7rs small]: https://small.r7rs.org/
[call-cc]: https://call-cc.org
[call-cc eggs]: https://eggs.call-cc.org/
