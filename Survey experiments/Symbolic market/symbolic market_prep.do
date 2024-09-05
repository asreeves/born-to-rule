***** Vignette experiment



clear all

*specify file path

****
clear all
import delimited "prolific_export_64183c8d673e5b6ce32c7813.csv"
destring age, force replace

save "demographics.dta", replace




clear all
import excel "ordinariness-vignette-partial.xls", sheet("ordinariness-vignette_March 20,") firstrow
save "ordinariness-vignette-partial.dta", replace

clear all
import excel "ordinariness-vignette_complete.xls", sheet("ordinariness-vignette_March 20,") firstrow

append using "ordinariness-vignette-partial.dta"

rename *, lower

drop if status=="Survey Preview"

keep if progress>90


rename q17 participantid
duplicates tag participantid, g(tag)
drop in 434
drop in 94


merge 1:1 participantid using "demographics.dta"



** treat
gen ceo_treat = 0 if q5_1!=.
replace ceo_treat = 1 if q19_1!=.

gen judge_treat = 0 if q13_1!=.
replace judge_treat = 1 if q20_1!=.

gen academic_treat = 0 if q16_1!=.
replace academic_treat = 1 if q21_1!=.

** attention checks
rename ac att_ceo
gen att = 1 if att_ceo=="A CEO" & q18=="An Academic"

/*
q17 // ceo
q18 // academic
*/

*** new dv
gen ceo_ppl_like_me = q5_1
replace ceo_ppl_like_me = q19_1 if ceo_ppl_like_me==.

gen ceo_money = q5_2
replace ceo_money = q19_2 if ceo_money==.

gen ceo_earth = q5_3
replace ceo_earth = q19_3 if ceo_earth==.

gen ceo_struggle = q5_4
replace ceo_struggle = q19_4 if ceo_struggle==.

gen ceo_good = q5_5
replace ceo_good = q19_5 if ceo_good==.



gen judge_believe = q13_1
replace judge_believe = q20_1 if judge_believe==.

gen judge_ordinary_ppl = q13_2
replace judge_ordinary_ppl = q20_2 if judge_ordinary_ppl==.

gen judge_evidence = q13_3
replace judge_evidence = q20_3 if judge_evidence==.

gen judge_knowledge = q13_4
replace judge_knowledge = q20_4 if judge_knowledge==.

gen judge_work = q13_5
replace judge_work = q20_5 if judge_work==.




gen academic_intelligent = q16_1
replace academic_intelligent = q21_1 if academic_intelligent==.

gen academic_work = q16_2
replace academic_work = q21_2 if academic_work==.

gen academic_useful = q16_3
replace academic_useful = q21_3 if academic_useful==.

gen academic_better = q16_4
replace academic_better = q21_4 if academic_better==.

gen academic_listen = q16_5
replace academic_listen = q21_5 if academic_listen==.


*** recode dvs

foreach var of varlist ceo_ppl_like_me ceo_money ceo_earth ceo_struggle ceo_good ///
	academic_intelligent academic_work academic_useful academic_better academic_listen ///
	judge_believe judge_ordinary_ppl judge_evidence judge_knowledge judge_work {
	recode `var' (0/64=0) (65/100=1), g(`var'_c2)
}




**** controls

gen gender = 0 if sex=="Male"
replace gender =1 if sex=="Female"

label define gender 0 "Male" 1 "Female"
label values gender gender


gen emp = 0 
replace emp = 1 if employmentstatus=="Full-Time" | employmentstatus=="Part-Time" 


egen very_little_move = rowmean(ceo_treat ceo_ppl_like_me ceo_money ceo_earth ceo_struggle ceo_good judge_believe judge_ordinary_ppl judge_evidence judge_knowledge judge_work academic_intelligent academic_work academic_useful academic_better academic_listen)


recode very_little_move (0/49.9999999999 50.000000001/100=0) (50=1)

gen sample_restricted = 1 if nationality=="United Kingdom" & strpos(language, "English") & studentstatus!="Yes" 


recode age (18/29=0) (30/39=1) (40/49=2) (50/59=3) (60/100=4), g(age_cat)

