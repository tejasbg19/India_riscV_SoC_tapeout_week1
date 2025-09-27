# Day-04: GLS (Gate Level Simulation), Synthesis–Simulation Mismatches, Blocking vs Non-Blocking assignments  

---

## 1. GLS (Gate Level Simulation)  

**Definition:**  
Gate Level Simulation (GLS) is the process of simulating the synthesized gate-level netlist instead of the RTL description.  

**How to do GLS in Icarus Verilog (steps only):**  
1. Write your RTL design and testbench.  
2. Synthesize the RTL with Yosys → generate gate-level netlist.  
3. Collect the following files:  
   - Testbench (`tb.v`)  
   - RTL code (`design.v`)  
   - Synthesized netlist (`netlist.v`)  
   - Primitive cells (`primitive.v`)  
   - Gate-level modules from **sky130 PDK** (`my_lib/verilog_codes/` from Kunal sir’s repo).  
4. Run `iverilog` with all the above files.  
5. Generate VCD dump and open with GTKWave.  

**Why GLS is needed?**  
- To verify functional correctness of synthesized logic.  
- To detect **synthesis–simulation mismatches**.  
- If the gate-level modules are **timing-aware**, we can also verify **timing behavior** in addition to logic.  

---

## 2. Types of Synthesis–Simulation Mismatches  

### (a) Missing Sensitivity List  
- If a signal is missing in the sensitivity list, RTL sim behaves like a **latch**.  
- After synthesis, the same logic is implemented as a **MUX**, leading to mismatch.  

📷 *[Insert images here: code, testbench, RTL simulation waveform, inferred cells from Yosys, schematic view of netlist, generated netlist code, netlist simulation output]*  

---

### (b) Blocking vs Non-Blocking Assignments  

**Blocking (`=`):**  
- Executes sequentially, just like a C program.  
- Commonly used for **combinational logic**.  

**Non-Blocking (`<=`):**  
- RHS values are evaluated first, then all assignments update in parallel.  
- Correct style for **sequential (flip-flop) logic**.  

📷 *[Insert images here: code, testbench, RTL sim output, synthesized netlist, netlist simulation output]*  

---

### (c) Non-Standard Verilog Coding  

Some constructs simulate fine but are not synthesizable → tools either reject them or interpret differently.  

Examples (in plain text):  
- Using delays like `#5`.  
- Infinite loops without proper sensitivity list.  
- Incomplete if/else → unintended latches.  

📷 *[Insert images here: code, testbench, RTL vs netlist simulation outputs]*  

---
