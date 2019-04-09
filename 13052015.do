version 12
clear all
set more off
capture log close

cd "F:\"
global datadir "F:\SOEP\SOEPlongSTARTINGPOINT"


use "$datadir/ivanssoep", clear

**searching for the important bits and pieces.
*satisfaction
tab syear plh0173
tab plh0173
gen worksat=plh0173
tab worksat

lab var worksat "Satisfaction with work"

 lab define worksat_label ///
 -5 "not in questionnaire" ///
 -2 "Does not apply" ///
 -1 "No answer", replace
 
 label values worksat worksat_label
 
 tab worksat
 tab syear worksat
 
 **satisfaction with household income**
 
tab syear plh0175
tab plh0175
gen incsat=plh0175 
tab incsat

lab var incsat "Satisfaction with HH income"

 lab define incsat_label ///
 -5 "not in questionnaire" ///
 -2 "Does not apply" ///
 -1 "No answer", replace
 
 label values incsat incsat_label
 tab incsa


tab syear plh0091 /*too many missing*/

**life satisfaction

tab syear plh0182
tab plh0182
gen lifesat=plh0182
tab lifesat
lab var lifesat "Satisfaction with life"

 lab define lifesat_label ///
 -5 "not in questionnaire" ///
 -2 "Does not apply" ///
 -1 "No answer", replace
 
 label values lifesat lifesat_label
 tab lifesat
 
**satisfaction with life today
tab syear plh0151 /*too many missing*/

tab syear plh0161 /*too many missing*/
tab syear plh0176 /*too many missing*/

tab mob,m
tab J, m

table syear, c(mean pld0105)
table syear, c(mean pld0106)
table syear, c(mean plb0049)

tab syear plb0049,m
** nace scores
table syear, c(mean p_nace)
tab syear p_nace


**public servant 
tab syear plg0261 /*too many missing*/
tab syear plb0046 /*too many missing*/

*wages
table syear, c(mean plc0015)
table syear, c(mean plc0017)

**trade union
tab syea plh0263
gen union=plh0263

lab var union "trade union membership"
tab union
 lab define union_label ///
 -8 "missing" ///
 -5 "not in questionnaire" ///
 -2 "Does not apply" ///
 -1 "No answer" ///
 1 "yes" ///
 2 "no", replace
 
 label values union union_label
 tab union
 
**education
tab syear p_degree
tab syear plg0082

**gender
tab syear pla0009
gen gender=pla0009
tab gen

lab var gender "gender"
tab gender
 lab define gender_label ///
 -8 "missing" ///
 -5 "not in questionnaire" ///
 -2 "Does not apply" ///
 -1 "No answer" ///
 1 "male" ///
 2 "female", replace
 
 label values gender gender_label
 tab gender
 
 tab plh0042 /*worried about job security*/
 gen security= plh0042
 tab security
 recode security (-6/-1=.)
 tab security,m
 
 lab define security_label ///
 1 "very" ///
 2 "somewhat" ///
 3 "not at all", replace
 label values security security_label
 
 tab security
 
 tab plb0031 /*changed jobs*/
 gen lastyear=plb0031
 
 tab m last
 lab define lastyear_label ///
 1 "yes" ///
 2 "no" ///
 3 "yes after checking dates", replace
 label values lastyear lastyear_label
 
 tab lastyear
 recode lastyear(-8/-1=.)
 
 tab lastyear
 tab J lastyear
 

save "$datadir/plkmpaper", replace


use "$datadir/pgen", clear

*useful variables

*autonomy in occupational actions


tab pgautono
tab  syear pgautono
gen occauto = pgautono
tab occaut
lab var occauto  "autonomy in occupational actions"

 lab define occauto_label ///
 -2 "Does not apply" ///
 -1 "No answer" ///
 0 "Apprentice" ///
 1 "Low" ///
 5 "High" , replace
 
 label values occauto occauto_label
 tab occ
tab syear occ
 
**occupational change (v.weird variable)
tab pgjobch
tab syear pgjobch
gen occchange=pgjobch
tab occchange

lab var occchange  "occupational change"

 lab define occchange_label ///
 -2 "Does not apply" ///
 -1 "No answer" ///
  1 "Not employed" ///
  2 "Employed no change" ///
  3 "Employed no info if change" ///
  4 "Employed with change" ///
 5 "First Job" , replace
 
 label values occchange occchange_label
tab occchange
tab syear occc


**size of company
tab pgbetr
tab syear pgbetr
gen size=pgbetr

lab var size  "size of the company"

 lab define size_label ///
 -2 "Does not apply" ///
 -1 "No answer" ///
  1 ">5" ///
  2 "5-10" ///
  3 "11-20" ///
  4 ">20 until 90" ///
 5 "91-04: 5-20" ///
 6 "20-100" ///
 7 "100-200" ///
 8 "until 98 20-200" ///
 9 "200-2000" ///
 10 "2000+" ///
 11 "self employed without employees", replace
 
 label values size size_label

 tab size
 
*another size variable
tab pgallbet
tab  syear pgallbet
gen coresize=pgallbet

lab var coresize  "core size of the company"

 lab define coresize_label ///
 -2 "Does not apply" ///
 -1 "No answer" ///
  1 ">20" ///
  2 "20-200" ///
  3 "200-2000" ///
  4 "2000+" ///
 5 "self employed without employees", replace
 
 label values coresize coresize_label

 tab coresize
 tab size core

 *private sector variables
tab pgnace
tab pgstib 

tab pgoeffd 
tab syear pgoeffd
gen civils=pgoeffd

tab civil

lab var civil  "civil servant workers"

 lab define civils_label ///
 -2 "Does not apply" ///
 -1 "No answer" ///
  1 "yes" ///
  2 "no" , replace
 
 label values civils civils_label
 tab civils
 
**wages

summ pglabnet
table syear, c(mean pglabnet) 
lab var pglabnet "Current Net Labor Income in Euro"


summ pglabgro
table syear, c(mean pglabgro)
lab var pglabgro "Current Gross Labor Income in Euro" 
recode pglabgro (-10/-1=.)
summ pglabgro



** years of education
tab syear pgbilzt
lab var pgbilzt "Amount Of Education Or Training In Years" 
summ pgbilzt 

*employment status

tab pgemplst
tab syear pgemplst
gen Gempstat=pgemplst

lab var Gempstat "Employment status"

 lab define Gempstat_label ///
 -3 "answer improbable" ///
 -2 "Does not apply" ///
 -1 "No answer" ///
  1 "Full time employment" ///
  2 "Regular part-time employment" ///
  3 "Vocational training" ///
  4 "marginal irregular and part-time work" ///
  5 "Not employed" ///
  6 "sheltered workshop" , replace
 
 label values Gempstat Gempstat_label
 tab Gemp
 
 
**goldthorpe class categories

tab pgegp
tab syear pgegp
gen goldclass=pgegp

lab var goldclass "Erikson, Goldthorpe Class Category IS88"

 lab define goldclass_label ///
 -3 "answer improbable" ///
 -2 "Does not apply" ///
 -1 "No answer" ///
  1 "high service" ///
  2 "low service" ///
  3 "routine non-manual" ///
  4 "routine service sale" ///
  5 "self employed with employees" ///
  6 "self employed no employees" ///
  7 "manual supervision" ///
  8 "skilled manual" ///
  9 "semi-unskilled manual" ///
  10 "farm labour" ///
  11 "self employed farmer" ///
  15 "not working unemployed" ///
  18 "not working- pensioner", replace
  
 
 label values goldclass goldclass_label

**Length Of Time With Firm

sum pgerwzt
table syear, c(mean pgerwzt)
lab var pgerwzt "length of time with firm"




save "$datadir/kmpaper", replace
