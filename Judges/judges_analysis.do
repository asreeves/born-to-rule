*** Judges



** specify file directory


foreach num of numlist 1 2 3 4 5 {
	clear all
	qui import delimited "judges.csv", clear
	encode party_appointed, g(party_app)
	recode party_app (1=0) (2=1)
	qui rename * *_j`num'
	qui gen judge`num'=justice_id_uksc
	drop if judge`num'==.
	save "uksc_ww_j`num'0.dta", replace
}




clear all
import delimited "uksc_decided_sheet1.csv", varnames(1) clear
duplicates drop caseid, force
merge 1:1 caseid using "left_outcomes.dta"
drop _merge
merge 1:1 caseid using "uksc_decided_sheet2.dta"
drop _merge
merge m:1 judge1 using "uksc_ww_j1.dta"
drop _merge
merge m:1 judge2 using "uksc_ww_j2.dta"
drop _merge
merge m:1 judge3 using "uksc_ww_j3.dta"
drop _merge



encode apptype, g(t1)
recode t1 (5 6 7 = 0) (4 8 10=1) (3=2) (2=3) (1=4) (9=5), g(apptype_v2)
label define apptype_v2 0 "Central Govt" 1 "Local Govt" 2 "Company" 3 "Association" 4 "Individual" 5 "NA"
label value apptype_v2 apptype_v2
drop t1

encode resptype, g(t1)
recode t1 (5 6 7 = 0) (4 8 10=1) (3=2) (2=3) (1=4) (9=5), g(resptype_v2)
label define resptype_v2 0 "Central Govt" 1 "Local Govt" 2 "Company" 3 "Association" 4 "Individual" 5 "NA"
label value resptype_v2 resptype_v2
drop t1


foreach num of numlist 1/20 101/109 {
	gen j`num' = 1 if (judge1==`num' | judge2==`num' | judge3==`num')
	
}


gen date_case = date(handdown,"YMD")
gen year = year(date_case)



gen left_out = 1 if  leftoutcomereached=="Yes"
replace left_out = 0 if leftoutcomereached=="No"



egen n_top1 = rowtotal(probate_top_par_1r_j1 probate_top_par_1r_j2 probate_top_par_1r_j3)

recode n_top1 (1/3=1), g(n_top1_c2)


reg left_out i.n_top1_c2 


