************************
***Generate variables***
************************

egen decision = seq(), f(1) t(6) b(3)

gen willing_to_contribute = 1 if willing == 1
replace willing_to_contribute = 0 if willing == 2

*Socio-economic variables

replace age = . if age == -999

gen male = 1 if gender == 1
replace male = 0 if gender == 2

gen higher_education = 1 if educat == 4 | educat == 5
replace higher_education = 0 if educat == 1 | educat == 2 | educat == 3 | educat == 6

replace income = . if income == 7 | income == 8 | income == -999

*Other variables

gen conservative = polideo if polideo != -999
replace screen = . if screen == -999

gen live_in_country_with_coral = livecor if livecor != -999

gen dived = divsnor if divsnor != -999

gen donated_to_environment = donated if donated != -999

gen ccquestion_first = ccqfirst if ccqfirst != -999

gen cc_nothappening = 1 if ccbelief == 1
replace cc_nothappening = 0 if ccbelief == 2 | ccbelief == 3 | ccbelief == 4
gen cc_dontknow = 1 if ccbelief == 2
replace cc_dontknow = 0 if ccbelief == 1 | ccbelief == 3 | ccbelief == 4
gen cc_natural = 1 if ccbelief == 3
replace cc_natural = 0 if ccbelief == 1 | ccbelief == 2 | ccbelief == 4
gen cc_human = 1 if ccbelief == 4
replace cc_human = 0 if ccbelief == 1 | ccbelief == 2 | ccbelief == 3

gen concern_cc = concc if concc != -999
gen concern_species = conspeci if conspeci != -999
gen concern_decliningresources = condecl if condecl != -999
gen concern_disasters = connat if connat != -999
gen concern_pollution = conpoll if conpoll != -999
gen concern_politics = conpoli if conpoli != -999
gen concern_terrorism = conterr if conterr != -999
gen concern_crime = concrim if concrim != -999
gen concern_economy = conecon if conecon != -999
gen concern_technology = contech if contech != -999
gen concern_famine = confam if confam != -999
gen concern_disease = condise if condise != -999
gen concern_pandemics = conepid if conepid != -999
gen concern_sociodemographics = condemo if condemo != -999
gen concern_socialinjustice = consoc if consoc != -999

gen total_concern = concern_socialinjustice + concern_sociodemographics + concern_pandemics + concern_disease + concern_famine + concern_technology + concern_economy + concern_crime + concern_terrorism + concern_politics + concern_pollution + concern_disasters + concern_decliningresources + concern_species + concern_cc

gen gdp = 52397.4 if aus == 1
replace gdp = 25067.7 if chl == 1
replace gdp = 17204.4 if chn == 1
replace gdp = 14570.2 if col == 1
replace gdp = 5742.3 if gha == 1
replace gdp = 12068.2 if idn == 1
replace gdp = 41732.9 if jap == 1
replace gdp = 4576.2 if ken == 1
replace gdp = 59334.2 if nld == 1
replace gdp = 44212.9 if nzl == 1
replace gdp = 45852.7 if gbr == 1
replace gdp = 63413.5 if usa == 1

gen log_gdp = log(gdp)

gen gini = 34.4 if aus == 1
replace gini = 44.4 if chl == 1
replace gini = 38.5 if chn == 1
replace gini = 51.3 if col == 1
replace gini = 43.5 if gha == 1
replace gini = 38.2 if idn == 1
replace gini = 32.9 if jap == 1
replace gini = 40.8 if ken == 1
replace gini = 28.1 if nld == 1
replace gini = 36.2 if nzl == 1
replace gini = 35.1 if gbr == 1
replace gini = 41.4 if usa == 1

gen tropical_reef = 1 if aus == 1
replace tropical_reef = 0 if chl == 1
replace tropical_reef = 1 if chn == 1
replace tropical_reef = 1 if col == 1
replace tropical_reef = 0 if gha == 1
replace tropical_reef = 1 if idn == 1
replace tropical_reef = 1 if jap == 1
replace tropical_reef = 1 if ken == 1
replace tropical_reef = 0 if nld == 1
replace tropical_reef = 0 if nzl == 1
replace tropical_reef = 0 if gbr == 1
replace tropical_reef = 1 if usa == 1

gen positive_difference = posdiff if posdiff != -999

gen watch_documentaries = 1 if docu == 1
replace watch_documentaries = 0 if docu == 2
replace watch_documentaries = . if docu == 3 | docu == -999

gen pessimism = optim if optim != -999

gen risk_seeking = riskseek if riskseek != -999

gen patient = patience if patience != -999

gen internal_locus = locus if locus != -999

gen well_spent = wellspen if wellspen != - 999

gen foreign = 1 if (aus == 1 & national != 10) | (chl == 1 & national != 37) | (chn == 1 & national != 38) | (col == 1 & national != 39) | (gha == 1 & national != 67) | (idn == 1 & national != 81) | (jap == 1 & national != 88) | (ken == 1 & national != 91) | (nld == 1 & national != 126) | (nzl == 1 & national != 127) | (gbr == 1 & national != 188) | (usa == 1 & national != 189)
replace foreign = 0 if foreign != 1
replace foreign = . if national == 1

replace wtp = . if wtp == 21 | wtp == -999

****************************
***Descriptive statistics***
****************************

gen country_group = 1 if aus == 1
replace country_group = 2 if chl == 1
replace country_group = 3 if chn == 1
replace country_group = 4 if col == 1
replace country_group = 5 if gha == 1
replace country_group = 6 if idn == 1
replace country_group = 7 if jap == 1
replace country_group = 8 if ken == 1
replace country_group = 9 if nld == 1
replace country_group = 10 if nzl == 1
replace country_group = 11 if gbr == 1
replace country_group = 12 if usa == 1

tabstat willing_to_contribute age male higher_education income patient conservative foreign cc_nothappening cc_dontknow cc_natural cc_human dived donated_to_environment watch_documentaries if finish == 1 & alti == 1 & decision == 1, stat(mean sd count) by(country_group) columns(variables) format(%3.2f)

*Distance from reef

tabstat hubdist if finish == 1 & alti == 1 & decision == 1 & ((aus == 1 & country == "Australia") | (chl == 1 & country == "Chile") | (chn == 1 & country == "China") | (col == 1 & country == "Colombia") | (gha == 1 & country == "Ghana") | (idn == 1 & country == "Indonesia") | (jap == 1 & country == "Japan") | (ken == 1 & country == "Kenya") | (nld == 1 & country == "Netherlands") | (nzl == 1 & country == "New Zealand") | (gbr == 1 & country == "United Kingdom") | (usa == 1 & country == "United States")), stat(mean sd count) by(country_group) columns(variables) format(%3.2f)



*Put into word doc

putdocx clear
putdocx begin

tabstat willing_to_contribute age male higher_education income patient conservative foreign cc_nothappening cc_dontknow cc_natural cc_human dived donated_to_environment watch_documentaries if finish == 1 & alti == 1 & decision == 1, by(country_group) columns(variables) stats(mean sd N) format(%3.2f) save

return list

matrix C1 = r(Stat1)'
matrix C2 = r(Stat2)'
matrix C3 = r(Stat3)'
matrix C4 = r(Stat4)'
matrix C5 = r(Stat5)'
matrix C6 = r(Stat6)'
matrix C7 = r(Stat7)'
matrix C8 = r(Stat8)'
matrix C9 = r(Stat9)'
matrix C10 = r(Stat10)'
matrix C11 = r(Stat11)'
matrix C12 = r(Stat12)'

matrix table = C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12
putdocx table table_1 = matrix(table), rownames colnames nformat(%9.2f)
putdocx save descriptives, replace



*******************************************
***Analysis of willingness to contribute***
*******************************************

gen hubdist_1000 = hubdist/1000

*Pooled

qui logit willing_to_contribute gbr nzl nld ken jap idn gha col chn chl aus if finish == 1 & alti == 1 & decision == 1
estimates store m1 , title(Model 1 Logit)
qui logit willing_to_contribute age male higher_education income foreign patient conservative gbr nzl nld ken jap idn gha col chn chl aus if finish == 1 & alti == 1 & decision == 1
estimates store m2 , title(Model 2 Logit)
qui logit willing_to_contribute age male higher_education income foreign patient conservative cc_nothappening cc_dontknow cc_natural gbr nzl nld ken jap idn gha col chn chl aus if finish == 1 & alti == 1 & decision == 1
estimates store m3 , title(Model 3 Logit)
qui logit willing_to_contribute age male higher_education income foreign patient conservative cc_nothappening cc_dontknow cc_natural dived donated_to_environment watch_documentaries gbr nzl nld ken jap idn gha col chn chl aus if finish == 1 & alti == 1 & decision == 1
estimates store m4 , title(Model 4 Logit)
qui logit willing_to_contribute age male higher_education income foreign patient conservative cc_nothappening cc_dontknow cc_natural dived donated_to_environment watch_documentaries log_gdp tropical_reef if finish == 1 & alti == 1 & decision == 1
estimates store m5 , title(Model 5 Logit)
qui logit willing_to_contribute age male higher_education income foreign patient conservative cc_nothappening cc_dontknow cc_natural dived donated_to_environment watch_documentaries log_gdp hubdist_1000 if finish == 1 & alti == 1 & decision == 1 & ((aus == 1 & country == "Australia") | (chl == 1 & country == "Chile") | (chn == 1 & country == "China") | (col == 1 & country == "Colombia") | (idn == 1 & country == "Indonesia") | (jap == 1 & country == "Japan") | (nld == 1 & country == "Netherlands") | (nzl == 1 & country == "New Zealand") | (gbr == 1 & country == "United Kingdom") | (usa == 1 & country == "United States"))
estimates store m6 , title(Model 6 Logit)

esttab m1 m2 m3 m4 m5 m6, pr2 scalars("ll Log lik.") cells(b(star fmt(3)) se(par fmt(2))) starlevels( † 0.1 * 0.05 ** 0.01 *** 0.001) legend label varlabels(_cons constant) title("Logit regression results")

set more off
drop ( _est_m1 _est_m2 _est_m3 _est_m4 _est_m5 _est_m6 )

*Marginal effects

qui logit willing_to_contribute age male higher_education income foreign patient conservative gbr nzl nld ken jap idn gha col chn chl aus if finish == 1 & alti == 1 & decision == 1
margins, dydx(*)
qui logit willing_to_contribute age male higher_education income foreign patient conservative cc_nothappening cc_dontknow cc_natural gbr nzl nld ken jap idn gha col chn chl aus if finish == 1 & alti == 1 & decision == 1
margins, dydx(*)
qui logit willing_to_contribute age male higher_education income foreign patient conservative cc_nothappening cc_dontknow cc_natural dived donated_to_environment watch_documentaries gbr nzl nld ken jap idn gha col chn chl aus if finish == 1 & alti == 1 & decision == 1
margins, dydx(*)
qui logit willing_to_contribute age male higher_education income foreign patient conservative cc_nothappening cc_dontknow cc_natural dived donated_to_environment watch_documentaries log_gdp tropical_reef if finish == 1 & alti == 1 & decision == 1
margins, dydx(*)
qui logit willing_to_contribute age male higher_education income foreign patient conservative cc_nothappening cc_dontknow cc_natural dived donated_to_environment watch_documentaries log_gdp hubdist_1000 if finish == 1 & alti == 1 & decision == 1 & ((aus == 1 & country == "Australia") | (chl == 1 & country == "Chile") | (chn == 1 & country == "China") | (col == 1 & country == "Colombia") | (idn == 1 & country == "Indonesia") | (jap == 1 & country == "Japan") | (nld == 1 & country == "Netherlands") | (nzl == 1 & country == "New Zealand") | (gbr == 1 & country == "United Kingdom") | (usa == 1 & country == "United States"))
margins, dydx(*)

*Within country marginal effects of distance

qui logit willing_to_contribute age male higher_education income foreign patient conservative cc_nothappening cc_dontknow cc_natural dived donated_to_environment watch_documentaries log_dist if finish == 1 & alti == 1 & decision == 1 & (aus == 1 & country == "Australia")
margins, dydx(*)
qui logit willing_to_contribute age male higher_education income foreign patient conservative cc_nothappening cc_dontknow cc_natural dived donated_to_environment watch_documentaries log_dist if finish == 1 & alti == 1 & decision == 1 & (chn == 1 & country == "China")
margins, dydx(*)
qui logit willing_to_contribute age male higher_education income foreign patient conservative cc_nothappening cc_dontknow cc_natural dived donated_to_environment watch_documentaries log_dist if finish == 1 & alti == 1 & decision == 1 & (col == 1 & country == "Colombia")
margins, dydx(*)
qui logit willing_to_contribute age male higher_education income foreign patient conservative cc_nothappening cc_dontknow cc_natural dived donated_to_environment watch_documentaries log_dist if finish == 1 & alti == 1 & decision == 1 & (idn == 1 & country == "Indonesia")
margins, dydx(*)
qui logit willing_to_contribute age male higher_education income foreign patient conservative cc_nothappening cc_dontknow cc_natural dived donated_to_environment watch_documentaries log_dist if finish == 1 & alti == 1 & decision == 1 & (jap == 1 & country == "Japan")
margins, dydx(*)
qui logit willing_to_contribute age male higher_education income foreign patient conservative cc_nothappening cc_dontknow cc_natural dived donated_to_environment watch_documentaries log_dist if finish == 1 & alti == 1 & decision == 1 & (usa == 1 & country == "United States")
margins, dydx(*)


***********************************************
***Analysis of individual willingness to pay***
***********************************************


*Individual country distributions

keep if willing_to_contribute == 1 & willing == 1 & finish == 1 & alti == 1 & decision == 1 & makech != 6

*Copy-paste individual WTP data

*Transform into actual WTP values

replace wtp_mpa = -wtp_mpa
replace wtp_legis = -wtp_legis

replace wtp_highcc10 = -(wtp_lowcc10+wtp_highcc10)
replace wtp_highcc25 = -(wtp_lowcc25+wtp_highcc25)
replace wtp_highcc40 = -(wtp_lowcc40+wtp_highcc40)
replace wtp_lowcc10 = -wtp_lowcc10
replace wtp_lowcc25 = -wtp_lowcc25
replace wtp_lowcc40 = -wtp_lowcc40

replace wtp_highrf10 = -(wtp_lowrf10+wtp_highrf10)
replace wtp_highrf25 = -(wtp_lowrf25+wtp_highrf25)
replace wtp_highrf40 = -(wtp_lowrf40+wtp_highrf40)
replace wtp_lowrf10 = -wtp_lowrf10
replace wtp_lowrf25 = -wtp_lowrf25
replace wtp_lowrf40 = -wtp_lowrf40

*Kernel plots of conservation measure MPA

qui kdensity wtp_mpa if aus == 1, name(m1, replace)  ytitle("Density", size(3)) xtitle("WTP for MPA", size(3)) title("Australia", size(5)) xlabel(,labsize(small))
qui kdensity wtp_mpa if chl == 1, name(m2, replace)  ytitle("Density", size(3)) xtitle("WTP for MPA", size(3)) title("Chile", size(5)) xlabel(,labsize(small))
qui kdensity wtp_mpa if chn == 1, name(m3, replace)  ytitle("Density", size(3)) xtitle("WTP for MPA", size(3)) title("China", size(5)) xlabel(,labsize(small))
qui kdensity wtp_mpa if col == 1, name(m4, replace)  ytitle("Density", size(3)) xtitle("WTP for MPA", size(3)) title("Colombia", size(5)) xlabel(,labsize(small))
qui kdensity wtp_mpa if gha == 1, name(m5, replace)  ytitle("Density", size(3)) xtitle("WTP for MPA", size(3)) title("Ghana", size(5)) xlabel(,labsize(small))
qui kdensity wtp_mpa if idn == 1, name(m6, replace)  ytitle("Density", size(3)) xtitle("WTP for MPA", size(3)) title("Indonesia", size(5)) xlabel(,labsize(small))
qui kdensity wtp_mpa if jap == 1, name(m7, replace)  ytitle("Density", size(3)) xtitle("WTP for MPA", size(3)) title("Japan", size(5)) xlabel(,labsize(small))
qui kdensity wtp_mpa if ken == 1, name(m8, replace)  ytitle("Density", size(3)) xtitle("WTP for MPA", size(3)) title("Kenya", size(5)) xlabel(,labsize(small))
qui kdensity wtp_mpa if nld == 1, name(m9, replace)  ytitle("Density", size(3)) xtitle("WTP for MPA", size(3)) title("Netherlands", size(5)) xlabel(,labsize(small))
qui kdensity wtp_mpa if nzl == 1, name(m10, replace)  ytitle("Density", size(3)) xtitle("WTP for MPA", size(3)) title("New Zealand", size(5)) xlabel(,labsize(small))
qui kdensity wtp_mpa if gbr == 1, name(m11, replace)  ytitle("Density", size(3)) xtitle("WTP for MPA", size(3)) title("United Kingdom", size(5)) xlabel(,labsize(small))
qui kdensity wtp_mpa if usa == 1, name(m12, replace)  ytitle("Density", size(3)) xtitle("WTP for MPA", size(3)) title("United States", size(5)) xlabel(,labsize(small))

gr combine m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12, title() imargin(.5 .5 .5) rows(4) 

*Kernel plots of conservation measure legislation

qui kdensity wtp_legis if aus == 1, name(m1, replace)  ytitle("Density", size(3)) xtitle("WTP for Legislation", size(3)) title("Australia", size(5)) xlabel(,labsize(small))
qui kdensity wtp_legis if chl == 1, name(m2, replace)  ytitle("Density", size(3)) xtitle("WTP for Legislation", size(3)) title("Chile", size(5)) xlabel(,labsize(small))
qui kdensity wtp_legis if chn == 1, name(m3, replace)  ytitle("Density", size(3)) xtitle("WTP for Legislation", size(3)) title("China", size(5)) xlabel(,labsize(small))
qui kdensity wtp_legis if col == 1, name(m4, replace)  ytitle("Density", size(3)) xtitle("WTP for Legislation", size(3)) title("Colombia", size(5)) xlabel(,labsize(small))
qui kdensity wtp_legis if gha == 1, name(m5, replace)  ytitle("Density", size(3)) xtitle("WTP for Legislation", size(3)) title("Ghana", size(5)) xlabel(,labsize(small))
qui kdensity wtp_legis if idn == 1, name(m6, replace)  ytitle("Density", size(3)) xtitle("WTP for Legislation", size(3)) title("Indonesia", size(5)) xlabel(,labsize(small))
qui kdensity wtp_legis if jap == 1, name(m7, replace)  ytitle("Density", size(3)) xtitle("WTP for Legislation", size(3)) title("Japan", size(5)) xlabel(,labsize(small))
qui kdensity wtp_legis if ken == 1, name(m8, replace)  ytitle("Density", size(3)) xtitle("WTP for Legislation", size(3)) title("Kenya", size(5)) xlabel(,labsize(small))
qui kdensity wtp_legis if nld == 1, name(m9, replace)  ytitle("Density", size(3)) xtitle("WTP for Legislation", size(3)) title("Netherlands", size(5)) xlabel(,labsize(small))
qui kdensity wtp_legis if nzl == 1, name(m10, replace)  ytitle("Density", size(3)) xtitle("WTP for Legislation", size(3)) title("New Zealand", size(5)) xlabel(,labsize(small))
qui kdensity wtp_legis if gbr == 1, name(m11, replace)  ytitle("Density", size(3)) xtitle("WTP for Legislation", size(3)) title("United Kingdom", size(5)) xlabel(,labsize(small))
qui kdensity wtp_legis if usa == 1, name(m12, replace)  ytitle("Density", size(3)) xtitle("WTP for Legislation", size(3)) title("United States", size(5)) xlabel(,labsize(small))

gr combine m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12, title() imargin(.5 .5 .5) rows(4)

*Kernel plots of 10pp. rise coral cover

qui twoway kdensity wtp_lowcc10 if aus == 1 || kdensity wtp_highcc10 if aus == 1, name(m1, replace) ytitle("Density", size(3)) xtitle("WTP for 10 pp. rise coral cover", size(3)) title("Australia", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc10 if chl == 1 || kdensity wtp_highcc10 if chl == 1, name(m2, replace) ytitle("Density", size(3)) xtitle("WTP for 10 pp. rise coral cover", size(3)) title("Chile", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc10 if chn == 1 || kdensity wtp_highcc10 if chn == 1, name(m3, replace) ytitle("Density", size(3)) xtitle("WTP for 10 pp. rise coral cover", size(3)) title("China", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc10 if col == 1 || kdensity wtp_highcc10 if col == 1, name(m4, replace) ytitle("Density", size(3)) xtitle("WTP for 10 pp. rise coral cover", size(3)) title("Colombia", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc10 if gha == 1 || kdensity wtp_highcc10 if gha == 1, name(m5, replace) ytitle("Density", size(3)) xtitle("WTP for 10 pp. rise coral cover", size(3)) title("Ghana", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc10 if idn == 1 || kdensity wtp_highcc10 if idn == 1, name(m6, replace) ytitle("Density", size(3)) xtitle("WTP for 10 pp. rise coral cover", size(3)) title("Indonesia", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc10 if jap == 1 || kdensity wtp_highcc10 if jap == 1, name(m7, replace) ytitle("Density", size(3)) xtitle("WTP for 10 pp. rise coral cover", size(3)) title("Japan", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc10 if ken == 1 || kdensity wtp_highcc10 if ken == 1, name(m8, replace) ytitle("Density", size(3)) xtitle("WTP for 10 pp. rise coral cover", size(3)) title("Kenya", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc10 if nld == 1 || kdensity wtp_highcc10 if nld == 1, name(m9, replace) ytitle("Density", size(3)) xtitle("WTP for 10 pp. rise coral cover", size(3)) title("Netherlands", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc10 if nzl == 1 || kdensity wtp_highcc10 if nzl == 1, name(m10, replace) ytitle("Density", size(3)) xtitle("WTP for 10 pp. rise coral cover", size(3)) title("New Zealand", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc10 if gbr == 1 || kdensity wtp_highcc10 if gbr == 1, name(m11, replace) ytitle("Density", size(3)) xtitle("WTP for 10 pp. rise coral cover", size(3)) title("United Kingdom", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc10 if usa == 1 || kdensity wtp_highcc10 if usa == 1, name(m12, replace) ytitle("Density", size(3)) xtitle("WTP for 10 pp. rise coral cover", size(3)) title("United States", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))

gr combine m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12, title() imargin(.5 .5 .5) rows(4)

*Kernel plots of 25pp. rise coral cover

qui twoway kdensity wtp_lowcc25 if aus == 1 || kdensity wtp_highcc25 if aus == 1, name(m1, replace) ytitle("Density", size(3)) xtitle("WTP for 25 pp. rise coral cover", size(3)) title("Australia", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc25 if chl == 1 || kdensity wtp_highcc25 if chl == 1, name(m2, replace) ytitle("Density", size(3)) xtitle("WTP for 25 pp. rise coral cover", size(3)) title("Chile", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc25 if chn == 1 || kdensity wtp_highcc25 if chn == 1, name(m3, replace) ytitle("Density", size(3)) xtitle("WTP for 25 pp. rise coral cover", size(3)) title("China", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc25 if col == 1 || kdensity wtp_highcc25 if col == 1, name(m4, replace) ytitle("Density", size(3)) xtitle("WTP for 25 pp. rise coral cover", size(3)) title("Colombia", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc25 if gha == 1 || kdensity wtp_highcc25 if gha == 1, name(m5, replace) ytitle("Density", size(3)) xtitle("WTP for 25 pp. rise coral cover", size(3)) title("Ghana", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc25 if idn == 1 || kdensity wtp_highcc25 if idn == 1, name(m6, replace) ytitle("Density", size(3)) xtitle("WTP for 25 pp. rise coral cover", size(3)) title("Indonesia", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc25 if jap == 1 || kdensity wtp_highcc25 if jap == 1, name(m7, replace) ytitle("Density", size(3)) xtitle("WTP for 25 pp. rise coral cover", size(3)) title("Japan", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc25 if ken == 1 || kdensity wtp_highcc25 if ken == 1, name(m8, replace) ytitle("Density", size(3)) xtitle("WTP for 25 pp. rise coral cover", size(3)) title("Kenya", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc25 if nld == 1 || kdensity wtp_highcc25 if nld == 1, name(m9, replace) ytitle("Density", size(3)) xtitle("WTP for 25 pp. rise coral cover", size(3)) title("Netherlands", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc25 if nzl == 1 || kdensity wtp_highcc25 if nzl == 1, name(m10, replace) ytitle("Density", size(3)) xtitle("WTP for 25 pp. rise coral cover", size(3)) title("New Zealand", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc25 if gbr == 1 || kdensity wtp_highcc25 if gbr == 1, name(m11, replace) ytitle("Density", size(3)) xtitle("WTP for 25 pp. rise coral cover", size(3)) title("United Kingdom", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc25 if usa == 1 || kdensity wtp_highcc25 if usa == 1, name(m12, replace) ytitle("Density", size(3)) xtitle("WTP for 25 pp. rise coral cover", size(3)) title("United States", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))

gr combine m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12, title() imargin(.5 .5 .5) rows(4)

*Kernel plots of 40pp. rise coral cover

qui twoway kdensity wtp_lowcc40 if aus == 1 || kdensity wtp_highcc40 if aus == 1, name(m1, replace) ytitle("Density", size(3)) xtitle("WTP for 40 pp. rise coral cover", size(3)) title("Australia", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc40 if chl == 1 || kdensity wtp_highcc40 if chl == 1, name(m2, replace) ytitle("Density", size(3)) xtitle("WTP for 40 pp. rise coral cover", size(3)) title("Chile", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc40 if chn == 1 || kdensity wtp_highcc40 if chn == 1, name(m3, replace) ytitle("Density", size(3)) xtitle("WTP for 40 pp. rise coral cover", size(3)) title("China", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc40 if col == 1 || kdensity wtp_highcc40 if col == 1, name(m4, replace) ytitle("Density", size(3)) xtitle("WTP for 40 pp. rise coral cover", size(3)) title("Colombia", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc40 if gha == 1 || kdensity wtp_highcc40 if gha == 1, name(m5, replace) ytitle("Density", size(3)) xtitle("WTP for 40 pp. rise coral cover", size(3)) title("Ghana", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc40 if idn == 1 || kdensity wtp_highcc40 if idn == 1, name(m6, replace) ytitle("Density", size(3)) xtitle("WTP for 40 pp. rise coral cover", size(3)) title("Indonesia", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc40 if jap == 1 || kdensity wtp_highcc40 if jap == 1, name(m7, replace) ytitle("Density", size(3)) xtitle("WTP for 40 pp. rise coral cover", size(3)) title("Japan", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc40 if ken == 1 || kdensity wtp_highcc40 if ken == 1, name(m8, replace) ytitle("Density", size(3)) xtitle("WTP for 40 pp. rise coral cover", size(3)) title("Kenya", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc40 if nld == 1 || kdensity wtp_highcc40 if nld == 1, name(m9, replace) ytitle("Density", size(3)) xtitle("WTP for 40 pp. rise coral cover", size(3)) title("Netherlands", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc40 if nzl == 1 || kdensity wtp_highcc40 if nzl == 1, name(m10, replace) ytitle("Density", size(3)) xtitle("WTP for 40 pp. rise coral cover", size(3)) title("New Zealand", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc40 if gbr == 1 || kdensity wtp_highcc40 if gbr == 1, name(m11, replace) ytitle("Density", size(3)) xtitle("WTP for 40 pp. rise coral cover", size(3)) title("United Kingdom", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowcc40 if usa == 1 || kdensity wtp_highcc40 if usa == 1, name(m12, replace) ytitle("Density", size(3)) xtitle("WTP for 40 pp. rise coral cover", size(3)) title("United States", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))

gr combine m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12, title() imargin(.5 .5 .5) rows(4)

*Kernel plots of 10pp. rise reef fish

qui twoway kdensity wtp_lowrf10 if aus == 1 || kdensity wtp_highrf10 if aus == 1, name(m1, replace) ytitle("Density", size(3)) xtitle("WTP for 10 pp. rise reef fish", size(3)) title("Australia", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf10 if chl == 1 || kdensity wtp_highrf10 if chl == 1, name(m2, replace) ytitle("Density", size(3)) xtitle("WTP for 10 pp. rise reef fish", size(3)) title("Chile", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf10 if chn == 1 || kdensity wtp_highrf10 if chn == 1, name(m3, replace) ytitle("Density", size(3)) xtitle("WTP for 10 pp. rise reef fish", size(3)) title("China", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf10 if col == 1 || kdensity wtp_highrf10 if col == 1, name(m4, replace) ytitle("Density", size(3)) xtitle("WTP for 10 pp. rise reef fish", size(3)) title("Colombia", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf10 if gha == 1 || kdensity wtp_highrf10 if gha == 1, name(m5, replace) ytitle("Density", size(3)) xtitle("WTP for 10 pp. rise reef fish", size(3)) title("Ghana", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf10 if idn == 1 || kdensity wtp_highrf10 if idn == 1, name(m6, replace) ytitle("Density", size(3)) xtitle("WTP for 10 pp. rise reef fish", size(3)) title("Indonesia", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf10 if jap == 1 || kdensity wtp_highrf10 if jap == 1, name(m7, replace) ytitle("Density", size(3)) xtitle("WTP for 10 pp. rise reef fish", size(3)) title("Japan", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf10 if ken == 1 || kdensity wtp_highrf10 if ken == 1, name(m8, replace) ytitle("Density", size(3)) xtitle("WTP for 10 pp. rise reef fish", size(3)) title("Kenya", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf10 if nld == 1 || kdensity wtp_highrf10 if nld == 1, name(m9, replace) ytitle("Density", size(3)) xtitle("WTP for 10 pp. rise reef fish", size(3)) title("Netherlands", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf10 if nzl == 1 || kdensity wtp_highrf10 if nzl == 1, name(m10, replace) ytitle("Density", size(3)) xtitle("WTP for 10 pp. rise reef fish", size(3)) title("New Zealand", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf10 if gbr == 1 || kdensity wtp_highrf10 if gbr == 1, name(m11, replace) ytitle("Density", size(3)) xtitle("WTP for 10 pp. rise reef fish", size(3)) title("United Kingdom", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf10 if usa == 1 || kdensity wtp_highrf10 if usa == 1, name(m12, replace) ytitle("Density", size(3)) xtitle("WTP for 10 pp. rise reef fish", size(3)) title("United States", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))

gr combine m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12, title() imargin(.5 .5 .5) rows(4)

*Kernel plots of 25pp. rise reef fish

qui twoway kdensity wtp_lowrf25 if aus == 1 || kdensity wtp_highrf25 if aus == 1, name(m1, replace) ytitle("Density", size(3)) xtitle("WTP for 25 pp. rise reef fish", size(3)) title("Australia", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf25 if chl == 1 || kdensity wtp_highrf25 if chl == 1, name(m2, replace) ytitle("Density", size(3)) xtitle("WTP for 25 pp. rise reef fish", size(3)) title("Chile", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf25 if chn == 1 || kdensity wtp_highrf25 if chn == 1, name(m3, replace) ytitle("Density", size(3)) xtitle("WTP for 25 pp. rise reef fish", size(3)) title("China", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf25 if col == 1 || kdensity wtp_highrf25 if col == 1, name(m4, replace) ytitle("Density", size(3)) xtitle("WTP for 25 pp. rise reef fish", size(3)) title("Colombia", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf25 if gha == 1 || kdensity wtp_highrf25 if gha == 1, name(m5, replace) ytitle("Density", size(3)) xtitle("WTP for 25 pp. rise reef fish", size(3)) title("Ghana", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf25 if idn == 1 || kdensity wtp_highrf25 if idn == 1, name(m6, replace) ytitle("Density", size(3)) xtitle("WTP for 25 pp. rise reef fish", size(3)) title("Indonesia", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf25 if jap == 1 || kdensity wtp_highrf25 if jap == 1, name(m7, replace) ytitle("Density", size(3)) xtitle("WTP for 25 pp. rise reef fish", size(3)) title("Japan", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf25 if ken == 1 || kdensity wtp_highrf25 if ken == 1, name(m8, replace) ytitle("Density", size(3)) xtitle("WTP for 25 pp. rise reef fish", size(3)) title("Kenya", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf25 if nld == 1 || kdensity wtp_highrf25 if nld == 1, name(m9, replace) ytitle("Density", size(3)) xtitle("WTP for 25 pp. rise reef fish", size(3)) title("Netherlands", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf25 if nzl == 1 || kdensity wtp_highrf25 if nzl == 1, name(m10, replace) ytitle("Density", size(3)) xtitle("WTP for 25 pp. rise reef fish", size(3)) title("New Zealand", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf25 if gbr == 1 || kdensity wtp_highrf25 if gbr == 1, name(m11, replace) ytitle("Density", size(3)) xtitle("WTP for 25 pp. rise reef fish", size(3)) title("United Kingdom", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf25 if usa == 1 || kdensity wtp_highrf25 if usa == 1, name(m12, replace) ytitle("Density", size(3)) xtitle("WTP for 25 pp. rise reef fish", size(3)) title("United States", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))

gr combine m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12, title() imargin(.5 .5 .5) rows(4)

*Kernel plots of 40pp. rise reef fish

qui twoway kdensity wtp_lowrf40 if aus == 1 || kdensity wtp_highrf40 if aus == 1, name(m1, replace) ytitle("Density", size(3)) xtitle("WTP for 40 pp. rise reef fish", size(3)) title("Australia", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf40 if chl == 1 || kdensity wtp_highrf40 if chl == 1, name(m2, replace) ytitle("Density", size(3)) xtitle("WTP for 40 pp. rise reef fish", size(3)) title("Chile", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf40 if chn == 1 || kdensity wtp_highrf40 if chn == 1, name(m3, replace) ytitle("Density", size(3)) xtitle("WTP for 40 pp. rise reef fish", size(3)) title("China", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf40 if col == 1 || kdensity wtp_highrf40 if col == 1, name(m4, replace) ytitle("Density", size(3)) xtitle("WTP for 40 pp. rise reef fish", size(3)) title("Colombia", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf40 if gha == 1 || kdensity wtp_highrf40 if gha == 1, name(m5, replace) ytitle("Density", size(3)) xtitle("WTP for 40 pp. rise reef fish", size(3)) title("Ghana", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf40 if idn == 1 || kdensity wtp_highrf40 if idn == 1, name(m6, replace) ytitle("Density", size(3)) xtitle("WTP for 40 pp. rise reef fish", size(3)) title("Indonesia", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf40 if jap == 1 || kdensity wtp_highrf40 if jap == 1, name(m7, replace) ytitle("Density", size(3)) xtitle("WTP for 40 pp. rise reef fish", size(3)) title("Japan", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf40 if ken == 1 || kdensity wtp_highrf40 if ken == 1, name(m8, replace) ytitle("Density", size(3)) xtitle("WTP for 40 pp. rise reef fish", size(3)) title("Kenya", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf40 if nld == 1 || kdensity wtp_highrf40 if nld == 1, name(m9, replace) ytitle("Density", size(3)) xtitle("WTP for 40 pp. rise reef fish", size(3)) title("Netherlands", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf40 if nzl == 1 || kdensity wtp_highrf40 if nzl == 1, name(m10, replace) ytitle("Density", size(3)) xtitle("WTP for 40 pp. rise reef fish", size(3)) title("New Zealand", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf40 if gbr == 1 || kdensity wtp_highrf40 if gbr == 1, name(m11, replace) ytitle("Density", size(3)) xtitle("WTP for 40 pp. rise reef fish", size(3)) title("United Kingdom", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))
qui twoway kdensity wtp_lowrf40 if usa == 1 || kdensity wtp_highrf40 if usa == 1, name(m12, replace) ytitle("Density", size(3)) xtitle("WTP for 40 pp. rise reef fish", size(3)) title("United States", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case"))

gr combine m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12, title() imargin(.5 .5 .5) rows(4)






*Aggregate distributions

*Import aggregate WTP data

*Transform into actual WTP values

replace wtp_highcc10 = -(wtp_lowcc10+wtp_highcc10)
replace wtp_highcc25 = -(wtp_lowcc25+wtp_highcc25)
replace wtp_highcc40 = -(wtp_lowcc40+wtp_highcc40)
replace wtp_lowcc10 = -wtp_lowcc10
replace wtp_lowcc25 = -wtp_lowcc25
replace wtp_lowcc40 = -wtp_lowcc40

replace wtp_highrf10 = -(wtp_lowrf10+wtp_highrf10)
replace wtp_highrf25 = -(wtp_lowrf25+wtp_highrf25)
replace wtp_highrf40 = -(wtp_lowrf40+wtp_highrf40)
replace wtp_lowrf10 = -wtp_lowrf10
replace wtp_lowrf25 = -wtp_lowrf25
replace wtp_lowrf40 = -wtp_lowrf40



*Aggregate kernel plots low income

qui twoway kdensity wtp_lowcc10 if low_income == 1 || kdensity wtp_highcc10 if low_income == 1, name(m1, replace) ytitle("Density", size(3)) ylabel(0(5)5) xtitle("WTP for 10 pp. rise coral cover", size(3)) title("", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case") size(2))
qui twoway kdensity wtp_lowcc25 if low_income == 1 || kdensity wtp_highcc25 if low_income == 1, name(m2, replace) ytitle("Density", size(3)) ylabel(0(0.003)0.003) xtitle("WTP for 25 pp. rise coral cover", size(3)) title("", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case") size(2))
qui twoway kdensity wtp_lowcc40 if low_income == 1 || kdensity wtp_highcc40 if low_income == 1, name(m3, replace) ytitle("Density", size(3)) ylabel(0(0.02)0.02) xtitle("WTP for 40 pp. rise coral cover", size(3)) title("", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case") size(2))
qui twoway kdensity wtp_lowrf10 if low_income == 1 || kdensity wtp_highrf10 if low_income == 1, name(m4, replace) ytitle("Density", size(3)) ylabel(0(0.01)0.01) xtitle("WTP for 10 pp. rise reef fish", size(3)) title("", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case") size(2))
qui twoway kdensity wtp_lowrf25 if low_income == 1 || kdensity wtp_highrf25 if low_income == 1, name(m5, replace) ytitle("Density", size(3)) ylabel(0(3.5)3.5) xtitle("WTP for 25 pp. rise reef fish", size(3)) title("", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case") size(2))
qui twoway kdensity wtp_lowrf40 if low_income == 1 || kdensity wtp_highrf40 if low_income == 1, name(m6, replace) ytitle("Density", size(3)) ylabel(0(0.015)0.015) xtitle("WTP for 40 pp. rise reef fish", size(3)) title("", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case") size(2))

gr combine m1 m2 m3 m4 m5 m6 , title() imargin(.5 .5 .5) rows(2) 


*Aggregate kernel plots middle income

qui twoway kdensity wtp_lowcc10 if middle_income == 1 || kdensity wtp_highcc10 if middle_income == 1, name(m1, replace) ytitle("Density", size(3)) ylabel(0(15)15) xtitle("WTP for 10 pp. rise coral cover", size(3)) title("", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case") size(2))
qui twoway kdensity wtp_lowcc25 if middle_income == 1 || kdensity wtp_highcc25 if middle_income == 1, name(m2, replace) ytitle("Density", size(3)) ylabel(0(0.008)0.008) xtitle("WTP for 25 pp. rise coral cover", size(3)) title("", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case") size(2))
qui twoway kdensity wtp_lowcc40 if middle_income == 1 || kdensity wtp_highcc40 if middle_income == 1, name(m3, replace) ytitle("Density", size(3)) ylabel(0(0.02)0.02) xtitle("WTP for 40 pp. rise coral cover", size(3)) title("", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case") size(2))
qui twoway kdensity wtp_lowrf10 if middle_income == 1 || kdensity wtp_highrf10 if middle_income == 1, name(m4, replace) ytitle("Density", size(3)) ylabel(0(0.015)0.015) xtitle("WTP for 10 pp. rise reef fish", size(3)) title("", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case") size(2))
qui twoway kdensity wtp_lowrf25 if middle_income == 1 || kdensity wtp_highrf25 if middle_income == 1, name(m5, replace) ytitle("Density", size(3)) ylabel(0(6)6) xtitle("WTP for 25 pp. rise reef fish", size(3)) title("", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case") size(2))
qui twoway kdensity wtp_lowrf40 if middle_income == 1 || kdensity wtp_highrf40 if middle_income == 1, name(m6, replace) ytitle("Density", size(3)) ylabel(0(0.01)0.01) xtitle("WTP for 40 pp. rise reef fish", size(3)) title("", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case") size(2))

gr combine m1 m2 m3 m4 m5 m6 , title() imargin(.5 .5 .5) rows(2) 


*Aggregate kernel plots high income

qui twoway kdensity wtp_lowcc10 if high_income == 1 || kdensity wtp_highcc10 if high_income == 1, name(m1, replace) ytitle("Density", size(3)) ylabel(0(20)20) xtitle("WTP for 10 pp. rise coral cover", size(3)) title("", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case") size(2))
qui twoway kdensity wtp_lowcc25 if high_income == 1 || kdensity wtp_highcc25 if high_income == 1, name(m2, replace) ytitle("Density", size(3)) ylabel(0(0.008)0.008) xtitle("WTP for 25 pp. rise coral cover", size(3)) title("", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case") size(2))
qui twoway kdensity wtp_lowcc40 if high_income == 1 || kdensity wtp_highcc40 if high_income == 1, name(m3, replace) ytitle("Density", size(3)) ylabel(0(0.015)0.015) xtitle("WTP for 40 pp. rise coral cover", size(3)) title("", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case") size(2))
qui twoway kdensity wtp_lowrf10 if high_income == 1 || kdensity wtp_highrf10 if high_income == 1, name(m4, replace) ytitle("Density", size(3)) ylabel(0(0.03)0.03) xtitle("WTP for 10 pp. rise reef fish", size(3)) title("", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case") size(2))
qui twoway kdensity wtp_lowrf25 if high_income == 1 || kdensity wtp_highrf25 if high_income == 1, name(m5, replace) ytitle("Density", size(3)) ylabel(0(4)4) xtitle("WTP for 25 pp. rise reef fish", size(3)) title("", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case") size(2))
qui twoway kdensity wtp_lowrf40 if high_income == 1 || kdensity wtp_highrf40 if high_income == 1, name(m6, replace) ytitle("Density", size(3)) ylabel(0(0.05)0.05) xtitle("WTP for 40 pp. rise reef fish", size(3)) title("", size(5)) xlabel(,labsize(small)) legend(label(1 "worst-case") label(2 "best-case") size(2))

gr combine m1 m2 m3 m4 m5 m6 , title() imargin(.5 .5 .5) rows(2) 














