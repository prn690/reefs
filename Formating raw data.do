
*Import csv

***********************************
***Formating raw experiment data***
***********************************

rename sys_respnum id

reshape long cbc_random, i(id) j(decision)

drop decision

gen cont = 1 if cbc_random != .
replace cont = 0 if cbc_random == .

gen alti1 = 1
gen alti2 = 2
gen alti3 = 3

egen iddrop = seq()

reshape long alti, i(iddrop) j(decision)

drop iddrop

drop decision

gen cset = 3

order cont id alti cset cbc_random sys_cbcversion_cbc

rename sys_cbcversion_cbc version

gen choice = .

order cont id alti cset choice cbc_random version

replace choice = 1 if alti == 1 & cbc_random == 1
replace choice = 1 if alti == 2 & cbc_random == 2
replace choice = 1 if alti == 3 & cbc_random == 3
replace choice = 0 if alti == 1 & cbc_random == 2
replace choice = 0 if alti == 1 & cbc_random == 3
replace choice = 0 if alti == 2 & cbc_random == 1
replace choice = 0 if alti == 2 & cbc_random == 3
replace choice = 0 if alti == 3 & cbc_random == 1
replace choice = 0 if alti == 3 & cbc_random == 2

gen meas = .
gen cc = .
gen rf = .
gen fee = .

*Export DCE design for each country - Go to DCE/Survey/folder of country - Open design in excel - copy and paste attributes into stata

gen mpa = 1 if meas == 2
replace mpa = 0 if meas != 2

gen rest = 1 if meas == 3
replace rest = 0 if meas != 3

gen legis = 1 if meas == 4
replace legis = 0 if meas != 4

gen cchigh = 1 if cc == 4 & alti == 3
replace cchigh = 0 if cchigh == .
egen d = seq(), f(1) b(3)
sort d
by d: egen cchigh1 = total(cchigh)
drop d cchigh
rename cchigh1 cchigh

gen rfhigh = 1 if rf == 4 & alti == 3
replace rfhigh = 0 if rfhigh == .
egen d = seq(), f(1) b(3)
sort d
by d: egen rfhigh1 = total(rfhigh)
drop d rfhigh
rename rfhigh1 rfhigh

gen d_cc_10 = 1 if cc == 3 & (alti == 1 | alti == 2) & cchigh == 1
replace d_cc_10 = 1 if cc == 6 & (alti == 1 | alti == 2) & cchigh == 0
replace d_cc_10 = 0 if d_cc_10 == .

gen d_cc_25 = 1 if cc == 2 & (alti == 1 | alti == 2) & cchigh == 1
replace d_cc_25 = 1 if cc == 5 & (alti == 1 | alti == 2) & cchigh == 0
replace d_cc_25 = 0 if d_cc_25 == .

gen d_cc_40 = 1 if cc == 1 & (alti == 1 | alti == 2) & cchigh == 1
replace d_cc_40 = 1 if cc == 4 & (alti == 1 | alti == 2) & cchigh == 0
replace d_cc_40 = 0 if d_cc_40 == .

gen d_rf_10 = 1 if rf == 3 & (alti == 1 | alti == 2) & rfhigh == 1
replace d_rf_10 = 1 if rf == 6 & (alti == 1 | alti == 2) & rfhigh == 0
replace d_rf_10 = 0 if d_rf_10 == .

gen d_rf_25 = 1 if rf == 2 & (alti == 1 | alti == 2) & rfhigh == 1
replace d_rf_25 = 1 if rf == 5 & (alti == 1 | alti == 2) & rfhigh == 0
replace d_rf_25 = 0 if d_rf_25 == .

gen d_rf_40 = 1 if rf == 1 & (alti == 1 | alti == 2) & rfhigh == 1
replace d_rf_40 = 1 if rf == 4 & (alti == 1 | alti == 2) & rfhigh == 0
replace d_rf_40 = 0 if d_rf_40 == .

replace mpa = -999 if alti == 3
replace rest = -999 if alti == 3
replace legis = -999 if alti == 3
replace d_cc_10 = -999 if alti == 3
replace d_cc_25 = -999 if alti == 3
replace d_cc_40 = -999 if alti == 3
replace d_rf_10 = -999 if alti == 3
replace d_rf_25 = -999 if alti == 3
replace d_rf_40 = -999 if alti == 3
replace fee = -999 if alti == 3

order cont id cchigh rfhigh alti cset choice mpa rest legis d_cc_10 d_cc_25 d_cc_40 d_rf_10 d_rf_25 d_rf_40 fee

*AU$15, AU$30, AU$60, AU$80, AU$140, AU$190 or AU$280

gen feeaus = fee
replace feeaus = 15 if fee == 2
replace feeaus = 30 if fee == 3
replace feeaus = 60 if fee == 4
replace feeaus = 80 if fee == 5
replace feeaus = 140 if fee == 6
replace feeaus = 190 if fee == 7
replace feeaus = 280 if fee == 8

gen feeaus_usd = (65279.5*feeaus)/(52203.10000*1.40057) if feeaus != -999
replace feeaus_usd = -999 if feeaus == -999

*CLP$4.200, CLP$8.300, CLP$17.000, CLP$25.000, CLP$42.000, CLP$58.000 or CLP$83.000

gen feechl = fee
replace feechl = 4200 if fee == 2
replace feechl = 8300 if fee == 3
replace feechl = 17000 if fee == 4
replace feechl = 25000 if fee == 5
replace feechl = 42000 if fee == 6
replace feechl = 58000 if fee == 7
replace feechl = 83000 if fee == 8

gen feechl_usd = (65279.5*feechl)/(26247.4*835.925) if feechl != -999
replace feechl_usd = -999 if feechl == -999

*¥20, ¥40, ¥80, ¥120, ¥200, ¥290 or ¥410

gen feechn = fee
replace feechn = 20 if fee == 2
replace feechn = 40 if fee == 3
replace feechn = 80 if fee == 4
replace feechn = 120 if fee == 5
replace feechn = 200 if fee == 6
replace feechn = 290 if fee == 7
replace feechn = 410 if fee == 8

gen feechn_usd = (65279.5*feechn)/(16846.8*6.38458) if feechn != -999
replace feechn_usd = -999 if feechn == -999

*COL$12.000, COL$24.000, COL$48.000, COL$71.000, COL$120.000, COL$170.000 or COL$240.000

gen feecol = fee
replace feecol = 12000 if fee == 2
replace feecol = 24000 if fee == 3
replace feecol = 48000 if fee == 4
replace feecol = 71000 if fee == 5
replace feecol = 120000 if fee == 6
replace feecol = 170000 if fee == 7
replace feecol = 240000 if fee == 8

gen feecol_usd = (65279.5*feecol)/(15630.1*4008.32) if feecol != -999
replace feecol_usd = -999 if feecol == -999

*GH₵5, GH₵15, GH₵25, GH₵40, GH₵60, GH₵90 or GH₵130

gen feegha = fee
replace feegha = 5 if fee == 2
replace feegha = 15 if fee == 3
replace feegha = 25 if fee == 4
replace feegha = 40 if fee == 5
replace feegha = 60 if fee == 6
replace feegha = 90 if fee == 7
replace feegha = 130 if fee == 8

gen feegha_usd = (65279.5*feegha)/(5604.1*6.0998) if feegha != -999
replace feegha_usd = -999 if feegha == -999

*Rp 33.000, Rp 67.000, Rp 130.000, Rp 200.000, Rp 330.000, Rp 470.000 or Rp 670.000

gen feeidn = fee
replace feeidn = 33000 if fee == 2
replace feeidn = 67000 if fee == 3
replace feeidn = 130000 if fee == 4
replace feeidn = 200000 if fee == 5
replace feeidn = 330000 if fee == 6
replace feeidn = 470000 if fee == 7
replace feeidn = 670000 if fee == 8

gen feeidn_usd = (65279.5*feeidn)/(12312.6*14340.9) if feeidn != -999
replace feeidn_usd = -999 if feeidn == -999

*Ksh 100, Ksh 190, Ksh 380, Ksh 570, Ksh 960, Ksh 1,300 or Ksh 1,900

gen feeken = fee
replace feeken = 100 if fee == 2
replace feeken = 190 if fee == 3
replace feeken = 380 if fee == 4
replace feeken = 570 if fee == 5
replace feeken = 960 if fee == 6
replace feeken = 1300 if fee == 7
replace feeken = 1900 if fee == 8

gen feeken_usd = (65279.5*feeken)/(4513*111.586) if feeken != -999
replace feeken_usd = -999 if feeken == -999

*¥910, ¥1,800, ¥3,600, ¥5,500, ¥9,100, ¥13,000 or ¥18,000

gen feejpn = fee
replace feejpn = 910 if fee == 2
replace feejpn = 1800 if fee == 3
replace feejpn = 3600 if fee == 4
replace feejpn = 5500 if fee == 5
replace feejpn = 9100 if fee == 6
replace feejpn = 13000 if fee == 7
replace feejpn = 18000 if fee == 8

gen feejpn_usd = (65279.5*feejpn)/(42338*113.59) if feejpn != -999
replace feejpn_usd = -999 if feejpn == -999

*€10, €20, €40, €60, €100, €140 or €200

gen feenld = fee
replace feenld = 10 if fee == 2
replace feenld = 20 if fee == 3
replace feenld = 40 if fee == 4
replace feenld = 60 if fee == 5
replace feenld = 100 if fee == 6
replace feenld = 140 if fee == 7
replace feenld = 200 if fee == 8

gen feenld_usd = (65279.5*feenld)/(59469.1*0.88654) if feenld != -999
replace feenld_usd = -999 if feenld == -999

*NZ$10, NZ$25, NZ$50, NZ$70, NZ$120, NZ$170 or NZ$250

gen feenzl = fee
replace feenzl = 10 if fee == 2
replace feenzl = 25 if fee == 3
replace feenzl = 50 if fee == 4
replace feenzl = 70 if fee == 5
replace feenzl = 120 if fee == 6
replace feenzl = 170 if fee == 7
replace feenzl = 250 if fee == 8

gen feenzl_usd = (65279.5*feenzl)/(44251.8*1.46621) if feenzl != -999
replace feenzl_usd = -999 if feenzl == -999

*£5, £15, £30, £40, £70, £100 or £140

gen feegbr = fee
replace feegbr = 5 if fee == 2
replace feegbr = 15 if fee == 3
replace feegbr = 30 if fee == 4
replace feegbr = 40 if fee == 5
replace feegbr = 70 if fee == 6
replace feegbr = 100 if fee == 7
replace feegbr = 140 if fee == 8

gen feegbr_usd = (65279.5*feegbr)/(48438.6*0.75052) if feegbr != -999
replace feegbr_usd = -999 if feegbr == -999

*US$10, US$25, US$50, US$70, US$120, US$170 or US$250

gen feeusa = fee
replace feeusa = 10 if fee == 2
replace feeusa = 25 if fee == 3
replace feeusa = 50 if fee == 4
replace feeusa = 70 if fee == 5
replace feeusa = 120 if fee == 6
replace feeusa = 170 if fee == 7
replace feeusa = 250 if fee == 8

gen feeusa_usd = feeusa if feeusa != -999
replace feeusa_usd = -999 if feeusa == -999

***Rename variables

replace choice = -999 if choice == .

rename d_cc_10 d_cc10
rename d_cc_25 d_cc25
rename d_cc_40 d_cc40
rename d_rf_10 d_rf10
rename d_rf_25 d_rf25
rename d_rf_40 d_rf40

drop cbc_random

order cont id cchigh rfhigh alti cset choice mpa rest legis d_cc10 d_cc25 d_cc40 d_rf10 d_rf25 d_rf40 fee feeusa feeusa_usd meas cc rf

*Rename currency as local

rename feeusa feeloc

*Rename USD

rename feeusa_usd feeusd

*Continue renaming other variables

replace version = -999 if version == .

rename sys_starttime start
rename sys_endtime end
rename sys_elapsed time 
drop sys_sumpagetimes
drop sys_starttimestamp sys_endtimestamp
drop sys_datasource
drop sys_respstatus
drop sys_dispositioncode

rename sys_lastquestion finish
replace finish = "1" if finish == "Terminate"
replace finish = "0" if finish != "1"
destring finish, replace

drop sys_userjavascript sys_useragent

rename sys_operatingsystem op_sys

rename sys_browser sys_br

rename sys_ipaddress ip

rename sys_screenwidth screen

drop sys_capideviceid

drop sys_pagetime_1 sys_pagetime_2 sys_pagetime_3 sys_pagetime_4 sys_pagetime_5 sys_pagetime_6 sys_pagetime_7 sys_pagetime_8 sys_pagetime_9 sys_pagetime_10 sys_pagetime_11 sys_pagetime_12 sys_pagetime_13 sys_pagetime_14 sys_pagetime_15 sys_pagetime_16 sys_pagetime_17 sys_pagetime_18 sys_pagetime_19 sys_pagetime_20 sys_pagetime_21 sys_pagetime_22 sys_pagetime_23 sys_pagetime_24 sys_pagetime_25 sys_pagetime_26 sys_pagetime_27 sys_pagetime_28 sys_pagetime_29 sys_pagetime_30 sys_pagetime_31 sys_pagetime_32 sys_pagetime_33 sys_pagetime_34 sys_pagetime_35 sys_pagetime_36 sys_pagetime_37 sys_pagetime_38 sys_pagetime_39 sys_pagetime_40 sys_pagetime_41 sys_pagetime_42 sys_pagetime_43 sys_pagetime_44 sys_pagetime_45 sys_pagetime_46 sys_pagetime_47

drop sys_cbcdesignid_cbc sys_block_set_1

rename agreement agree
replace agree = 0 if agree == 2
replace agree = -999 if agree == .

rename q0 livecor
replace livecor = 0 if livecor == 2
replace livecor = -999 if livecor == 3
replace livecor = -999 if livecor == .

rename q1 divsnor
replace divsnor = 0 if divsnor == 2
replace divsnor = -999 if divsnor == .

rename q1a divtimes
replace divtimes = -999 if divtimes == .

rename q2_1 expglass
replace expglass = -999 if expglass == .
rename q2_2 expfish
replace expfish = -999 if expfish == .
rename q2_3 expswim
replace expswim = -999 if expswim == .
rename q2_4 expsurf
replace expsurf = -999 if expsurf == .
rename q2_5 expother
replace expother = -999 if expother == .
rename q2_6 expno
replace expno = -999 if expno == .

rename q2_5_other expspec
replace expspec = "-999" if expspec == ""

gen donated = 1 if firstq4 == 1 | secondq4 == 1
replace donated = 0 if firstq4 == 2 | secondq4 == 2
replace donated = -999 if donated == .
drop firstq4 secondq4

gen doamount = q4a1 if q4a == .
replace doamount = q4a if q4a1 == .
replace doamount = -999 if doamount == .
drop q4a1 q4a

gen ccqfirst = 1 if firstq3 != .
replace ccqfirst = 0 if secondq3 != .
replace ccqfirst = -999 if ccqfirst == .

gen ccbelief = firstq3 if secondq3 == .
replace ccbelief = secondq3 if firstq3 == .
replace ccbelief = -999 if ccbelief == .
drop firstq3 secondq3

gen cchuman = firstq3a if secondq3a == .
replace cchuman = secondq3a if firstq3a == .
replace cchuman = -999 if cchuman == .
drop firstq3a secondq3a

rename q5 willing
replace willing = -999 if willing == .

replace wtp = -999 if wtp == .

rename q12 makech
replace makech = -999 if makech == .

rename q12_8_other makespec
replace makespec = "-999" if makespec == ""

rename q13toq16_r1 impcons
replace impcons = -999 if impcons == .
rename q13toq16_r2 impcc
replace impcc = -999 if impcc == .
rename q13toq16_r3 imprf
replace imprf = -999 if imprf == .
rename q13toq16_r4 impcont
replace impcont = -999 if impcont == .

rename q17 prefcont
replace prefcont = -999 if prefcont == .

rename q17_4_other prefspec
replace prefspec = "-999" if prefspec == ""

rename q18 prefpay
replace prefpay = -999 if prefpay == .

rename q18_5_other payspec
replace payspec = "-999" if payspec == ""

rename q991 effmpa
replace effmpa = -999 if effmpa == .
rename q992 effrest
replace effrest = -999 if effrest == .
rename q993 efflegis
replace efflegis = -999 if efflegis == .

rename q19_1 respgov
replace respgov = -999 if respgov == .
rename q19_2 respintb
replace respintb = -999 if respintb == .
rename q19_3 respngo
replace respngo = -999 if respngo == .
rename q19_4 respcomm
replace respcomm = -999 if respcomm == .
rename q19_5 respind
replace respind = -999 if respind == .
rename q19_6 resptour
replace resptour = -999 if resptour == .
rename q19_7 respfish
replace respfish = -999 if respfish == .
rename q19_8 resppriv
replace resppriv = -999 if resppriv == .
rename q19_9 respothe
replace respothe = -999 if respothe == .
rename q19_10 respnone
replace respnone = -999 if respnone == .

rename q19_9_other respspec
replace respspec = "-999" if respspec == ""

rename q20toq34_r1 concc
replace concc = -999 if concc == .
rename q20toq34_r2 conspeci
replace conspeci = -999 if conspeci == .
rename q20toq34_r3 condecl
replace condecl = -999 if condecl == .
rename q20toq34_r4 connat
replace connat = -999 if connat == .
rename q20toq34_r5 conpoll
replace conpoll = -999 if conpoll == .
rename q20toq34_r6 conpoli
replace conpoli = -999 if conpoli == .
rename q20toq34_r7 conterr
replace conterr = -999 if conterr == .
rename q20toq34_r8 concrim
replace concrim = -999 if concrim == .
rename q20toq34_r9 conecon
replace conecon = -999 if conecon == .
rename q20toq34_r10 contech
replace contech = -999 if contech == .
rename q20toq34_r11 confam
replace confam = -999 if confam == .
rename q20toq34_r12 condise
replace condise = -999 if condise == .
rename q20toq34_r13 conepid
replace conepid = -999 if conepid == .
rename q20toq34_r14 condemo
replace condemo = -999 if condemo == .
rename q20toq34_r15 consoc
replace consoc = -999 if consoc == .

rename q37 posdiff
replace posdiff = -999 if posdiff == .

rename documentaries docu
replace docu = -999 if docu == .

rename optimism optim
replace optim = -999 if optim == .

rename q41_1 wellspen
replace wellspen = -999 if wellspen == .
rename q42_1 riskseek
replace riskseek = -999 if riskseek == .
rename q43_1 patience
replace patience = -999 if patience == .
rename q45_1 locus
replace locus = -999 if locus == .
rename q46_1 polideo
replace polideo = -999 if polideo == .

rename prefernottosay_1 polid_no
replace polid_no = -999 if polid_no == .

rename q47 age
replace age = -999 if age == .

rename q48 gender
replace gender = -999 if gender == .

rename q49 income
replace income = -999 if income == .

rename q50 educat
replace educat = -999 if educat == .

rename q50_6_other educspec
replace educspec = "-999" if educspec == ""

rename q51 employ
replace employ = -999 if employ == .

rename q51_9_other emplspec
replace emplspec = "-999" if emplspec == ""

rename q52 national
replace national = -999 if national == .

rename q53 reside
replace reside = -999 if reside == .

replace comments = "-999" if comments == ""



 


































