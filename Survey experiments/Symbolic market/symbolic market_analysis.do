

*** analysis
foreach var of varlist ceo_ppl_like_me ceo_money ceo_earth ceo_struggle ceo_good {
	reg `var' i.ceo_treat if att==1
	margins , dydx(ceo_treat) post
	eststo m`var'
}


coefplot mceo_ppl_like_me, bylabel(`" "Look out for" "people like me" "') || mceo_money, bylabel (`" "Motivated by" "money" "') || ///
	mceo_earth, bylabel(Down-to-earth) || mceo_struggle, bylabel(`" "Has struggled to" "make ends meet" "') || ///
	mceo_good, bylabel(`" "Very good at" "running company" "') || , vertical byopts(row(1)) ///
	xlabel(1 " ", tlcolor(bg)) ylabel(-30(5)30) subtitle(, color(black) bcolor(gs14)) ///
	ytitle("Difference between Highbrow and Ordinary CEO" "(Negative scores imply Ordinaru CEO scored higher)" "(Scale -100 to 100)") 
graph export "Dropbox/Elites/Elites survey/New data collection/Vignette/Graph/ceo_gs.png", as(png) name("Graph") replace

	
	
	
	
	
foreach var of varlist judge_believe judge_ordinary_ppl judge_evidence judge_knowledge judge_work {
	reg `var' i.judge_treat if att==1
	margins , dydx(judge_treat) post
	eststo m`var'
}


coefplot mjudge_believe, bylabel(`" "Less likely to believe" "someone like me" "') || mjudge_ordinary_ppl, bylabel (`" "On the side of" "ordinary people" "') || ///
	mjudge_evidence, bylabel(`" "Decision based" "only the evidence" "') || mjudge_knowledge, bylabel(`" "Deep knowledge" "of the law" "') || ///
	mjudge_work, bylabel(`" "Had to work hard" "to get where they are" "') || , vertical byopts(row(1)) ///
	xlabel(1 " ", tlcolor(bg)) ylabel(-30(5)30) subtitle(, color(black) bcolor(gs14)) ///
	ytitle("Change in how people see this judge based on their self-presentation" "Scale 0-100") 
graph export "Dropbox/Elites/Elites survey/New data collection/Vignette/Graph/judge.png", as(png) name("Graph") replace


	
	
	
	
	
foreach var of varlist academic_intelligent academic_work academic_useful academic_better academic_listen {
	reg `var' i.academic_treat if att==1 
	margins , dydx(academic_treat) post
	eststo m`var'
}


coefplot macademic_intelligent, bylabel(`" "Very" "Intelligent" "')  || macademic_work, bylabel (`" "Hard" "Working" "') || ///
	macademic_useful, bylabel(`" "Research useful to" "everyone in society" "') || macademic_better, bylabel(`" "Better researcher" "than others" "') || ///
	macademic_listen, bylabel(`" "Listen carefully to" "someone like me" "') || , vertical byopts(row(1)) ///
	xlabel(1 " ",  tlcolor(bg))    ylabel(-20(5)5) ///
	ytitle("Difference between Middle class and Working class academic" "(Negative scores imply Working class person scored higher)" "(Scale -100 to 100)") ///
	subtitle(, color(black) bcolor(gs14)) /*text(-20.6 1 " hey", bcolor(black) fcolor(black) box)*/
graph export "Dropbox/Elites/Elites survey/New data collection/Vignette/Graph/academic_gs.png", as(png) name("Graph") replace






