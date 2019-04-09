version 12
clear all
set more off
capture log close

cd "F:\"
global datadir "F:\SOEP\SOEPlongSTARTINGPOINT"


use "$datadir/finalmobility",clear

tab syear

tab JobM empchng,m
tab mobility empchng,m
tab mobility, gen(inter)
rename inter1 samejob
rename inter2 changejob
rename inter3 changeemployer
keep if syear>1993


xtset pid syear
xttab mobility

table syear [pw=w11103], c(mean samejob ///
mean changejob mean changeemployer) ///
format(%9.2f)  cellwidth(13)

table d11102ll [pw=w11103], c(mean samejob ///
mean changejob mean changeemployer) ///
format(%9.2f)  cellwidth(13)

table syear [pw=w11103] if d11102ll==2, c(mean samejob ///
mean changejob mean changeemployer) ///
format(%9.2f)  cellwidth(13)

table syear [pw=w11103] if d11102ll==1, c(mean samejob ///
mean changejob mean changeemployer) ///
format(%9.2f)  cellwidth(13)

tab permanent

table permanent [pw=w11103], c(mean samejob ///
mean changejob mean changeemployer) ///
format(%9.2f)  cellwidth(13)

table syear [pw=w11103] if permanent==2, c(N samejob ///
mean samejob ///
mean changejob mean changeemployer) ///
format(%9.2f)  cellwidth(13)

table syear [pw=w11103] if permanent==1, c(N samejob ///
mean samejob ///
mean changejob mean changeemployer) ///
format(%9.2f)  cellwidth(13)


recode casmin (0/3=1) (4/7=2) (8/9=3) ,gen(casmin1)
tab casmin casmin1,m
lab var casmin1 "simplified casmin categories"

lab define casmin1_label ///
1 "basic casmin" ///
2 "intermediate casmin" ///
3 "tertiary casmin", replace

lab values casmin1 casmin1_label 

tab casmin1

tab mobility casmin1,m


table casmin1 [pw=w11103], c(N samejob ///
mean samejob ///
mean changejob mean changeemployer) ///
format(%9.2f)  cellwidth(13)

table syear [pw=w11103] if casmin1==1, c(N samejob ///
mean samejob ///
mean changejob mean changeemployer) ///
format(%9.2f)  cellwidth(13)

table syear [pw=w11103] if casmin1==2, c(N samejob ///
mean samejob ///
mean changejob mean changeemployer) ///
format(%9.2f)  cellwidth(13)

table syear [pw=w11103] if casmin1==3, c(N samejob ///
mean samejob ///
mean changejob mean changeemployer) ///
format(%9.2f)  cellwidth(13)

tab JobMo
tab JobMo,gen(JM)
xttab JobMo
tab syear JobMove

table syear [pw=w11103], c(N samejob ///
mean samejob ///
mean changejob mean changeemployer) ///
format(%9.2f)  cellwidth(13)

rename JM1 samejobv
rename JM2 voluntary
rename JM3 involuntary
rename JM4 othermoves

table syear [pw=w11103], c(N samejobv ///
mean samejobv ///
mean voluntary mean involuntary mean other) ///
format(%9.2f)  cellwidth(13)

table d11102ll [pw=w11103], c(N samejobv ///
mean samejobv mean voluntary ///
mean involuntary mean other) ///
format(%9.3f)  cellwidth(13)

table syear  [pw=w11103]if d11102ll==2, c(N samejobv ///
mean samejobv mean voluntary ///
mean involuntary mean other) ///
format(%9.2f)  cellwidth(13)

table syear  [pw=w11103]if d11102ll==1, c(N samejobv ///
mean samejobv mean voluntary ///
mean involuntary mean other) ///
format(%9.2f)  cellwidth(13)

table permanent  [pw=w11103], c(N samejobv ///
mean samejobv mean voluntary ///
mean involuntary mean other) ///
format(%9.2f)  cellwidth(13)


table syear  [pw=w11103] if permanent==2, c(N samejobv ///
mean samejobv mean voluntary ///
mean involuntary mean other) ///
format(%9.2f)  cellwidth(13)

version 12
clear all
set more off
capture log close

cd "F:\"
global datadir "F:\SOEP\SOEPlongSTARTINGPOINT"


use "$datadir/finalmobility",clear

tab syear

tab JobM empchng,m
tab mobility empchng,m
tab mobility, gen(inter)
rename inter1 samejob
rename inter2 changejob
rename inter3 changeemployer
keep if syear>1993


xtset pid syear
xttab mobility

table syear [pw=w11103], c(mean samejob ///
mean changejob mean changeemployer) ///
format(%9.2f)  cellwidth(13)

table d11102ll [pw=w11103], c(mean samejob ///
mean changejob mean changeemployer) ///
format(%9.2f)  cellwidth(13)

table syear [pw=w11103] if d11102ll==2, c(mean samejob ///
mean changejob mean changeemployer) ///
format(%9.2f)  cellwidth(13)

table syear [pw=w11103] if d11102ll==1, c(mean samejob ///
mean changejob mean changeemployer) ///
format(%9.2f)  cellwidth(13)

tab permanent

table permanent [pw=w11103], c(mean samejob ///
mean changejob mean changeemployer) ///
format(%9.2f)  cellwidth(13)

table syear [pw=w11103] if permanent==2, c(N samejob ///
mean samejob ///
mean changejob mean changeemployer) ///
format(%9.2f)  cellwidth(13)

table syear [pw=w11103] if permanent==1, c(N samejob ///
mean samejob ///
mean changejob mean changeemployer) ///
format(%9.2f)  cellwidth(13)


recode casmin (0/3=1) (4/7=2) (8/9=3) ,gen(casmin1)
tab casmin casmin1,m
lab var casmin1 "simplified casmin categories"

lab define casmin1_label ///
1 "basic casmin" ///
2 "intermediate casmin" ///
3 "tertiary casmin", replace

lab values casmin1 casmin1_label 

tab casmin1

tab mobility casmin1,m


table casmin1 [pw=w11103], c(N samejob ///
mean samejob ///
mean changejob mean changeemployer) ///
format(%9.2f)  cellwidth(13)

table syear [pw=w11103] if casmin1==1, c(N samejob ///
mean samejob ///
mean changejob mean changeemployer) ///
format(%9.2f)  cellwidth(13)

table syear [pw=w11103] if casmin1==2, c(N samejob ///
mean samejob ///
mean changejob mean changeemployer) ///
format(%9.2f)  cellwidth(13)

table syear [pw=w11103] if casmin1==3, c(N samejob ///
mean samejob ///
mean changejob mean changeemployer) ///
format(%9.2f)  cellwidth(13)

tab JobMo
tab JobMo,gen(JM)
xttab JobMo
tab syear JobMove

table syear [pw=w11103], c(N samejob ///
mean samejob ///
mean changejob mean changeemployer) ///
format(%9.2f)  cellwidth(13)

rename JM1 samejobv
rename JM2 voluntary
rename JM3 involuntary
rename JM4 othermoves

table syear [pw=w11103], c(N samejobv ///
mean samejobv ///
mean voluntary mean involuntary mean other) ///
format(%9.2f)  cellwidth(13)

table d11102ll [pw=w11103], c(N samejobv ///
mean samejobv mean voluntary ///
mean involuntary mean other) ///
format(%9.3f)  cellwidth(13)

table syear  [pw=w11103]if d11102ll==2, c(N samejobv ///
mean samejobv mean voluntary ///
mean involuntary mean other) ///
format(%9.2f)  cellwidth(13)

table syear  [pw=w11103]if d11102ll==1, c(N samejobv ///
mean samejobv mean voluntary ///
mean involuntary mean other) ///
format(%9.2f)  cellwidth(13)

table permanent  [pw=w11103], c(N samejobv ///
mean samejobv mean voluntary ///
mean involuntary mean other) ///
format(%9.2f)  cellwidth(13)


table syear  [pw=w11103] if permanent==1, c(N samejobv ///
mean samejobv mean voluntary ///
mean involuntary mean other) ///
format(%9.2f)  cellwidth(13)

table casmin1  [pw=w11103], c(N samejobv ///
mean samejobv mean voluntary ///
mean involuntary mean other) ///
format(%9.2f)  cellwidth(13)

table isco10  [pw=w11103], c(N samejobv ///
mean samejobv mean voluntary ///
mean involuntary mean other) ///
format(%9.2f)  cellwidth(13)

table syear  [pw=w11103] if casmin1==1, ///
 c(N samejobv ///
mean samejobv mean voluntary ///
mean involuntary mean other) ///
format(%9.2f)  cellwidth(13)

table syear  [pw=w11103] if casmin1==2, ///
 c(N samejobv ///
mean samejobv mean voluntary ///
mean involuntary mean other) ///
format(%9.2f)  cellwidth(13)

table syear  [pw=w11103] if casmin1==3, ///
 c(N samejobv ///
mean samejobv mean voluntary ///
mean involuntary mean other) ///
format(%9.2f)  cellwidth(13)
