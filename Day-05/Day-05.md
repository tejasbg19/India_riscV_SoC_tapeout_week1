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

| RTL Code of module partial_case_assign |  
|--------------------------------------------|
| <img src="./Images/14a_partial_case_assign_code.png" alt="14a_partial_case_assign_code.png" width="500"/> | 

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
   - Example images will be attached.  

---
