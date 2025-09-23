# Day-01: Introduction to RTL Design Simulation & Synthesis

Simulation is the process of using software tools to mimic and verify the behavior of a digital circuit described in Register-Transfer Level (RTL) code, typically written in Verilog or VHDL, before the design is implemented in hardware. This allows designers to test and debug their circuits in a virtual environment.

![Simulation Block Diagram](./Images/simulation_blk.png)

## Simulator

A simulator is a software tool that executes the simulation process. For this tutorial, we will use **Icarus Verilog**, an open-source Verilog simulation tool, to simulate our designs.

## Testbench

A testbench is a specialized piece of HDL (Hardware Description Language) code written to provide input stimuli to the **Design Under Test (DUT)** and verify its outputs. It mimics the environment in which the design will operate, enabling automated testing and validation.

---

# Simulating a Design Using Icarus Verilog

To simulate a design, you will need the **iverilog** tool. Instructions for installing Icarus Verilog are available in the [Week0 repository](https://github.com/tejasbg19/India_riscV_SoC_tapeout/blob/main/Week0/Week0.md). Additionally, a text editor is required to write, edit, and view Verilog and testbench files. This tutorial uses **Gedit**, which can be installed on Ubuntu with:

```bash
$ sudo apt install gedit
```

You can create a personal directory to store your Verilog modules and testbenches, then follow the steps below to perform simulations. Alternatively, you can clone the repository provided by Kunal Sir ([click here](https://github.com/kunalg123/sky130RTLDesignAndSynthesisWorkshop)), which contains pre-written design and testbench files ready for simulation.

### Steps to Create and Simulate

1. Create a directory for your RTL and testbench files:
   ```bash
   $ mkdir RTL_and_tb
   $ cd RTL_and_tb
   $ gedit adder.v adder_tb.v
   ```

2. Write and save your Verilog design (`adder.v`) and testbench (`adder_tb.v`) files using Gedit. Alternatively, you can copy the code from the [Day-01/RTL_and_tb](./Day-01/RTL_and_tb) folder in the repository.

3. Compile and simulate the design using Icarus Verilog.

#### Default Compilation

```bash
$ iverilog adder.v adder_tb.v
$ vvp a.out  # or ./a.out
```

- The `iverilog` command compiles the Verilog files and generates a default executable named `a.out`.
- The `vvp` command runs the simulation. If the testbench includes VCD (Value Change Dump) commands, a waveform file (e.g., `dump.vcd`) is generated.

![Default Compilation Output](./Images/iverilog_normal.png)

#### Compiling with a Custom Output Name

```bash
$ iverilog -o adder adder.v adder_tb.v
$ vvp adder
```

- The `-o` option allows you to specify a custom name for the output executable (e.g., `adder`).
- Run the simulation using `vvp adder`.

![Custom Compilation Output](./Images/iverilog_custom.png)

---

# Viewing the Waveform with GTKWave

If the simulation generates a `.vcd` file (waveform dump), you can visualize it using **GTKWave**, a waveform viewer:

```bash
$ gtkwave dump.vcd  # Use the custom VCD file name if specified in the testbench
```

- This command opens the GTKWave GUI, where you can inspect signals, add variables to the waveform viewer, and debug your design interactively.

![GTKWave Interface](./Images/gtkwave_open.png)

![GTKWave Waveform Output](./Images/gtkwave_output.png)

---

# Full Adder Implementation

A **full adder** circuit was implemented and simulated as an example. The full adder takes three inputs (A, B, and Cin) and produces two outputs (Sum and Cout). The output can be verified by analyzing the generated `.vcd` file using GTKWave.

### Full Adder Truth Table

The truth table for a full adder is shown below:

| A | B | Cin | Sum | Cout |
|---|---|-----|-----|------|
| 0 | 0 |  0  |  0  |  0   |
| 0 | 0 |  1  |  1  |  0   |
| 0 | 1 |  0  |  1  |  0   |
| 0 | 1 |  1  |  0  |  1   |
| 1 | 0 |  0  |  1  |  0   |
| 1 | 0 |  1  |  0  |  1   |
| 1 | 1 |  0  |  0  |  1   |
| 1 | 1 |  1  |  1  |  1   |

- **Sum** = A ⊕ B ⊕ Cin
- **Cout** = (A ∧ B) ∨ (B ∧ Cin) ∨ (A ∧ Cin)

This truth table represents all possible input combinations and their corresponding outputs for a full adder. You can verify the simulation results against this table using GTKWave.

---

# Conclusion

By following the steps above, you can simulate a Verilog design using Icarus Verilog, generate a waveform file, and analyze it with GTKWave. The full adder example demonstrates how to verify a design's functionality through simulation. Continue exploring by creating your own designs or using the provided repository to deepen your understanding of RTL simulation.
