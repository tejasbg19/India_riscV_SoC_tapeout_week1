# Day-03: Combinational & Sequential Logic Optimization

## 📌 Introduction
Logic optimization is the process of transforming a digital circuit into a more efficient version without changing its functionality.  
The goals of optimization include:
- Reducing area (fewer gates, smaller silicon footprint).
- Reducing power consumption (fewer transitions, less dynamic power).
- Reducing delay (faster circuits, higher performance).
- Improving reliability (simpler designs, easier verification).

Optimization is a crucial step in digital VLSI design because even small improvements in area and power can have a huge impact in large-scale integrated circuits. The genral steps invilved in optimizing a design in yosys is given below :
```bash
$ read_liberty -lib /path/to/sky130_fd_sc_hd__tt_025C_1v80.lib
$ read_verilog main_module.v submodule.v
$ synth -top top_module_name
$ opt_clean -purge  # to optimize and remove unused nets and cells. If multiple instantion sof submodules exist before this step use flatten command
$ abc -liberty path/to/library.lib
$ write_verilog -noattr my_design_netlist.v
$ show top_module_name
# to save the graphical schemtaic in png formate in the present working directory use $ show -format png -prefix./<name_u_want> top_module_name
$ exit       # to exit yosys.   
```


---

## 🔹 Combinational Logic Optimization

### 1. Constant Propagation
**Definition:**  
When the value of an input is constant (either 0 or 1), it can be propagated through the circuit to simplify logic.

**Example:**  
- y = a AND 1 → y = a  
- y = a AND 0 → y = 0  
- y = a OR 0 → y = a  
- y = a OR 1 → y = 1  

Instead of implementing gates, synthesis tools will replace them with direct wires or constants.

---

#### 🔹Example 1 of Combinational Logic Optimization done by Yosys

<div align="center">
  <img src="./Images/1a_opt_check_cpde.png" alt="1a_opt_check_cpde.png" width="600" />
  <p><b>Verilog Code of module opt_check</b></p>
</div>
<br>

On simple observation the above RTL code should have been translated to a `Mux` but when synthesized using Yosys with the `opt_clean -purge` command it translates to a simple and gate as shown below.


<div align="center">
  <img src="./Images/1opt_check_invoke_synth.png" alt="1opt_check_invoke_synth.png" width="800" />
  <p><b>Yosys Invoked, liberty and verilog file passed</b></p>
</div>
<br>
<div align="center">
  <img src="./Images/2opt_check_numcells.png" alt="2opt_check_numcells.png" width="800" />
  <p><b>Number of Cells used & Optimization command given</b></p>
</div>
<br>
<div align="center">
  <img src="./Images/3opt_check_show.png" alt="3opt_check_show.png" width="800" />
  <p><b>Graphical View of Synthesized Netlist module opt_check</b></p>
</div>
<br>


---


#### 🔹Example 2 of Combinational Logic Optimization done by Yosys

<div align="center">
  <img src="./Images/4a_opt_check2_code.png" alt="4a_opt_check2_code.png" width="600" />
  <p><b>Verilog Code of module opt_check2</b></p>
</div>
<br>
Similarly just like example 1 due to propagation of constant 1, the `Mux` was optimized to a 2-input OR gate as show below.

<br>
<div align="center">
  <img src="./Images/4opt_check2_show.png" alt="4opt_check2_show.png" width="800" />
  <p><b>Graphical View of Synthesized Netlist module opt_check2</b></p>
</div>
<br>


---


#### 🔹Example 3 of Combinational Logic Optimization done by Yosys

<div align="center">
  <img src="./Images/5a_opt_check3_code.png" alt="5a_opt_check3_code.png" width="600" />
  <p><b>Verilog Code of module opt_check3</b></p>
</div>
<br>

Similarly just like example 1 due to propagation of constant 1, the `Mux` was optimized to a 3-input AND gate as show below.

<br>
<div align="center">
  <img src="./Images/5_opt_check3_show.png" alt="5_opt_check3_show.png" width="800" />
  <p><b>Graphical View of Synthesized Netlist module opt_check3</b></p>
</div>
<br>


---

#### 🔹Example 4 of Combinational Logic Optimization done by Yosys

<div align="center">
  <img src="./Images/6a_opt_check4_code.png" alt="6a_opt_check4_code.png" width="600" />
  <p><b>Verilog Code of module opt_check4</b></p>
</div>
<br>

Similarly just like example 1 due to propagation of constant 1, the `Mux` was optimized to a 2-input XNOR gate as show below.

<br>
<div align="center">
  <img src="./Images/6opt_check4_show.png" alt="6opt_check4_show.png" width="800" />
  <p><b>Graphical View of Synthesized Netlist module opt_check4</b></p>
</div>
<br>


---

#### 🔹Example 5 of Combinational Logic Optimization done by Yosys

<div align="center">
  <img src="./Images/7a_multimodule_opt_code.png" alt="7a_multimodule_opt_code.png" width="600" />
  <p><b>Verilog Code of module multiple_module_opt</b></p>
</div>
<br>

As this module contains many submodules, we must first use `flatten` command before applying the optimization code `opt_clean -purge`.

<br>
<div align="center">
  <img src="./Images/7multimodule_opt_show.png" alt="7multimodule_opt_show.png" width="800" />
  <p><b>Graphical View of Synthesized Netlist module multiple_module_opt</b></p>
</div>
<br>


---

#### 🔹Example 5 of Combinational Logic Optimization done by Yosys  

<div align="center">
  <img src="./Images/8a_multimodule_opt2_code.png" alt="8a_multimodule_opt2_code.png" width="600" />
  <p><b>Verilog Code of module multiple_module_opt2</b></p>
</div>
<br>

As this module contains many submodules, we must first use `flatten` command before applying the optimization code `opt_clean -purge`. despite And gates being instantiated multiple times d=through the submodules, Yosys optimized it in such a way that no logic cells were used in the final synthesized output as shown below.

<br>
<div align="center">
  <img src="./Images/8multimodule_opt2_show.png" alt="8multimodule_opt2_show.png" width="800" />
  <p><b>Graphical View of Synthesized Netlist module multiple_module_opt2</b></p>
</div>
<br>



---

### 2. Boolean Logic Optimization
**Definition:**  
Using Boolean algebra to simplify expressions and reduce the number of gates.

**Examples:**  
- Idempotent Law: `a + a = a`  
- Absorption Law: `a + (a·b) = a`, `a' + a.b = a + b` 
- Consensus Theorem: `a·b + a'·c + b·c = a·b + a'·c`

This helps eliminate redundant terms and gates.

---

### 3. Karnaugh Map (K-Map)
**Definition:**  
A graphical method of minimizing Boolean expressions for up to 5–6 variables.  
It groups adjacent 1s (minterms) into rectangles to find simplified expressions.

**Example:**  
Function: F(A,B,C) = Σ(1,3,7)  
K-map simplification → F = A'C + AB

---

### 4. Quine–McCluskey Algorithm
**Definition:**  
A tabular method of logic minimization suitable for computer implementation.  
It systematically finds prime implicants and reduces expressions.

**Example:**  
Function: F(A,B,C,D) = Σ(0,1,2,5,6,7,8,9,10,14)  
Quine–McCluskey procedure → minimal sum of products.

---

## 🔹 Sequential Logic Optimization

### 1. Sequential Constant Propagation
**Definition:**  
If a register always stores a constant (never changes during operation), the synthesis tool can replace it with a constant wire.

**Example:**  
A flip-flop that always loads 0 on every clock can be removed and replaced by a constant 0.

#### 🔹Example 1 of Sequential Logic Optimization done by Yosys

<div align="center">
  <img src="./Images/9a_dff_const1_code.png" alt="9a_dff_const1_code.png" width="600" />
  <p><b>Verilog Code of module dff_const1</b></p>
</div>
<br>

<div align="center">
  <img src="./Images/9_dff_const1_simu.png" alt="9_dff_const1_simu.png" width="600" />
  <p><b>Simulation of module dff_const1 using iverilog</b></p>
</div>
<br>

<div align="center">
  <img src="./Images/10_dff_const1_gtk.png" alt="10_dff_const1_gtk.png" width="1000" />
  <p><b>Simulated waveforms of module dff_const1 in GTKwave</b></p>
</div>
<br>

<div align="center">
  <img src="./Images/13_dff_const1_yosys_invoke.png" alt="13_dff_const1_yosys_invoke.png" width="800" />
  <p><b>Yosys Invoked, liberty and verilog file passed</b></p>
</div>
<br>
<div align="center">
  <img src="./Images/14a_dff_const1_cells.png" alt="14a_dff_const1_cells.png" width="800" />
  <p><b>Number of Cells used </b></p>
</div>
<br>
<div align="center">
  <img src="./Images/14_dff_const1_show.png" alt="14_dff_const1_show.png" width="1000" />
  <p><b>Graphical View of Synthesized Netlist module dff_const1</b></p>
</div>
<br>


---

#### 🔹Example 2 of Sequential Logic Optimization done by Yosys

<div align="center">
  <img src="./Images/11a_dff_const2_code.png" alt="11a_dff_const2_code.png" width="600" />
  <p><b>Verilog Code of module dff_const2</b></p>
</div>
<br>

<div align="center">
  <img src="./Images/11_dff_const2_simu.png" alt="11_dff_const2_simu.png" width="600" />
  <p><b>Simulation of module dff_const2 using iverilog</b></p>
</div>
<br>

<div align="center">
  <img src="./Images/12_dff_const2_gtk.png" alt="12_dff_const2_gtk.png" width="1000" />
  <p><b>Simulated waveforms of module dff_const2 in GTKwave</b></p>
</div>

<br>
<div align="center">
  <img src="./Images/15_dff_const2_cells.png" alt="15_dff_const2_cells.png" width="800" />
  <p><b>Number of Cells used </b></p>
</div>
<br>
<div align="center">
  <img src="./Images/16_dff_const2_show.png" alt="16_dff_const2_show.png" width="1000" />
  <p><b>Graphical View of Synthesized Netlist module dff_const2</b></p>
</div>
<br>


---

#### 🔹Example 3 of Sequential Logic Optimization done by Yosys

<div align="center">
  <img src="./Images/17a_dff_const3_code.png" alt="17a_dff_const3_code.png" width="600" />
  <p><b>Verilog Code of module dff_const3</b></p>
</div>
<br>

<div align="center">
  <img src="./Images/17_dff_const3_simu.png" alt="17_dff_const3_simu.png" width="600" />
  <p><b>Simulation of module dff_const3 using iverilog</b></p>
</div>
<br>

<div align="center">
  <img src="./Images/18_dff_const3_gtk.png" alt="18_dff_const3_gtk.png" width="1000" />
  <p><b>Simulated waveforms of module dff_const3 in GTKwave</b></p>
</div>

<br>
<div align="center">
  <img src="./Images/19_dff_const3_cells.png" alt="19_dff_const3_cells.png" width="800" />
  <p><b>Number of Cells used </b></p>
</div>
<br>
<div align="center">
  <img src="./Images/20_dff_const3_show.png" alt="20_dff_const3_show.png" width="1000" />
  <p><b>Graphical View of Synthesized Netlist module dff_const3</b></p>
</div>
<br>


---

#### 🔹Example 4 of Sequential Logic Optimization done by Yosys

<div align="center">
  <img src="./Images/21a_dff_const4_code.png" alt="21a_dff_const4_code.png" width="600" />
  <p><b>Verilog Code of module dff_const4</b></p>
</div>
<br>

<div align="center">
  <img src="./Images/21_dff_const4_simu.png" alt="21_dff_const4_simu.png" width="600" />
  <p><b>Simulation of module dff_const4 using iverilog</b></p>
</div>
<br>

<div align="center">
  <img src="./Images/22_dff_const4_gtk.png" alt="22_dff_const4_gtk.png" width="1000" />
  <p><b>Simulated waveforms of module dff_const4 in GTKwave</b></p>
</div>

<br>
<div align="center">
  <img src="./Images/23_dff_const4_cells.png" alt="23_dff_const4_cells.png" width="800" />
  <p><b>Number of Cells used </b></p>
</div>
<br>
<div align="center">
  <img src="./Images/24_dff_const4_show.png" alt="24_dff_const4_show.png" width="1000" />
  <p><b>Graphical View of Synthesized Netlist module dff_const4</b></p>
</div>
<br>


---

#### 🔹Example 5 of Sequential Logic Optimization done by Yosys

<div align="center">
  <img src="./Images/25a_dff_const5_code.png" alt="25a_dff_const5_code.png" width="600" />
  <p><b>Verilog Code of module dff_const5</b></p>
</div>
<br>

<div align="center">
  <img src="./Images/25_dff_const5_simu.png" alt="25_dff_const5_simu.png" width="600" />
  <p><b>Simulation of module dff_const5 using iverilog</b></p>
</div>
<br>

<div align="center">
  <img src="./Images/26_dff_const5_gtk.png" alt="26_dff_const5_gtk.png" width="1000" />
  <p><b>Simulated waveforms of module dff_const5 in GTKwave</b></p>
</div>

<br>
<div align="center">
  <img src="./Images/27_dff_const5_cells.png" alt="27_dff_const5_cells.png" width="800" />
  <p><b>Number of Cells used </b></p>
</div>
<br>
<div align="center">
  <img src="./Images/28_dff_const5_show.png" alt="28_dff_const5_show.png" width="1000" />
  <p><b>Graphical View of Synthesized Netlist module dff_const5</b></p>
</div>
<br>


---

### 2. State Optimization
**Definition:**  
Simplifying the state machine by removing unreachable or redundant states.  
This reduces the number of flip-flops and logic required for next-state/output decoding.

---

### 3. Retiming
**Definition:**  
The process of repositioning registers across combinational logic without changing the overall functionality.  
Goal: balance the delays across paths to improve maximum clock frequency.

---

### 4. Sequential Logic Cloning (Physical-Aware Synthesis)
**Definition:**  
When a flip-flop drives multiple far-apart logic cones, the tool may create additional "clones" of the same register placed closer to the logic blocks.  
This reduces routing delay and improves timing closure in large designs.

---
<!--
## ✅ Summary
- Combinational optimization focuses on simplification of Boolean logic (propagation, minimization).  
- Sequential optimization deals with flip-flops and state elements (constant propagation, state reduction, retiming, cloning).  
- Both are critical for reducing area, power, and delay in modern digital circuits. -->

### 5. Removal of Unused Logic
**Definition:**  
Any intermediate logic or registers that do not contribute to the final output are considered unused and are removed by the synthesis tool.  

**Example: 1**  

<div align="center">
  <img src="./Images/29a_counter_opt_code.png" alt="29a_counter_opt_code.png" width="600" />
  <p><b>Verilog Code of module counter_opt</b></p>
</div>

<br>

<div align="center">
  <img src="./Images/29_counter_opt_cells.png" alt="29_counter_opt_cells.png" width="800" />
  <p><b>Number of Cells used </b></p>
</div>
<br>
<div align="center">
  <img src="./Images/30_counter_opt_counter_show.png" alt="30_counter_opt_counter_show.png" width="1000" />
  <p><b>Graphical View of Synthesized Netlist module counter_opt</b></p>
</div>
<br>

In the above 3-bit counter, only the least significant bit `count(0)` is assigned to the final output `q`, the logic for `count(1)` and `count(2)` is unused.  
During synthesis, these unused flip-flops and related combinational logic were pruned, reducing area and power without affecting the functionality of the design. 


---

**Example: 2**  

<div align="center">
  <img src="./Images/31a_counter_opt2_code.png" alt="31a_counter_opt2_code.png" width="600" />
  <p><b>Verilog Code of module counter_opt2</b></p>
</div>

<br>

The above verilog module is the modified version of example 1, here the all the bits of counter are used to determine the output of the module, hence there is no unused intermediate logic, hence all 3 flops will be synthesized.


<div align="center">
  <img src="./Images/31_counter_opt2_cells.png" alt="31_counter_opt2_cells.png" width="800" />
  <p><b>Number of Cells used </b></p>
</div>
<br>
<div align="center">
  <img src="./Images/32_counter_opt2_show.png" alt="32_counter_opt2_show.png" width="1000" />
  <p><b>Graphical View of Synthesized Netlist module counter_opt2</b></p>
</div>
<br>





