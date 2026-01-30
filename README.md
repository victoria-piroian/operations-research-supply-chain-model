# WARP Shoe Production Optimization (Linear Programming)

## Overview
This project formulates and solves a large-scale linear programming (LP) model to determine the most profitable monthly production plan for the WARP Shoe Company. Using real operational data, the model decides how many pairs of each shoe type to produce while satisfying raw material limits, machine operating time, warehouse capacity, and demand constraints.

The model is implemented in **AMPL** and solved using the **Gurobi Optimizer**.

## Problem Description
At the start of 2006, a major competitor of WARP Shoe went bankrupt, leading analysts to predict that demand for all shoe types would double in February 2006. Management asked for an optimal production plan that maximizes profit while accounting for:

- Raw material budgets and availability  
- Machine operating time limits  
- Labor costs  
- Warehouse storage capacity  
- Product demand limits  
- Penalty for unmet demand  

> Transportation costs, setup costs, and manufacturing sequence are assumed negligible.

## Decision Variables
**xᵢ** : Number of pairs of shoe type *i* produced in February 2006

## Objective
Maximize total monthly profit:

- Revenue from shoe sales  
- Minus machine operating costs  
- Minus labor costs  
- Minus warehouse operating costs  
- Minus raw material costs  
- Minus penalty for unmet demand

## Constraints
- Raw material budget ≤ $10,000,000  
- Raw material availability limits  
- Machine operating time (per machine, per month)  
- Warehouse storage capacity  
- Production ≤ (2 × historical demand)  
- Non-negativity  

## Model Size
- 557 decision variables  
- 1,353 constraints  

> The model was originally formulated as an integer program but was relaxed to an LP to obtain solutions within reasonable time.

## Results
**Optimal Profit:** $10,998,247.21  

Additional observations:

- 330 shoe types are not produced in the optimal solution  
- Binding constraints include:
  - Raw material limits  
  - Demand limits  
  - Non-negativity constraints  

## Sensitivity Analyses
**Machines Limited to 8 Hours/Day**  
- No change in optimal profit or production plan  

**Raw Material Budget Increased to $17M**  
- No change in optimal profit or production plan  

**Additional Warehouse Space at $10 per Unit**  
- Not economical to purchase (warehouse capacity is non-binding)

## How to Run
1. Install **AMPL** and **Gurobi**  
2. Place all files in the same directory  
3. Open AMPL and run:
```ampl
model WS_2022_ORG.mod;
data WS_2022.dat;
solve;
display x;
```

### For Sensitivity analyses:
```
model WS_2022_Q6.mod;
data WS_2022.dat;
solve;
```
```
model WS_2022_Q7.mod;
data WS_2022.dat;
solve;
```

## Tools Used

- AMPL
- Gurobi Optimizer
- Microsoft Access (data preprocessing)
