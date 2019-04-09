version 12
clear all
set more off
capture log close

cd "F:\"
global datadir "F:\SOEP\SOEPlongSTARTINGPOINT"


use pid syear plb0022 plb0304 plb0031 plb0009 ///
plb0284 plb0037 welle plb0340 plb0342 plb0347 ///
pcb0041 pla0009 plj0097 plj0100 plh0173 ///
plh0175 plh0033 plh0042 ple0008 ple0001 ///
using "$datadir/pl", clear
tsset pid syear



tab welle
tab syear
tab plb0022
tab plb0031

gen empstat= plb0022
tab empstat


lab var empstat "Employment status"
 lab define empstat_label ///
 1 "Full time employment" ///
 2 "regular part-time" ///
 3 "vocational training" ///
 4 "marginally employed" ///
 5 "near retirement (zero work)" ///
 6 "military service" ///
 7 "civil service" ///
 8 "workshop for the disabled" ///
 9 "not employed" ///
 11 "fulltime short work hours" ///
 12 "parttime short work hours" ///
 16 "military service" , replace
 
 label values empstat empstat_label
 
 tab empstat
**************************************************
 recode empstat (1/2=1) (11/12=1) (3/9=0) ///
 (16=0), gen(employed)
 
 recode employed (-3/-1=.)
 tab employed
 *******************************************************
 
 tsset pid syear
 tab syear
 tab employed
 tab  empstat employed


 sort pid syear
 
 list pid syear employed plb0022 in 1/100 ,sepby(pid)
 list pid syear employed plb0022 if pid==203 ,sepby(pid)
 
 
 lab var employed "Employed full time, regular part time, or fulltime w/ short work hours"
 lab define employed_label ///
 1 "In regular employment" ///
 0 "Unemployed, or otherwise inactive", replace
 
 label values employed employed_label
 
 tab employed
*****************************************************
tab syear plb0031,m
tab plb0031
gen eng0031=plb0031

lab var eng0031 "Change in the last 12 months"
 lab define eng0031_label ///
 1 "Yes" ///
 2 "No" ///
 3 "Yes, after checking dates", replace
 
 label values eng0031 eng0031_label
 tab eng0031

 ********************************************
 
 recode plb0031 (-8/-1=.) (1=1) (2=0) (3=1),gen(bin12change)
tab plb0031
tab bin12
lab var bin12 "Change in the last 12 months"
 lab define bin12_label ///
 1 "Yes" ///
 0 "No" , replace
 
 label values bin12 bin12_label
 tab bin12
************************************************
tab bin12 employed,m
gen missing=0
replace missing =1 if employed==1 & bin12==.
tab missing

tab syear missing


tab syear bin12
gen empchng = 0

replace empchng = 1 if employed==1 & bin12==0
replace empchng = 2 if employed==1 & bin12==1
recode empchng (0=.)

tab employed bin12,m
tab empchng
tab syear bin12
tab syear empchng,row


 ***************************************************
 tab plb0284

 gen destination=plb0284
 tab destination, missing
 
 lab var destination "Type of job change"
 
 lab define destination_label ///
 -6 "modified filtering" ///
 -5 "absent from questionnaire" ///
 -4 "inadmissable multiple answer" ///
 -3 "Answer improbable" ///
 -2 "Does not apply" ///
 -1 "No answer" ///
 1 "first job" ///
 2 "job after a break" ///
 3 "Job with new employer" ///
 4 "Company taken over" ///
 5 "Changed job, same firm" ///
 6 "new job, self employed",replace
 **************************************************
 label values destination destination_label
 
 tab destination
 
 tab destination employe,m
 tab destination empchng,m
 tab syear destination
 
 *******************************************
 
tab bin12 employed
tab empchng
 
*MOBILITY VARIABLE SPECIFYING WITHIN AND
*BETWEEN FIRM MOBILITY.
*******************************************************

 gen mobility=0
 tab employed empchng,m
 tab destination empchng,m
 
 lab var mobility "Move events for Employed->Employed"
 lab define mobility_label ///
 0 "Residual category" ///
 1 "Same job same employer" ///
 2 "Changed job, kept employer" ///
 3 "Changed employer", replace
 label values mobility mobility_label
 
 tab mobility,m
 tab syear mobility,m
 sort pid syear

 replace mobility = 1 if empchng == 1
  tab mobility,m
 tab mobility empchng, m

 replace mobility=2 if destination==5 
 replace mobility=3 if destination==3 
 
 recode mobility (0=.)
 tab mobility
 tab mobility empchng,m

 gen missing1=0
 replace missing1=1 if empchng==2 & mobility==.
 tab missing1
 tab syear missing1
 tab destination missing1,m
 

 gen missing1a=0
 replace missing1a=1 if empchng==. & mobility==3 ///
 | empchng==. & mobility==2
 
 tab missing1a
 tab missing1a empchng,m
 tab missing1a employed,m
 tab missing1a bin12,m 
 tab plb0031 missing1a ,m
 tab mobility
 
 replace mobility=. if missing1a==1
 tab mobility
 
 
 tab syear missing1a
 tab syear missing1a
 
 gen missing2=0
 replace missing2=1 if employed==1 & mobility==.
 
 gen missing88=0
 replace missing88=1 if bin12==1 & mobility==.
 tab syear mobility ,row
 
 tab mobility
 tab mobility empchng,m
 



 tab  destination mobility, m
 tab mobility,m
 
 

 recode mobility (0=.)
 tab mobility
 tab destination mobility,m

 *******************aside************************

 gen mobility2=0
 tab employed empchng,m
 tab destination empchng,m

 replace mobility2 = 1 if empchng == 1
  tab mobility2,m
 tab mobility2 empchng, m


 
 tab mobility,nola
 replace mobility2 = 2 if destination == 5 
 replace mobility2 = 3 if destination == 3 
 recode mobility2 (0=.)
 tab mobility2
 tab mobility empchng,m
 
 lab var mobility2 "Move events for Employed->Employed"
 lab define mobility2_label ///
 0 "Residual category" ///
 1 "Same job same employer" ///
 2 "Changed job, kept employer" ///
 3 "Changed employer", replace
 label values mobility2 mobility2_label
 tab mobility2 employed,m
 tab mobility2 bin12,m
 tab syear mobility2
 
 
  tab employed,nola
  gen missing4=0 
  tab mobility,nola
  replace missing4=1 if mobility2==3 & bin12==.
  tab syear missing4
  
  gen missing5=0
  replace missing5 = 1 ///
  if mobility2 == . & bin12 == 1
  
  tab syear missing5

  
  tab mobility2 empchng,m
 **************************************************
 
 
 
 
 
 
 
 
 
 
 
 
 **building the reference category is tricky. we need
 *to consider workers who argue that "do not apply"
 *this groups is made up of almost everybody.
 * respondents who work/don't/who are unemployed.
  * since we only care about those who are EMPLOYED at
  *w and at w-1, we can see that those who remain working 
  *also answered "do not apply" while several others were
  *coded as missing (unemployed or with employment gaps)
  *the other negative values are removed
 ************************************************ 
 *****************************************************
 gen terminated=plb0304
tab plb0304
tab terminate
tab terminated syear
tab plb0031
tab termi plb0031
tab plb0009 plb0031
*************************************************
lab define terminated_label ///
 -8 "no label/unclear" ///
 -6 "questionnaire version w/modified filtering" ///
 -5 "not contained in questionnaire" ///
 -4 "inadmissable multiple answer" ///
 -3 "answer improbable" ///
 -2 "does not apply" ///
 -1 "No answer" ///
 1 "company closed" ///
 2 "resigned" ///
 3 "dismissal" ///
 4 "mutual agreement" ///
 5 "temporary contract expired" ///
 6 "reached retirement age" ///
 7 "leave of abscence/sabbatical" ///
 8 "Business closed down" ///
 9 "Early retirement" ///
 10 "Training Qualification complete" ///
 11 "yes" ///
 12 "yes" ///
 13 "misc. reasons", replace
  
 label values terminated terminated_label
 
  tab terminat,nolab
  tab terminat
  tab syear terminat,miss
  tab mobility
  

gen JobMove=0
tab Job,m

replace JobMove = 1 if empchng==1
tab Job employed,m
tab terminated,m

 replace JobMove=2 if terminated==2 | terminated==4 ///
 & empchng==2
tab termin Job 

replace JobMove=3 if terminated==3 | terminated==1 ///
 | terminated==5 | terminated==6 | terminated==8 ///
 & empchng==2
 

 
 tab  Job empchng,m
 
replace JobMove=4 if  empchng==2 & terminated == 7 | terminated == 9 | ///
 terminated== 10 | terminated== 11| terminated== 12 | ///
 terminated== 13 
 

 
 tab terminat JobM,nolabel m 
 tab Job empchng,m
 tab JobM empchng,m

************************************************************* 
 lab var JobMove "Move events for Employed->Employed"
 lab define JobMove_label ///
 0 "Residual" ///
 1 "Same job, same employer" ///
 2 "Voluntary mobility (quit)" ///
 3 "Involuntary mobility (redundant, dismissed, end of temp)" ///
 4 "Other reason for change", replace
 label values JobMove JobMove_label
***************************************************
tab JobMove
tab syear JobM,m row
tab syear empchng,row
tab empchng Job,m
tab syear Job,row 
tab syear mobility,row


tab JobM
recode JobMove (0=.)
tab Job empchng,m

gen missing10=0
replace missing10=1 if empchng==2 & JobMove==.
tab missing10
tab terminate missing10,m

tab JobMove empchng,m
gen missing10a=0
replace missing10a=1 if ///
empchng==. & JobMove==1 | ///
empchng==. & JobMove==2 | ///
empchng==. & JobMove==3 | ///
empchng==. & JobMove==4
tab Job

tab missing10a  empchng,m

tab missing10a empchng
tab employed missing10a,m 
tab bin12 missing10a, m
tab employed missing10a,m


tab JobM
replace JobM = . if empchng==.
tab syear JobM,row
  
  tab syear JobM,row
  tab JobM
*********************************************************
tab Job empchn,m
tab mobility empchng,m

tab JobM mobility,m

 tab term,m
 gen M_event=0
replace M_event= 1 if employed == 1 & bin12 == 0
replace M_event=2 if mobility == 3 & JobMove == 2
replace M_event=3 if mobility ==3 & JobMove == 3
replace M_event=4 if mobility ==3 & JobMove == 4
replace M_event=5 if mobility ==2 & JobMove == 2
replace M_event=6 if mobility ==2 & JobMove == 3
replace M_event=7 if mobility ==2 & JobMove == 4


tab M_

tab M_event bin12,m

tab M_event
 lab var M_event "Mobility event"
 lab define M_event_label ///
 0 "Residual" ///
 1 "Same job, same employed" ///
 2 "Changed employer- voluntary" ///
 3 "Changed employer- involuntary" ///
 4 "Changed employer- other reason" ///
 5 "Changed job, kept employer- voluntary" ///
 6 "Changed job, kept employer- involuntary" ///
 7 "Changed job, kept employer- other", replace
 label values M_event M_event_label
 

tab  M_event mobility,m
tab M_eve,m
 
 
 tab terminate employed,m
 tab terminate bin12,m
 tab destination bin12,m
 replace M_=. if empchng==.
 recode M_event (0=.)
 tab M_eve mobility,m
 
 gen missing3 = 0
 
 replace missing3 = 1 if ///
 mobility == 2 & JobMove == . | ///
 mobility == 3 & JobMove == .
 
 tab missing3
 tab terminate missing3,m
 tab empchng missing3,m
 
 gen missing3a = 0
 
 replace missing3a = 1 if ///
 mobility == . & JobMove == 2 | ///
 mobility == . & JobMove == 3 | ///
 mobility == . & JobMove == 4
 
 tab destination missing3a ,m
 
 tab M_event
 tab JobM mobility ,m
 
 save "$datadir/appendix1",replace
 
********************************************************

 
 list pid syear lemployed employed change mobility if pid==203 ,sepby(pid)
 list pid syear lemployed employed change mobility in 500/700  ,sepby(pid)
 
 


 
 tab mobility
 tab  syear mobility, m
 tab mobility employed, m
  
  tab plb0304
 
** VERY IMPORTANT VARIABLE plb0304 and some related variables

tab plb0304
tab syear plb0340
tab syear plb0304
tab syear plb0342
tab syear plb0347
tab syear pcb0041


 tab term J,m
 tab employed J,m
 
 tab employed Job
 
  tab terminated JobMove
 tab terminated JobMove, missing
 tab pla0009
 
 
 tab  syear plj0097
 tab plj0100
 
 
 tab plb0037
 recode plb0037 (-8/-1=.) (1=1) (2=2) (3/4=.)  ,gen(permanent)
 tab syear perm
 
 lab var permanent "permanent contract"
 lab define permanent_label ///
 1 "permanenet" ///
 2 "temporary", replace
 label values permanent permanent_label
 tab permanent,m
*************************************************
save "$datadir/finalmobility",replace

use "$datadir/finalmobility", clear

tab JobMove employed
tab mobility employed

tab JobMove empchng,m
tab mobility empchng,m

************************************************************
use pgbetr pgallbet pgnace pgis88 pgbilzt pgbbil02 pgsbil ///
pgcasmin syear pid pgjobch  using "$datadir/pgen", clear


gen recentchange=pgjobch
tab recent

lab var recent "recent job change"
 
 lab define recent_label ///
 -6 "modified filtering" ///
 -5 "absent from questionnaire" ///
 -4 "inadmissable multiple answer" ///
 -3 "Answer improbable" ///
 -2 "Does not apply" ///
 -1 "No answer" ///
 1 "not employed" ///
 2 "employed no change" ///
 3 "employed no info if changed" ///
 4 "employed with change" ///
 5 "first job",replace
  label values recent recent_label

tab pgbetr
gen size = pgbetr

tab size,m
recode size (1=1) (2=2) (3/5=3) (6=6) (7/8=7) (9=9) ///
 (10=10) (11=1)

 tab pgbetr size
 
lab var size "size of firm"
 lab define size_label ///
 1 "under 5" ///
 2 "between 5 and 10" ///
 3 "under 20" ///
 6 "between 20 and 100" ///
 7 "between 100 and 200" ///
 9 "between 200 and 2000" ///
 10 "2000+", replace
 label values size size_label
 tab size
 
 ******************************************************
 
 tab pgsbil
 tab syear pgsbil
 
 gen qualification=pgsbil
 tab qua
 lab var qualification "Qualification attained"
 lab define qualification_label ///
 1 "Highschool" ///
 2 "Intermediate school degree" ///
 3 "Vocational degree" ///
 4 "College entrance exams" ///
 5 "Other" ///
 6 "No reponse" ///
 7 "Still in School", replace
 label values qualification qualification_label
 tab qualification
 tab syear qualifica
 
 ***********************************************************
 tab pgbbil02,m
 tab syear pgbbil02
 
 gen degree=pgbbil02
 
 tab degre,m
 lab var degree "Degree attained"
 lab define degree_label ///
 1 "Highschool" ///
 2 "University, technical school" ///
 3 "Vocational degree" ///
 4 "Engineering technical school" ///
 5 "University (east)" ///
 6 "State doctorate" , replace
 label values degree degree_label
 tab degree
 tab syear degree
 
*************************************************************

tab pgbilzt
lab var pgbilzt "amount of education or training in years"

***************************************************************

tab pgis88




recode pgis88 (0/999=.) (-9/-1=.) ///
(1000/1999=1) ///
(2000/2999=2) ///
(3000/3999=3) ///
(4000/4999=4) ///
(5000/5999=5) ///
(6000/6999=6) ///
(7000/7999=7) ///
(8000/8999=8) ///
(9000/9999=9) ///
,gen(isco10)


tab isco10
lab var isco10 "1 digit occupations"
 lab define isco10_label ///
 1 "managers" ///
 2 "professionals" ///
 3 "technicians and associate professionals" ///
 4 "clerical support workers" ///
 5 "services and sales workers" ///
 6 "skilled agriculture" ///
 7 "craft and related work" ///
 8 "plant and machinery workers" ///
 9 "elmentary work" ///
 , replace
 
 label values isco10 isco10_label
tab isco10,m

**************************************************************

tab pgnace
 *********************************************************************
 
 tab pgcasmin
 gen casmin=pgcasmin
 tab casmin,m
 
 
 lab var casmin "highest casmin degree"
 lab define casmin_label ///
 0 "In school" ///
 1 "(1a) inadequately completed" ///
 2 "(1b) general elementary school" ///
 3 "(1c) basic vocational qualification" ///
 4 "(2b) intermediate general qualification" ///
 5 "(2a) intermediate vocational" ///
 6 "(2c_gen) general maturity certificate" ///
 7 "(2c_voc) vocational maturity certificat" ///
 8 "(3a) lower tertiary education" ///
 9 "(3b) higher tertiary education" , replace
 label values casmin casmin_label
 tab casmin
 tab syear casmin
 
 ***********************************************************************
 
 tab pgallbet
 gen firmsize=pgallbet
 tab firmsize,m
 
 lab var firmsize "simplified firm size"
 lab define firmsize_label ///
 1 "less than 20" ///
 2 "20-200" ///
 3 "200-2000" ///
 4 "2000+" ///
 5 "Self employed without employees" , replace
 label values firmsize firmsize_label
 tab firmsize
 tab size firmsize,m
 tab syear firmsize,m
 *****************************************************************************
 
merge 1:1 pid syear using "$datadir/finalmobility"
tab syear
tab _merge
keep if _merge==3
tab _merge
drop _merge

tab syear
***********************************************************************

tab firmsiz Job,row
**************************************************************
save "$datadir/finalmobility",replace
*********************************************************


use pid syear d11101 d11104 d11107 d11108 d11109 e11105  ///
e11106 i11110 ijob1 m11125 w11103 w11105 ///
e11107 m11126 d11102ll using "$datadir/pequiv", clear

merge 1:1 pid syear using "$datadir/finalmobility"
tab syear,m
tab _merge
keep if _merge==3
tab _merge
drop _merge

table JobMo [pw=  w11103], c(mean d11101)
table JobMo [pw=  w11105], c(mean d11101)

tsset pid syear
save "$datadir/finalmobility",replace
use "$datadir/finalmobility", clear

mvdecode _all, mv(-10/-1)

table syear , c(mean i11110) format(%9.2f)
table syear [pw=  w11105], ///
c(mean i11110) format(%9.2f)
table syear [pw=  w11103], ///
c(mean i11110) format(%9.2f)

tsset pid syear

*unweighted and unclustered model
reg i11110 syear i.JobMove

*unweighted but clustered model
reg i11110 syear i.JobMove, vce(cluster pid)

*weighted model
reg i11110 syear i.JobMove [pw = w11103]



tab Job
tab termin pgjobch
tab plh0173,m
tab plh0175,m

tab M_event



  tab recent bin12,m
  recode recent (1=.) (2=2) (3=.) (4=4) (5=.), ///
  gen(binrecent)
  tab binrec,m
  tab terminate binrec,m

tab recent bin12,m

tab M_ev empchn,m
tab Job mobility,m
tab M_eve
tab M_eve Job,m
tab Job M_e
tab mobility M_e
tab M_event bin12,m
tab M_event employ,m

tab employed bin12,m

***************************************************

tab plh0173,m
tab plh0175,m
tab plh0033,m
tab plh0042
tab plb0037,m
tab perman,m
tab ple0008,m
tab syear ple0008,m

summ ijob1
*****************************************************

tab d11102ll 
tab pla0009,m

tab pla0009 d11102ll ,m
tab degree,m

tab casm,m

tab degree,m
tab d11108,m
tab ple0001
tab d11101
summ d11101

table syear,c(mean d11101)

tab d11107,m
tab e11107,m
tab pgis88
sum pgis88

tab e11105
summ e11105

tab pla0009,m
tab d11102ll,m
tab casm

summ d11102ll casm degree d11108 ///
d11109 d11101  d11107 permanent ///
firmsize size e11106 e11107 ///
pgis88 isco e11105


save "$datadir/finalmobility",replace

summ employed bin12 empchng terminated ///
destination mobility JobMove M_
