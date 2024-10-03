# tecy_emu_assembly

## Licencja

This project is licensed under the Creative Commons Attribution-ShareAlike 4.0 International License.

To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/4.0/ or see the LICENSE file.

## Wprowadzenie

Prosty kompilator dla projektu tecy_emu.
Dodaje możliwość wpisywania komentarzy (linijka rozpoczęta znakiem "#")
Pozwala na stosowanie etykiet, aby ułatwić korzystanie z instrukcji skoku..

## Syntax

Każda instrukcja zajmuje dokładnie jedną linijkę.

Instrukcje mogą przyjmować do 2 rejestrów jako parametry ( nazywane dalej Rd i Rs), oraz 8-bitową stałą nazywaną "immed"

Przykład z dwoma rejestrami:

    AND R0 R1

Wykonuje operacje AND na rejestrach R0 i R1 a następnie zapisuje je w R0

Przykład z immed:

    LI R0 14

Zapisuje stałą wartość 14 do rejestru 0

Dozwolone instrukcje:
- AND
- OR
- ADD
- SUB
- LW (opcode 0100)
- SW (opcode 0101)
- MOV
- NOP
- JEQ
- JNE
- JGT
- JLT
- LOAD (opcode 1100)
- STORE (opcode 1101)
- JMP

Działania instrukcji:

| Instrukcja i parametry     | Funkcja                 |
|------------------|-------------------------|
| AND Rd, Rs       | Rd = Rd AND Rs          |
| OR  Rd, Rs       | Rd = Rd OR Rs           |
| ADD Rd, Rs       | Rd = Rd + Rs            |
| SUB Rd, Rs       | Rd = Rd - Rs            |
| LW  Rd, (Rs)     | Rd = Mem[Rs]            |
| SW  Rd, (Rs)     | Mem[Rs] = Rd            |
| MOV Rd, Rs       | Rd = Rs                 |
| NOP              | Do nothing              |
| JEQ Rd, immed    | PC = immed if Rd == 0   |
| JNE Rd, immed    | PC = immed if Rd != 0   |
| JGT Rd, immed    | PC = immed if Rd &gt; 0 |
| JLT Rd, immed    | PC = immed if Rd &lt; 0 |
| LOAD  Rd, immed  | Rd = Mem[immed]         |
| STORE  Rd, immed | Mem[immed] = Rd         |
| LI  Rd, immed    | Rd = immed              |
| JMP immed        | PC = immed              |
