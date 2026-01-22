# Vending Machine FSM

## Overview
This is a Finite State Machine (FSM) design for a **Vending Machine** implemented in Verilog. The design simulates a simple vending machine that accepts coin inputs and dispenses products based on the coins received.

## Project Files

### 1. **schem_vending_machine.v** - Main Design Module
The main FSM module that implements the vending machine logic with 4 states:
- **S1 (State 0)**: Initial/Idle state
- **S2 (State 1)**: One coin inserted
- **S3 (State 2)**: Two coins inserted
- **S4 (State 3)**: Three or more coins inserted

#### Module Ports:
```verilog
module schem_vending_machine(
  input  [1:0] in,       // Coin input (00: no coin, 01: 1 coin, 10: 2 coins, 11: 3 coins)
  input  clk,            // Clock signal
  input  reset,          // Active-high reset
  output reg [1:0] out,  // Product output (00: no product, 01: product A, 10: product B, 11: both)
  output reg [1:0] change // Change amount (00: no change, 01: 1 unit, 10: 2 units, 11: 3 units)
);
```

#### State Transitions:
The FSM transitions between states based on input coins:
- From S1: Transitions to S2 (1 coin), S3 (2 coins), or stays in S1 (0 coins)
- From S2: Transitions to S3 (1 coin), S4 (2 coins), or returns to S1 (0 coins)
- From S3: Transitions to S4 (1 coin), or returns to S1 (0/2 coins)
- From S4: Returns to S1 with product and change

### 2. **schem_vending_machine_tb.v** - Testbench
Comprehensive testbench for simulation with ModelSim/Intel Quartus Prime:
- **Clock generation**: 10 ns period (5 ns high/low)
- **Reset sequence**: Initializes the FSM
- **Test vectors**: Multiple input sequences to verify all state transitions
- **Simulation time**: 250 ns total simulation period

#### Test Sequences:
1. **Sequence 1**: 01 → 01 → 10 (1 coin + 1 coin + 2 coins)
2. **Sequence 2**: 01 → 10 → 01 (1 coin + 2 coins + 1 coin)
3. **Sequence 3**: 10 → 10 → 01 (2 coins + 2 coins + 1 coin)

## Schematic Design
The RTL schematic shows:
- Finite State Machine logic with 4 states
- Next state decoder combinational logic
- Output logic for product and change calculation
- Synchronous state update on positive clock edge
- Asynchronous reset

## Waveforms
The simulation waveforms display:
- **Clock (clk)**: 10 ns period
- **Reset (reset)**: Active high for first 20 ns
- **Input (in)**: 2-bit coin input signal
- **Output (out)**: 2-bit product signal
- **Change (change)**: 2-bit change amount signal

## Simulation Results
The waveforms confirm:
- Proper state transitions based on input patterns
- Correct product output generation
- Accurate change calculation
- Synchronous operation with clock
- Proper reset behavior

## How to Run

### In ModelSim:
```bash
vlog schem_vending_machine.v
vlog schem_vending_machine_tb.v
vsim work.schem_vending_machine_tb
run -all
```

### In Intel Quartus Prime:
1. Create new Quartus project
2. Add both .v files to the project
3. Set `schem_vending_machine_tb` as top-level simulation module
4. Compile and run simulation
5. View generated waveforms

## Design Specifications
- **Input Width**: 2 bits (4 coin values)
- **Output Width**: 2 bits each (product and change)
- **Number of States**: 4
- **Clock Frequency**: 100 MHz (10 ns period)
- **Reset Type**: Asynchronous/Synchronous (configurable)

## Truth Table
| State | Input | Next State | Output (Product) | Change |
|-------|-------|------------|------------------|--------|
| S1    | 00    | S1         | 00               | 00     |
| S1    | 01    | S2         | 00               | 00     |
| S1    | 10    | S3         | 01               | 00     |
| S2    | 00    | S1         | 00               | 01     |
| S2    | 01    | S3         | 01               | 00     |
| S2    | 10    | S4         | 01               | 01     |
| S3    | 00    | S1         | 01               | 00     |
| S3    | 01    | S4         | 00               | 00     |
| S3    | 10    | S1         | 10               | 00     |
| S4    | 00    | S1         | 01               | 01     |
| S4    | 01    | S1         | 10               | 00     |
| S4    | 10    | S1         | 10               | 01     |

## Author
Charan (charan89-dev)

## Date
January 22, 2026

## License
Public Domain - Educational Project
