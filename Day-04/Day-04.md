# Day-04: GLS (Gate Level Simulation), Synthesis–Simulation Mismatches, Blocking vs Non-Blocking assignments


## 1. What is GLS (Gate Level Simulation)?
**Gate Level Simulation (GLS)** is the process of verifying the synthesized netlist of a design (after synthesis) rather than the RTL description.  
It ensures:  
- The logic of the synthesized netlist matches the original RTL design.  
- The design meets timing if the netlist is **delay-annotated**.  
- Helps catch any functional mismatches between RTL and gate-level code.  

**Why we do GLS:**  
- To verify logic correctness of the synthesized netlist.  
- To ensure design meets timing when delays are annotated.  
- To confirm equivalence between RTL simulation and synthesized netlist behavior.  

---

## 2. How to perform GLS using Icarus Verilog (iverilog)
1. Obtain the synthesized netlist (gate-level Verilog file from Yosys or any synthesis tool).  
2. Use the same testbench written for RTL verification.  
3. Compile both the netlist and testbench using iverilog.  
4. Dump simulation output into a `.vcd` file.  
5. View the waveform in GTKWave.  

If the gate-level netlist has **delay annotations**, the GLS becomes **timing-aware**, and we can check both *functionality* and *timing*.  
If there are no delays, GLS still verifies **functional correctness**.  

---

## 3. Synthesis–Simulation Mismatches  
Sometimes RTL simulation passes, but GLS fails. These mismatches happen due to:  

### (a) Missing Sensitivity List  
If all required signals are not included in the sensitivity list of an always block, simulation may show stale values while synthesis assumes full sensitivity.  

Example (wrong):  
always @(a or b)  
   y = a & b & c;  

Example (correct):  
always @(a or b or c)  
   y = a & b & c;  

---

### (b) Blocking vs Non-Blocking Assignments  
- **Blocking (=):** Executes statements sequentially (one after the other).  
- **Non-Blocking (<=):** All RHS values are evaluated first, then assignments happen in parallel at the end of the time step.  

Blocking example:  
always @(posedge clk) begin  
   q = d;       // q updated immediately  
   r = q;       // r gets new q (can cause mismatch)  
end  

Non-Blocking example:  
always @(posedge clk) begin  
   q <= d;      // q updated at end of time step  
   r <= q;      // r gets old q (correct behavior for flops)  
end  

---

### (c) Non-Standard Verilog Coding  
Coding styles outside standard synthesizable Verilog (e.g., delays `#5`, infinite loops without sensitivity, latches from incomplete if/else) may simulate fine but synthesis tools either reject or interpret differently.  
This creates mismatches between RTL simulation and gate-level results.  

---
