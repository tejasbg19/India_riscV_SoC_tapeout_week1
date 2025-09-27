# Day-04: GLS (Gate Level Simulation), Synthesis–Simulation Mismatches, Blocking vs Non-Blocking assignments  

---

## 1. GLS (Gate Level Simulation)  

**Definition:**  
Gate Level Simulation (GLS) is the process of simulating the synthesized gate-level netlist instead of the RTL description.  

**How to do GLS in Icarus Verilog :**  
1. Write your RTL design and testbench.  
2. Synthesize the RTL with Yosys → generate gate-level netlist.  
3. Collect the following files:  
   - Testbench (`tb.v`)  
   - RTL code (`design.v`)  
   - Synthesized netlist (`netlist.v`)  
   - Primitive cells (`my_lib/verilog_model/primitives.v`)  
   - Gate-level modules from **sky130 PDK** (`my_lib/verilog_model/sky130_fd_sc_hd.v` from Kunal sir’s repo).  
4. Run `iverilog` with all the above files.  
5. Generate VCD dump and open with GTKWave.

```bash
$ iverilog design.v tb.v ../my_lib/verilog_model/sky130_fd_sc_hd.v ../my_lib/verilog_model/primitives.v
$ vvp a.out  # or ./a.out
$ gtkwave name_of_file.vcd
```
 

**Why GLS is needed?**  
- To verify functional correctness of synthesized logic.  
- To detect **synthesis–simulation mismatches**.  
- If the gate-level modules are **timing-aware**, we can also verify **timing behavior** in addition to logic.  

**GLS Verification of a Simple 2:1 Mux :**


| RTL Code of module ternary_operator_mux |  Test Bench of module ternary_operator_mux |
|--------------------------------------------|------------------------------------------|
| <img src="./Images/1a_ternary_mux_code.png" alt="1a_ternary_mux_code.png" width="500"/> | <img src="./Images/1b_ternary_mux_tb_code.png" alt="1b_ternary_mux_tb_code.png" width="500"/> | 
<br>

<div align="center">
  <img src="./Images/1_ternary_mux_simu_gtk.png" alt="1_ternary_mux_simu_gtk.png" width="1000" />
  <p><b>RTL Simulation Output</b></p>
</div>

<br>

<div align="center">
  <img src="./Images/2_ternary_mux_cells.png" alt="2_ternary_mux_cells.png" width="600" />
  <p><b>Number & Type of Cells as Infered by Yosys</b></p>
</div>

<br>


<div align="center">
  <img src="./Images/3_ternary_mux_show.png" alt="3_ternary_mux_show.png" width="1000" />
  <p><b>Graphical Representation of Synthesized Netlist of module ternary_operator_mux</b></p>
</div>

<br>


<div align="center">
  <img src="./Images/3a_ternary_mux_netlist.png" alt="3a_ternary_mux_netlist.png" width="600" />
  <p><b>Synthesized Netlist of module ternary_operator_mux</b></p>
</div>

<br>


<div align="center">
  <img src="./Images/4_ternary_mux_GLS_simu_gtk.png" alt="4_ternary_mux_GLS_simu_gtk.png" width="1000" />
  <p><b>Gate Level Simulation of the Synthesized Netlist of module ternary_operator_mux</b></p>
</div>


---


## 2. Types of Synthesis–Simulation Mismatches  

### (a) Missing Sensitivity List  
- If a signal is missing in the sensitivity list, RTL sim behaves like a **latch**.  
- After synthesis, the same logic is implemented as a **MUX**, leading to mismatch.
- **Example :**

| RTL Code of module bad_mux |  Test Bench of module bad_mux |
|--------------------------------------------|------------------------------------------|
| <img src="./Images/5a_bad_mux_code.png" alt="5a_bad_mux_code.png" width="500"/> | <img src="./Images/5b_bad_mux_tb.png" alt="5b_bad_mux_tb.png" width="500"/> | 
<br>

<div align="center">
  <img src="./Images/6_bad_mux_simu_gtk.png" alt="6_bad_mux_simu_gtk.png" width="1000" />
  <p><b>RTL Simulation Output</b></p>
</div>

<br>

As we can see even though the RTL coding style seems to be that of a `2:1 Mux`, the simulated output waveform seems to be reflecting a latched Mux where the output is sensing the input `I0` & `I1` only when there is change in state of select line `sel`. 

<div align="center">
  <img src="./Images/7_bad_mux_cells.png" alt="7_bad_mux_cells.png" width="800" />
  <p><b>Number & Type of Cells as Infered by Yosys</b></p>
</div>

<br>


<div align="center">
  <img src="./Images/8_bad_mux_show.png" alt="8_bad_mux_show.png" width="1000" />
  <p><b>Graphical Representation of Synthesized Netlist of module bad_mux</b></p>
</div>

<br>


<div align="center">
  <img src="./Images/9_bad_mux_netlist.png" alt="9_bad_mux_netlist.png" width="600" />
  <p><b>Synthesized Netlist of module bad_mux</b></p>
</div>

<br>


<div align="center">
  <img src="./Images/10_bad_mux_GLS_simu_gtk.png" alt="10_bad_mux_GLS_simu_gtk.png" width="1000" />
  <p><b>Gate Level Simulation of the Synthesized Netlist of module bad_mux</b></p>
</div>



---

### (b) Blocking vs Non-Blocking Assignments  

**Blocking (`=`):**  
- Executes sequentially, just like a C program.  
- Commonly used for **combinational logic**.  

**Non-Blocking (`<=`):**  
- RHS values are evaluated first, then all assignments update in parallel.  
- Commonly used for **sequential (flip-flop) logic**.
- **Example :**





### (c) Non-Standard Verilog Coding  

Some constructs simulate fine but are not synthesizable → tools either reject them or interpret differently.  

Examples (in plain text):  
- Using delays like `#5`.  
- Infinite loops without proper sensitivity list.  
- Incomplete if/else → unintended latches.  

📷 *[Insert images here: code, testbench, RTL vs netlist simulation outputs]*  

---
