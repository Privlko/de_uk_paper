version 12
clear all
set more off
capture log close

cd "F:\"
global datadir "F:\SOEP\SOEPlongSTARTINGPOINT"




use "$datadir/merged",clear

tsset pid syear

xtdescribe


lab var pgerwzt "Year began current employment"
lab var pgis88 "Occupational codes ISCO88 4 digit"


lab var empstat "Employment status"
tab pgemplst 

tab empstat Gempstat
tab gender, gen(G)
tab occauto, gen(autonomy)
tab Job, gen(J)
tab syear, gen(Y)

xtreg worksat G3 M2 M3 pglabgro autonomy3-autonomy7
xtreg incsat G3 M2 M3 pglabgro autonomy3-autonomy7
xtreg lifesat G3 M2 M3 pglabgro autonomy3-autonomy7


xtreg worksat G3 J2-J4 pglabgro autonomy3-autonomy7 Y1-Y28
xtreg incsat G3 J2-J4 pglabgro autonomy3-autonomy7 Y1-Y28
xtreg lifesat G3 J2-J4 pglabgro autonomy3-autonomy7 Y1-Y28

tab size,
tab mobility, gen(M)

save "$datadir/merged",replace

**missing values coresize)
tab coresize, nolabel
recode coresize (-2/-1=.)
tab coresize

**missing values civil servants**
tab civils
tab pgis88 civil
tab civils,nola

recode civils (-2/-1=.)
tab civils
tab syear civi,m

**missing values monthly wage pglabnet

table syear, c(mean pglabnet)
summ pglabnet
tab pglabnet
recode pglabnet (-2/-1=.)

**missing values union member
tab union

**missing values years in education
tab pgbilzt
recode pgbilzt (-2/-1=.)

tab syear pgbilzt

**missing values gender
tab gender
tab gender,nola

recode gender (-2=.)
drop G*
tab gender

**part time missing values
tab empstat
tab employed
tab empsta, nolabe

recode empsta (-3/-1=.) (1=1) (2=2) ///
(3/11=.) (12=2) (16=.) ,gen(fulltime)

tab empstat fulltime
lab var fulltime "binary variable for full time versus part time work"

recode fulltime (2=0)

tab full


**create an age variable here

**managerial variable
tab pgis88
gen ISCO88=pgis88

recode ISCO88 (-5/-1=.)
tab ISCO
recode ISCO (1000/1999=1) (2000/2999=2) ///
(3000/3999=3) (4000/4999=4) (5000/5999=5) ///
(6000/6999=6) (7000/7999=7) (8000/8999=8) ///
(9000/9999=9) (110=.)
tab ISCO

lab var ISCO "1-digit ISCO codes"

lab define ISCO_label ///
 1 "LEGISLATORS, SENIOR OFFICIALS AND MANAGERS " ///
 2 "PROFESSIONALS " ///
 3 "TECHNICIANS AND ASSOCIATE PROFESSIONALS" ///
 4 "CLERKS" ///
 5 "SERVICE WORKERS AND SHOP AND MARKET SALES WORKERS" ///
 6 "SKILLED AGRICULTURAL AND FISHERY WORKERS" ///
 7 "CRAFT AND RELATED TRADES WORKERS" ///
 8 "PLANT AND MACHINE OPERATORS AND ASSEMBLERS" ///
 9 "ELEMENTARY OCCUPATIONS", replace
 
 label values ISCO ISCO_label
 tab IS
 
 ***missing values tenure
 tab pgerwzt
 gen tenure=pgerwzt
 recode tenure(-5/-1=.)
 
 tab tenure
 summ tenure
**substitute supervision variable with high autonomy
tab occauto, nolabel
recode occauto (-5/-1=.)
drop autonomy1-autonomy8

tab plb0031

tab security
tab Job last
tab Job security,m col
tab Job security, ro

save "$datadir/merged",replace

***important variables

tab worksat /*dependent variable work satisfaction*/
recode worksat(-8/-1=.)
tab worksat
recode worksat (6/10=1) (0/5=0) ,gen(binjbsat)
tab binjbs

table mobility, c(mean binj)
table Job, c(mean binj)

*we have nothing for organisational committment
tab mob /*mobility variable*/
tab J
tab coresize /*firm size*/
tab civils /*public sector civil servant*/
summ pglabnet /*net wages*/
kdensity pglabnet
 *we have a union variable but it's shakey
 tab union
 tab pgbilzt /*years in education*/
 tab gender /*gender*/
 **age is missing
tab fulltim /*part time versus full time*/
**substitute supervision for class and occ
tab ISCO
tab gold, nolabel
recode gold (-8/-1=.)
tab gold
tab tenure /*tenure in firm*/


save "$datadir/merged",replace

xtreg worksat pglabnet pgbilzt tenure J2-J4

kdensity worksat
tab Job, gen(J)

gen lnworksat= log(worksat)
kdensity lnworksat
xtreg lnworksat pglabnet pgbilzt tenure J2-J4 Y1-Y28

tab core, gen(S)
tab gender,nola
recode gender (2=0),gen(male)
tab gen male

xtreg lnworksat pglabnet pgbilzt tenure ///
J2-J4 S2-S5 male civils Y1-Y28 



tab civils,nola
recode civils (2=0)
tab union, nola
recode union (-8/-1=.) (2=0)
tab union

xtreg lnworksat pglabnet pgbilzt tenure ///
J2-J4 S2-S5 male civils fulltime I2-I9 ///
 Y1-Y28 GOLD2-GOLD12

tab fulltim

tab ISCO,gen(I)

tab gold, gen(GOLD)

xtreg lnworksat pglabnet pgbilzt tenure ///
J2-J4 S2-S5 male civils fulltime  ///
 Y1-Y28 GOLD2-GOLD12
 
xtreg lnworksat pglabnet pgbilzt tenure ///
J2-J4 S2-S5 male civils fulltime  ///
 syear GOLD2-GOLD10

 xtreg worksat i.mobility male i.mobility##male
 save "$datadir/merged",replace
 
 
 xtreg lnworksat pglabnet pgbilzt tenure ///
i.Job i.coresiz male civils fulltime i.ISCO ///
 syear i.gold

  xtreg lnworksat pglabnet pgbilzt tenure ///
i.Job i.coresiz male civils fulltime i.ISCO ///
 i.syear i.gold, vce(cluster pid)
 
   xtreg lnworksat pglabnet pgbilzt tenure ///
i.Job i.coresiz male civils fulltime i.ISCO ///
 i.syear i.gold, vce(cluster pid) fe
 
 xtreg lnworksat pglabnet pgbilzt tenure ///
i.Job i.coresiz male civils fulltime i.ISCO ///
 i.syear i.gold, vce(cluster pid) fe
 
 
  xtreg lnworksat pglabnet pgbilzt tenure ///
i.Job i.coresiz male civils fulltime i.ISCO ///
 i.syear i.gold i.Job##i.gold, vce(cluster pid) fe
 
 xtreg lnworksat i.Job pglabnet
 gen change_income= Job*pglabnet
 xtreg lnworksat i.Job pglabnet change_
 
 summ pglabnet
 
 describe pglabnet
 drop change_
 
 xtreg lnworksat i.Job pglabnet i.Job#c.pglabnet
 lincom 2.Job + 2.Job#c.pglabnet*1000
  lincom 1.Job + 1.Job#c.pglabnet*1000
   lincom 3.Job + 3.Job#c.pglabnet*1000
   
   xtreg lnworksat i.Job##i.male 
   testparm i.Job#i.male
   
   save "$datadir/merged",replace
   use "$datadir/merged",replace
   tab gold
   tab gold,nolabel
   recode gold (1=1)(8=1)(2=2)(3=2)(4=2) ///
   (9=2)(5/6=3)(10/11=3) (15/18=.),gen(skill)
   tab gold
   tab skill,m

 lab var skill "Skill categories"

lab define skill_label ///
 1 "High skilled" ///
 2 "Low skilled" ///
 3 "Self employed", replace
 
 label values skill skill_label
 

 
 tab skill
 gen lskill= (L.skill)*10
 tab lskill
 gen transskill=skill+lskill
 
 tab transskill
 lab var transskill "Skill transitions"

lab define transskill_label ///
 11 "High>High skilled" ///
 12 "High>Low skilled" ///
 13 "High>self-emp skilled" ///
 21 "Low>high skilled" ///
 22 "Low>low skilled" ///
 23 "Low>self-emp skilled" ///
 31 "Self-emp>High skilled" ///
 32 "self-emp>low skilled" ///
 33 "self-emp>self-emp", replace

 
 label values transskill transskill_label
 
 tab transs mob
 tab transs Job
 
 tab Job
 drop B*
 
 tab trans
 recode transskill (13=.) (23=.) ///
 (31/33=.),gen(recodeskill)
 
 tab recodeskill
 
 lab var recodeskill "Skill transitions"

lab define recodeskill_label ///
 11 "High>High skilled" ///
 12 "High>Low skilled" ///
 13 "High>self-emp skilled" ///
 21 "Low>high skilled" ///
 22 "Low>low skilled" ///
 23 "Low>self-emp skilled" ///
 31 "Self-emp>High skilled" ///
 32 "self-emp>low skilled" ///
 33 "self-emp>self-emp", replace

 
 label values recodeskill recodeskill_label
 
 tab recodeskill,m
 tab recodeskill
 
 tab recodeski Job,m col
 tab occchange, nolabel
 tab occchange recodesk
 
 tab occchange Job
 
 tab termina Job
 
tab terminate occchange

tab occchange recodeskil, col m


xtreg lnworksat pglabnet pgbilzt tenure ///
i.Job i.coresiz male civils fulltime i.ISCO ///
 i.syear i.recodeskill, vce(cluster pid) fe

 
 
drop GOLD1-GOLD12


**occupational change
describe pgis88
tab pgis88
recode pgis88 (-9/110=.)
gen o2digit=pgis88/100
tab o2digit
replace o2digit=round(o2dig)
tab o2digit
rename o2 isco2digit


describe pgis88
tab pgis88
recode pgis88 (-9/110=.)
gen o3digit=pgis88/10
tab o3digit
replace o3digit=round(o3dig)
tab o3digit
rename o3 isco3digit



gen transocc= D.isco3digit

tab transocc
recode transocc (-900/-1=1) (0=2) (1/900=3)
tab transocc

tab worksat

gen transocc2digit=D.isco2digit
tab transocc2

recode transocc2digit (-900/-1=1) (0=2) (1/900=3)
tab transocc2

rename transocc transocc3digit
tab transocc2digit
tab transocc3digit
tab transocc Job,col


table recodeskill, c(mean binj)
table transocc, c(mean binj)

table Job skill, c(mean binj)

