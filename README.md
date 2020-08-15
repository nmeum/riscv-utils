# riscv-utils

Scheme utility procedures for the [RISC-V][riscv website] instruction set architecture.

## Features

The feature set of provided procedures is centered around easing the
development of utilities for RISC-V (especially instruction set
simulators). Currently the following features are provided:

* `decode.scm`: Decoding of RISC-V instructions.
* `encode.scm`: Encoding of RISC-V instructions.
* `convert.scm`: Conversion from/to different representations.

## Usage

The code is supposed to be used from a Scheme REPL, no binaries are
provided. The Scheme files in the `riscv/` directory are mostly(?)
[R7RS][r7rs small] compatible. It should be possible to use them with any
standard compliant Scheme implementation which provides an
[SRFI-151][srfi-151] module. Just load the files you want to use
using `(load "riscv/<file>.scm")` from your Scheme REPL.

If your favorite Scheme implementation is [CHICKEN][call-cc], read on.

## Installation

In addition to standard compliant(?) Scheme source code, this repository
also contains the required files for using the code as a CHICKEN Scheme
[egg][call-cc eggs]. However, since the code is still in very early
stages of development I haven't published it as an egg yet. Nonetheless,
an egg can be built locally using:

	$ chicken-install -test

### Building without installing

If installation is not desired, build as follows:

	$ export CHICKEN_REPOSITORY_PATH="${CHICKEN_REPOSITORY_PATH}:$(pwd)"
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
