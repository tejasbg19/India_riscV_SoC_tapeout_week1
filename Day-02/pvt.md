# Understanding the Sky130 Library File Naming Convention

When performing synthesis with Yosys, the user must provide a **Liberty file (`.lib`)**.  
These files contain all the **timing, power, and functional characteristics** of the standard cells for a given PVT (Process, Voltage, Temperature) corner.

One common example is:

`sky130_fd_sc_hd__tt_025C_1v80.lib`


Let us break this name down:

---

## 1. `sky130`
- Refers to the **SkyWater 130nm PDK (Process Design Kit)**.
- Defines that this library belongs to the open-source **SkyWater SKY130 process node**.

---

## 2. `fd`
- Stands for **Foundry**.  
- Indicates that this library has been provided by the foundry as part of the PDK.

---

## 3. `sc`
- Stands for **Standard Cells**.  
- It specifies that the file contains standard cell definitions (logic gates, flip-flops, etc.).

---

## 4. `hd`
- Stands for **High Density**.  
- Sky130 offers multiple “flavors” of cell libraries:
  - `hd`: High Density (smaller cells, lower power, but slower).
  - `hs`: High Speed (larger cells, higher performance, but more power/area).
  - `lp`: Low Power.
  - `ms`: Medium Speed/Balance.
- The user can choose libraries depending on whether the design targets **area, power, or performance**.

---

## 5. `tt`
- Refers to the **Process Corner**: **Typical-Typical (TT)**.
- Process corners capture manufacturing variations:
  - `tt` → Typical NMOS & PMOS transistors.
  - `ff` → Fast NMOS & Fast PMOS (devices stronger, faster).
  - `ss` → Slow NMOS & Slow PMOS (devices weaker, slower).

---

## 6. `025C`
- Refers to the **Temperature Corner**: **25°C**.
- Cell behavior is affected by operating temperature, so libraries are provided at different temperatures (e.g., -40°C, 25°C, 125°C).

---

## 7. `1v80`
- Refers to the **Voltage Corner**: **1.80 V** supply.
- Libraries are provided for different voltages (e.g., 1.60V, 1.80V), since delay and power depend on supply voltage.

---

# Example: `sky130_fd_sc_hd__tt_025C_1v80.lib`

- **Process Node:** SkyWater 130nm  
- **Library Source:** Foundry-provided  
- **Cell Type:** Standard Cells  
- **Variant:** High Density  
- **Process Corner:** Typical-Typical (TT)  
- **Temperature:** 25°C  
- **Voltage:** 1.8V  

This means the file contains **characterized timing/power data for High Density standard cells at 1.8V and 25°C in a Typical Process corner**.

---

## Why It Matters in Synthesis

When the user runs Yosys synthesis, the `.lib` file tells the tool:
- Which cells are available.  
- What delay, power, and area characteristics those cells have.  
- How the cells behave under the specified PVT conditions.  

Choosing the correct `.lib` ensures that the synthesized design is realistic and **meets timing, power, and area constraints** in the target environment.

---
<!--
<div align="center">
  <img src="./Images/lib_parts.png" alt="lib_file_breakdown" width="700" />
  <p><b>Breakdown of a Liberty File Naming Convention</b></p>
</div>
-->
