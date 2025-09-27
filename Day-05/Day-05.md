# Day-05: Good & Bad Coding Practices when dealing with if-else, Case and Loops  

---

## 1. If–Else Statements  

**Introduction:**  
- The `if–elseif–else` chain is **priority-based**.  
- First condition is checked, if true it executes, otherwise moves down the chain.  
- Useful for priority encoders and similar logic.  

**Generic Syntax (text only):**  
if (condition1)  
  statement1;  
else if (condition2)  
  statement2;  
else  
  statement3;  

**Cautions / Dangers:**  
- If you forget to specify all branches, the synthesizer will infer a **latch**.  
- Latches are dangerous in synchronous designs because they cause timing and metastability issues.  

**Example 1 (incomplete if causing latch):**  

| RTL Code of module incomp_if |  Test Bench of module incomp_if |
|--------------------------------------------|------------------------------------------|
| <img src="./Images/1a_incomp_if_code.png" alt="1a_ternary_mux_code.png" width="500"/> | <img src="./Images/1b_incomp_if_tb.png" alt="1b_ternary_mux_tb_code.png" width="500"/> | 
<br>

<div align="center">
  <img src="./Images/1_incomp_if_gtk_simu.png" alt="1_incomp_if_gtk_simu.png" width="1000" />
  <p><b>RTL Simulation Output</b></p>
</div>
<br>

As output is not defined for condiition when `i0 = 0` , the output latches itself to previous value of `Y` which was `1` when `i0` becomes `0`


<div align="center">
  <img src="./Images/2_incomp_if_cell.png" alt="2_incomp_if_cell.png" width="600" />
  <p><b>As Expected only 1 Dlatch is Infered by Yosys</b></p>
</div>

<br>


<div align="center">
  <img src="./Images/3_incomp_if_show.png" alt="3_incomp_if_show.png" width="1000" />
  <p><b>Graphical Representation of Synthesized Netlist of module incomp_if</b></p>
</div>

<br>


<div align="center">
  <img src="./Images/3a_incomp_if_netlist.png" alt="3a_incomp_if_netlist.png" width="800" />
  <p><b>Synthesized Netlist of module incomp_if</b></p>
</div>

<br>

---

**Example 2 (incomplete if causing latch):**  

| RTL Code of module incomp_if2 |  Test Bench of module incomp_if2 |
|--------------------------------------------|------------------------------------------|
| <img src="./Images/4a_incomp_if2_code.png" alt="4b_incomp_if2_.png" width="500"/> | <img src="./Images/4b_incomp_if2_tb.png" alt="4b_incomp_if2_tb.png" width="500"/> | 
<br>

<div align="center">
  <img src="./Images/5a_incomp_if2_gtk1_latch1.png" alt="5a_incomp_if2_gtk1_latch1.png" width="1000" />
  <p><b>RTL Simulation Output</b></p>
</div>
<br>

As output is not defined for condiition when `i0 = 0` & `i2 = 0` , the output latches itself to previous value of `Y` which was `1`.

<br>

<div align="center">
  <img src="./Images/5b_incomp_if2_gtk2_latch0.png" alt="5b_incomp_if2_gtk2_latch0.png" width="1000" />
  <p><b>RTL Simulation Output</b></p>
</div>
<br>

As output is not defined for condiition when `i0 = 0` & `i2 = 0` , the output latches itself to previous value of `Y` which was `0`.

<div align="center">
  <img src="./Images/6_incmp_if2_cells.png" alt="6_incmp_if2_cells.png" width="800" />
  <p><b>As Expected only 1 Dlatch is Infered by Yosys</b></p>
</div>

<br>


<div align="center">
  <img src="./Images/7_incomp_if2_show.png" alt="7_incomp_if2_show.png" width="1000" />
  <p><b>Graphical Representation of Synthesized Netlist of module incomp_if2</b></p>
</div>

<br>


<div align="center">
  <img src="./Images/7a_incomp_if2_netlist.png" alt="7a_incomp_if2_netlist.png" width="800" />
  <p><b>Synthesized Netlist of module incomp_if2</b></p>
</div>

<br>

---


**Note:**  
- `if` statements and `case` statements are written **inside an always block**.  
- The variables assigned inside must be declared as **reg**.  

---

## 2. Case Statements  

**Introduction:**  
- A case statement compares an expression against multiple possible values.  
- Variants:  
  - `case` → standard case matching.  
  - `casex` → treats `x` and `z` as don’t-care during comparison.  
  - `casez` → treats `z` as don’t-care (but not `x`).  

**Generic Syntax:**  
```verilog
case (expression)  
 value1 : statement1;  
 value2 : statement2;  
 default : statementN;  
endcase
```
**Example of Complete & Good Case:**  

| RTL Code of module comp_case |  Test Bench of module comp_case |
|--------------------------------------------|------------------------------------------|
| <img src="./Images/12a_comp_mux_code.png" alt="12a_comp_mux_code.png" width="500"/> | <img src="./Images/12b_comp_case_tb.png" alt="12b_comp_case_tb.png" width="500"/> | 
<br>

<div align="center">
  <img src="./Images/13_comp_case_gtk_simu.png" alt="13_comp_case_gtk_simu.png" width="1000" />
  <p><b>RTL Simulation Output of module comp_case</b></p>
</div>
<br>

As we can Infer by the above output waveform, there is no latch inferred in the above module. As there is a default statment to cover all inputs and all the outputs are defined.

---






**Important:**  
- Case must also be written inside an always block.  
- The target variables must be declared as **reg**.  

---

### Hazards / Cautions with Case  

1. **Incomplete Case:**  
   - If all possible conditions are not covered (and no `default` is present), it infers a **latch**.  
   - Example: I have simulation and synthesis images for this (will attach).  
   - **Example :**  

| RTL Code of module incomp_case |  Test Bench of module incomp_case |
|--------------------------------------------|------------------------------------------|
| <img src="./Images/8a_incomp_case_code.png" alt="8a_incomp_case_code.png" width="500"/> | <img src="./Images/8b_incomp_case_tb.png" alt="8b_incomp_case_tb.png" width="500"/> | 
<br>

<div align="center">
  <img src="./Images/9a_incomp_case_gtk1_10.png" alt="9a_incomp_case_gtk1_10.png" width="1000" />
  <p><b>RTL Simulation Output</b></p>
</div>
<br>

As output is not defined for condiition when `2'b10` , the output latches itself to previous value of `Y` which was `0`.

<br>

<div align="center">
  <img src="./Images/9b_incomp_case_gtk2_11.png" alt="9b_incomp_case_gtk2_11.png" width="1000" />
  <p><b>RTL Simulation Output</b></p>
</div>
<br>

As output is not defined for condiition when `2'b11` , the output latches itself to previous value of `Y` which was `0`.

<div align="center">
  <img src="./Images/10_incomp_case_cells.png" alt="10_incomp_case_cells.png" width="800" />
  <p><b>As Expected only 1 Dlatch is Infered by Yosys</b></p>
</div>

<br>


<div align="center">
  <img src="./Images/11_incomp_case_show.png" alt="11_incomp_case_show.png" width="1000" />
  <p><b>Graphical Representation of Synthesized Netlist of module incomp_case</b></p>
</div>

<br>


<div align="center">
  <img src="./Images/11a_incomp_case_netlist.png" alt="11a_incomp_case_netlist.png" width="800" />
  <p><b>Synthesized Netlist of module incomp_case</b></p>
</div>

<br>

---


2. **Partial Assignment in Case:**  
   - If in one case branch not all variables are assigned, then the unassigned variable holds its previous value → latch inferred.  
   - **Example :**  

<div align="center">
<img src="./Images/14a_partial_case_assign_code.png" alt="14a_partial_case_assign_code.png" width="500"/> 
  <p><b>RTL Code of module partial_case_assign</b></p>
</div>

<br>

<div align="center">
  <img src="./Images/9a_incomp_case_gtk1_10.png" alt="9a_incomp_case_gtk1_10.png" width="1000" />
  <p><b>RTL Simulation Output</b></p>
</div>
<br>


<div align="center">
  <img src="./Images/15_partial_case_assign_cells.png" alt="15_partial_case_assign_cells.png" width="800" />
  <p><b>As Expected only a single D-latch is Infered by Yosys</b></p>
</div>

<br>


<div align="center">
  <img src="./Images/16_partial_case_assign_show.png" alt="16_partial_case_assign_show.png" width="1000" />
  <p><b>Graphical Representation of Synthesized Netlist of module partial_case_assign</b></p>
</div>

<br>

---


3. **Overlapping Case:**  
   - If two or more case items overlap (like using wildcards `2'b1?`), then multiple matches may occur.  
   - This can cause unintended priority or mismatches between simulation and synthesis.  
   - **Example :**  

| RTL Code of module bad_case |  Test Bench of module bad_case |
|--------------------------------------------|------------------------------------------|
| <img src="./Images/17a_bad_mux_code.png" alt="17a_bad_mux_code.png" width="500"/> | <img src="./Images/17b_bad_mux_tb.png" alt="17b_bad_mux_tb.png" width="500"/> | 
<br>

<div align="center">
  <img src="./Images/18_bad_case_gtk_simu.png" alt="18_bad_case_gtk_simu.png" width="1000" />
  <p><b>RTL Simulation Output</b></p>
</div>
<br>

The output for input `11` depends on the simulator & even synthesizer as this confuses compiler itself and output just latched to its previous value.

<br>

<div align="center">
  <img src="./Images/19_bad_case_cells.png" alt="19_bad_case_cells.png" width="800" />
  <p><b>No Latch is Infered by Yosys</b></p>
</div>

<br>


<div align="center">
  <img src="./Images/20_bad_case_show.png" alt="20_bad_case_show.png" width="1000" />
  <p><b>Graphical Representation of Synthesized Netlist of module bad_case</b></p>
</div>

<br>

<div align="center">
  <img src="./Images/20a_bad_case_netlist.png" alt="20a_bad_case_netlist.png" width="800" />
  <p><b>Synthesized Netlist of module bad_case</b></p>
</div>

<br>

<div align="center">
  <img src="./Images/21_bad_case_GLS_gtk_simu.png" alt="21_bad_case_GLS_gtk_simu.png" width="800" />
  <p><b>Gate Level Simulation output of the Synthesized Netlist</b></p>
</div>

The output for input `11` follows `i3` in the synthesized netlist simulation where as it latched to previous value of output in RTL simulation. Even tough there were no inferred latched, the overlapping cases `2'b1?` caused a Synthesis–Simulation Mismatch.

---


## 3. Looping Constructs  

In Verilog, loops are powerful tools, but they must be used carefully since hardware is not the same as software. Loops in Verilog either **evaluate expressions inside an always block** or **generate repeated hardware structures**.  

---

### (a) `for` Loop  
- **Usage:** Only allowed **inside an always block**.  
- Purpose: To perform repetitive calculations or assignments during simulation.  
- Does **not** create multiple hardware instances, only expands to repeated behavioral code.
- **Generic Syntax:**  

```verilog
always @(posedge clk) begin  
 for (i = 0; i < N; i = i + 1)  
  array[i] = array[i] + 1;  
end  
```

- **Example Synthesizing a Mux using For loop**
  
<div align="center">
<img src="./Images/22a_mux_generate_code.png" alt="14a_partial_case_assign_code.png" width="500"/> 
  <p><b>RTL Code of module mux_generate</b></p>
</div>

<br>

<div align="center">
  <img src="./Images/23_mux_generate_gtk_simu.png" alt="23_mux_generate_gtk_simu.png" width="1000" />
  <p><b>RTL Simulation Output matches that of 4:1 Mux</b></p>
</div>
<br>


<div align="center">
  <img src="./Images/23b_mux_generate_cells.png" alt="23b_mux_generate_cells.png" width="800" />
  <p><b>Cells as Infered by Yosys</b></p>
</div>

<br>


<div align="center">
  <img src="./Images/24_mux_generate_show.png" alt="24_mux_generate_show.png" width="1000" />
  <p><b>Graphical Representation of Synthesized Netlist of module mux_generate</b></p>
</div>

<br>


<div align="center">
  <img src="./Images/24a_mux_generate_netlist.png" alt="24a_mux_generate_netlist.png" width="1000" />
  <p><b>Synthesized Netlist of module mux_generate</b></p>
</div>

<br>

<div align="center">
  <img src="./Images/25_mux_generate_GLS_simu_gtk.png" alt="25_mux_generate_GLS_simu_gtk.png" width="1000" />
  <p><b>Gate Level Simulation of the Synthesized Netlist of module mux_generate</b></p>
</div>

This above output matches with the RTL simulated output of module `mux_generate` which intern matches with a `4:1 Mux`.
<br>

---

### (b) `generate for` Loop  
- **Usage:** Written **outside always blocks**.  
- Purpose: To **instantiate hardware multiple times**.  
- Commonly used for creating arrays of logic gates, adders, multiplexers, decoders, etc.  
- Helps avoid writing repetitive module instantiations.  

**Generic Syntax:**  

```verilog
genvar i;  
generate  
 for (i = 0; i < N; i = i + 1) begin : label  
  module_name instance_name ( .port1(sig1), .port2(sig2) );  
 end  
endgenerate
```

---

### Why We Use Loops in Hardware Design  
- To simplify the description of repetitive structures.  
- **For loop (inside always):** Handles indexing or iterative calculations.  
- **Generate for loop:** Used to build scalable hardware such as:  
  - Multiplexers (e.g., 8:1 mux built using multiple 2:1 muxes).  
  - Decoders and encoders.  
  - Arrays of adders, registers, or flip-flops.  

Example:  
- To design an 8:1 multiplexer using smaller 2:1 multiplexers, we can use a generate loop to instantiate 7 mux modules, automatically wiring them in a tree structure.  

---  

- **Example Demux using case & Loops**
  
<div align="center">
<img src="./Images/26a_demux_code.png" alt="26a_demux_code.png" width="500"/> 
  <p><b>RTL Code of module demux_case</b></p>
</div>

<br>

<div align="center">
  <img src="./Images/26_demux_gtk_sim.png" alt="26_demux_gtk_sim.png" width="1000" />
  <p><b>RTL Simulation Output </b></p>
</div>
<br>


<div align="center">
  <img src="./Images/29demux_case_cells.png" alt="29demux_case_cells.png" width="800" />
  <p><b>Cells as Infered by Yosys</b></p>
</div>

<br>


<div align="center">
  <img src="./Images/28_demux_case_show.png" alt="28_demux_case_show.png" width="1000" />
  <p><b>Graphical Representation of Synthesized Netlist of module demux_generate</b></p>
</div>

<br>

<div align="center">
<img src="./Images/27a_demux_generate_code.png" alt="27a_demux_generate_code.png" width="500"/> 
  <p><b>RTL Code of module demux_generate</b></p>
</div>

<br>

<div align="center">
  <img src="./Images/27_demux_generate_gtk-simu.png" alt="27_demux_generate_gtk-simu.png" width="1000" />
  <p><b>RTL Simulation Output </b></p>
</div>
<br>


<div align="center">
  <img src="./Images/31_demux_gen_cells.png" alt="31_demux_gen_cells.png" width="800" />
  <p><b>Cells as Infered by Yosys</b></p>
</div>

<br>


<div align="center">
  <img src="./Images/30_demux_gene_show.png" alt="30_demux_gene_show.png" width="1000" />
  <p><b>Graphical Representation of Synthesized Netlist of module demux_generate</b></p>
</div>

<br>

As We can observe both RTL simulated outputs & Synthesized netlist of `demux_case` & `demux_generate` the same.

---
- **Example Ripple Carry Adder using Full Adders**
  
<div align="center">
<img src="./Images/26a_demux_code.png" alt="26a_demux_code.png" width="500"/> 
  <p><b>RTL Code of module demux_case</b></p>
</div>

<br>

<div align="center">
  <img src="./Images/26_demux_gtk_sim.png" alt="26_demux_gtk_sim.png" width="1000" />
  <p><b>RTL Simulation Output </b></p>
</div>
<br>


<div align="center">
  <img src="./Images/29demux_case_cells.png" alt="29demux_case_cells.png" width="800" />
  <p><b>Cells as Infered by Yosys</b></p>
</div>

<br>


<div align="center">
  <img src="./Images/28_demux_case_show.png" alt="28_demux_case_show.png" width="1000" />
  <p><b>Graphical Representation of Synthesized Netlist of module demux_generate</b></p>
</div>

<br>

<div align="center">
<img src="./Images/27a_demux_generate_code.png" alt="27a_demux_generate_code.png" width="500"/> 
  <p><b>RTL Code of module demux_generate</b></p>
</div>

<br>

<div align="center">
  <img src="./Images/27_demux_generate_gtk-simu.png" alt="27_demux_generate_gtk-simu.png" width="1000" />
  <p><b>RTL Simulation Output </b></p>
</div>
<br>


<div align="center">
  <img src="./Images/31_demux_gen_cells.png" alt="31_demux_gen_cells.png" width="800" />
  <p><b>Cells as Infered by Yosys</b></p>
</div>

<br>


<div align="center">
  <img src="./Images/30_demux_gene_show.png" alt="30_demux_gene_show.png" width="1000" />
  <p><b>Graphical Representation of Synthesized Netlist of module demux_generate</b></p>
</div>

<br>

As We can observe both RTL simulated outputs & Synthesized netlist of `demux_case` & `demux_generate` the same.


