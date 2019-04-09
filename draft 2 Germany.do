version 12
clear all
set more off
capture log close

cd "e:\"
global datadir "e:\SOEP\SOEPlongSTARTINGPOINT"
use "$datadir/chapter_trends_germany", clear

xtdescribe

gen weekly = e11101/52
tab weekly
summ weekly
recode age(17/30=1) (31/45=2) (46/65=3) (65/200=4) ///
 , gen(agecat)

   gen gross_log= ln(grossmonth)
 gen net_log= ln(netmonth)

 summ gross_log
   bysort pid (syear): replace w11103=w11103[8]
rename m11125 health
 

********satisfaction with work*******
  xtreg z_worksat i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 ///
 [pw=w11103], fe 
 
 
 **********satisfaction with time******************
 
   xtreg z_timesat z_worksat i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 ///
 [pw=w11103], fe 
 
 
 ****************satisfaction with pay*********************************
  
   xtreg z_paysat z_worksat i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 ///
 [pw=w11103], fe 
 
 
 
 ******************objective outcomes*******************************
  xtreg gross_  i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 ///
 [pw=w11103], fe 
 
*********************weekly working hours**********************
   xtreg weekly i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 ///
 [pw=w11103], fe 
 
**********************health*********************************
    xtreg health i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 ///
 [pw=w11103], fe 
 
 tab M_even if e(sample)
 
 summ e11101

 
 *********************gender differences*****************************
 **worksat
   xtreg z_worksat i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 if sex==1 ///
 [pw=w11103], fe 
 xtreg
 
  
   xtreg z_worksat i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 if sex==2 ///
 [pw=w11103], fe 
 
  **paysat
   xtreg z_paysat z_worksat i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 if sex==1 ///
 [pw=w11103], fe 
 xtreg
 
  
   xtreg z_paysat z_worksat i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 if sex==2 ///
 [pw=w11103], fe 
 
 
 **timesat
   xtreg z_timesat z_worksat i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 if sex==1 ///
 [pw=w11103], fe 

   
   xtreg z_timesat z_worksat i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 if sex==2 ///
 [pw=w11103], fe 
 
 
 **gross pay
   xtreg gross_ z_worksat i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 if sex==1 ///
 [pw=w11103], fe 
 
    xtreg gross_ z_worksat i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 if sex==2 ///
 [pw=w11103], fe 
 
 **weekly hours
    xtreg weekly  i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 if sex==1 ///
 [pw=w11103], fe 
 
     xtreg weekly  i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 if sex==2 ///
 [pw=w11103], fe 
 
 **health
     xtreg health i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 if sex==1 ///
 [pw=w11103], fe 
 
     xtreg health i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 if sex==2 ///
 [pw=w11103], fe 
 
 
 *********************education differences*****************************
 **worksat
   xtreg z_worksat i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 if educ==1 ///
 [pw=w11103], fe 

   xtreg z_worksat i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 if educ==2 ///
 [pw=w11103], fe 
 
    xtreg z_worksat i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 if educ==3 ///
 [pw=w11103], fe 
 
  **paysat
   xtreg z_paysat z_worksat i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 if educ==1 ///
 [pw=w11103], fe 

 
   xtreg z_paysat z_worksat i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 if educ==2 ///
 [pw=w11103], fe 
 
    xtreg z_paysat z_worksat i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 if educ==3 ///
 [pw=w11103], fe 
 
 **timesat
   xtreg z_timesat z_worksat i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 if educ==1 ///
 [pw=w11103], fe 

   xtreg z_timesat z_worksat i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 if educ==2 ///
 [pw=w11103], fe 
 
    xtreg z_timesat z_worksat i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 if educ==3 ///
 [pw=w11103], fe 
 
 
 **gross pay
   xtreg gross_ i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 if educ==1 ///
 [pw=w11103], fe 
 
  xtreg gross_  i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 if educ==2 ///
 [pw=w11103], fe 
 
  xtreg gross_  i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 if educ==3 ///
 [pw=w11103], fe 
 
 **weekly hours
    xtreg weekly z_worksat i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 if educ==1 ///
 [pw=w11103], fe 
 
     xtreg weekly z_worksat i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 if educ==2 ///
 [pw=w11103], fe 
 
      xtreg weekly z_worksat i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 if educ==3 ///
 [pw=w11103], fe 
 
 **health
     xtreg health i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 if educ==1 ///
 [pw=w11103], fe 
 
  xtreg health i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 if educ==2 ///
 [pw=w11103], fe 
 
  xtreg health i.M_ i.agecat ib1.perm ///
 i.child ib4.firmsize i.syear ///
 ib9.industry i.isco10 if educ==3 ///
 [pw=w11103], fe 
 