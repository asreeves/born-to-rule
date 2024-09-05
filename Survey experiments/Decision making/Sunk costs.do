*** analysis of vignette experiment in YouGov

clear all

* specify directory

import delimited "UniversityofOxford_ResultsWave1_230418_CLIENT.csv"


gen sunk_costs = 1 if exp2a==1 
replace sunk_costs = 1 if exp2b==1
replace sunk_costs = 0 if exp2a==2
replace sunk_costs = 0 if exp2b==2

tab sunk_costs

gen sunk_cost_capital = 1 if split_exp2==1
replace sunk_cost_capital = 0 if split_exp2==2

reg sunk_costs i.sunk_cost_capital
