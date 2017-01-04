/* Example 1 */
/* --------- */
use ./data/ecsimobi, clear
plssem (Expectation > CUEX1-CUEX3) (Satisfaction > CUSA1-CUSA3) ///
	(Complaints > CUSCO) (Loyalty > CUSL1-CUSL3) (Image > IMAG1-IMAG5) ///
	(Quality > PERQ1-PERQ7) (Value > PERV1-PERV2), ///
	structural(Expectation Image, Quality Expectation, Value Expectation Quality, ///
	Satisfaction Value Quality Image Expectation, Complaints Satisfaction, ///
	Loyalty Complaints Satisfaction Image) ///
	wscheme("path") digits(4) correlate(mv lv cross, cutoff(.3)) ///
	//noheader nomeastable nodiscrimtable nostructtable //boot(50)

estat indirect, effects(Loyalty Satisfaction Image, ///
	Value Quality Expectation) level(0.9) ///
	digits(5) //seed(123) boot(50) */

plssemplot, innermodel
* plssemplot, outermodel

/* Example 2 */
/* --------- */
use ./data/ecsimobi, clear
plssem (Expectation > CUEX1-CUEX3) (Satisfaction > CUSA1-CUSA3) ///
	(Complaints > CUSCO) (Loyalty < CUSL1-CUSL3) (Image < IMAG1-IMAG5) ///
	(Quality > PERQ1-PERQ7) (Value < PERV1-PERV2), ///
	structural(Expectation Image, Quality Expectation, Value Expectation Quality, ///
	Satisfaction Value Quality Image Expectation, Complaints Satisfaction, ///
	Loyalty Complaints Satisfaction Image) ///
	wscheme("centroid")

/* Example 3 */
/* --------- */
use ./data/ecsimobi, clear
plssem (Expectation > CUEX1-CUEX3) (Satisfaction < CUSA1-CUSA3) ///
	(Quality > PERQ1-PERQ7), ///
	structural(Satisfaction Expectation Quality) ///
	wscheme("centroid") boot(50)

/* Example 4 */
/* --------- */
use ./data/ecsimobi, clear
plssem (Expectation > CUEX1-CUEX3) (Satisfaction > CUSA1-CUSA3) ///
	(Quality > PERQ1-PERQ7) (Image < IMAG1-IMAG5), ///
	structural(Quality Expectation, Satisfaction Expectation Quality Image, ///
	Image Expectation Quality) wscheme("path") ///
	seed(123) digits(3) //boot(50)

estat indirect, effects(Satisfaction Image Expectation, ///
	Satisfaction Quality Expectation, Satisfaction Image Quality) level(0.9) ///
	digits(5) seed(123) //boot(50)

estat vif, digits(4)

/* Example 5 */
/* --------- */
use ./data/ecsimobi, clear
plssem (Expectation > CUEX1) (Satisfaction > CUSA1-CUSA3) ///
	(Quality > PERQ1-PERQ7) (Image < IMAG1-IMAG5), ///
	structural(Quality Expectation, Satisfaction Expectation Quality Image, ///
	Image Expectation Quality) wscheme("path") ///
	seed(123) digits(3) boot(50)

/* Example 6 */
/* --------- */
use ./data/ecsimobi, clear
set seed 123
generate group = rbinomial(1, .4)
bysort group: plssem (Expectation > CUEX1-CUEX3) (Satisfaction > CUSA1-CUSA3) ///
	(Quality > PERQ1-PERQ7) (Image < IMAG1-IMAG5), ///
	structural(Quality Expectation, Satisfaction Expectation Quality Image, ///
	Image Expectation Quality) wscheme("path") ///
	seed(123) digits(5) //boot(50)

estat total, plot
	
/* Example 7 */
/* --------- */
use ./data/ecsimobi, clear
plssem (CUEX > CUEX1) (Expectation > CUEX2-CUEX3) (Satisfaction > CUSA1-CUSA3) ///
	(Complaints > CUSCO) (Loyalty > CUSL1-CUSL3) (Image > IMAG1-IMAG5) ///
	(Quality > PERQ1-PERQ7) (Value > PERV1-PERV2), ///
	structural(CUEX Expectation Image CUSA1, Quality Expectation, Value Expectation Quality, ///
	Satisfaction Value Quality Image Expectation, Complaints Satisfaction, ///
	Loyalty Complaints Satisfaction Image) ///
	wscheme("path") digits(5) stats //boot(50)

/* Example 8 */
/* --------- */
use ./data/ecsimobi, clear
plssem (Expectation > CUEX1-CUEX3) (Satisfaction > CUSA1-CUSA3) ///
	(Quality > PERQ1-PERQ7) (Image > IMAG1-IMAG5), ///
	structural(Quality Expectation, Satisfaction Expectation Quality Image) ///
	noheader nostructtable nodiscrimtable init(eigen)

factor CUEX1-CUEX3, factors(1) pcf
factor CUSA1-CUSA3, factors(1) pcf
factor PERQ1-PERQ7, factors(1) pcf
factor IMAG1-IMAG5, factors(1) pcf

/* Example 9 */
/* --------- */
use ./data/ecsimobi, clear
rename *, lower

sem (Expectation -> cuex1-cuex3) (Satisfaction -> cusa1-cusa3) ///
	(Quality -> perq1-perq7) (Quality Image <- Expectation) ///
	(Image -> imag1-imag5) (Satisfaction <- Expectation Quality Image), stand

estat teffects, nototal nodirect stand

/* Example 10 */
/* ---------- */
use ./data/ecsimobi, clear
* pause on
generate group = 1
replace group = 0 in 1/125
* keep if group == 1
bysort group: plssem (Expectation > CUEX1-CUEX3) (Satisfaction > CUSA1-CUSA3) ///
	(Complaints > CUSCO) (Loyalty > CUSL1-CUSL3) (Image > IMAG1-IMAG5) ///
	(Quality > PERQ1-PERQ7) (Value > PERV1-PERV2), ///
	structural(Expectation Image, Quality Expectation, Value Expectation Quality, ///
	Satisfaction Value Quality Image Expectation, Complaints Satisfaction, ///
	Loyalty Complaints Satisfaction Image) ///
	wscheme("path") digits(4) stats //boot(50)

/* Example 11 */
/* ---------- */
clear all
set obs 1000
set seed 123
generate ITEM1 = rbinomial(6, .5)
generate ITEM2 = rbinomial(6, .5)
generate ITEM3 = rbinomial(6, .5)
/* kdensity ITEM1
kdensity ITEM2
kdensity ITEM3 */
plssem (lv1 > ITEM1) (lv2 > ITEM2-ITEM3), structural(lv1 lv2)

/* Example 12 */
/* ---------- */
use ./data/ecsimobi, clear
generate group = 1
replace group = 0 in 1/125
/* bysort group: */ plssem (Expectation > CUEX1-CUEX3) (Satisfaction > CUSA1-CUSA3) ///
	(Complaints > CUSCO) (Loyalty > CUSL1-CUSL3) (Image > IMAG1-IMAG5) ///
	(Quality > PERQ1-PERQ7) (Value > PERV1-PERV2), ///
	structural(Expectation Image, Quality Expectation, Value Expectation Quality, ///
	Satisfaction Value Quality Image Expectation, Complaints Satisfaction, ///
	Loyalty Complaints Satisfaction Image) ///
	wscheme("path") digits(5) init("eigen") //boot(50)

/* Example 13 */
/* ---------- */
use ./data/ecsimobi, clear
pause on
set seed 123
generate BIN1 = rbinomial(1, .4)
generate BIN2 = rbinomial(1, .6)
generate BIN3 = rbinomial(4, .3)
/* generate group = 1
replace group = 0 in 1/125
bysort group: */ plssem (Expectation > CUEX1-CUEX3) (Satisfaction > CUSA1-CUSA3) ///
	(Quality > PERQ1-PERQ7) (Image < IMAG1-IMAG5) (Virtual > BIN1) (Virtual2 > BIN2), ///
	structural(Quality Expectation Virtual Virtual2, Satisfaction Expectation Quality Image, ///
	Image Expectation Quality, Virtual Image, Virtual2 Quality) wscheme("path") ///
	seed(123) digits(5) binary(Virtual Virtual2) //boot(50)

/* Example 14 */
/* ---------- */
/* [From Sanchez, G. (2013) PLS Path Modeling with R (Chapter 5)] */

// Round 1
set seed 123
use ./data/education, clear
plssem (Support > sup*) (Advising > adv*) (Tutoring > tut*) (Value > val*) ///
	(Satisfaction > sat*) (Loyalty > loy*), ///
	structural(Value Support Advising Tutoring, ///
	Satisfaction Support Advising Tutoring Value, Loyalty Satisfaction) ///
	wscheme("centroid") digits(4) tol(1e-6) //boot(50)

// Round 2
set seed 123
use ./data/education, clear
generate sup_appre = 8 - sup_under
generate loy_pleas = 8 - loy_asha
drop sup_under loy_asha
plssem (Support > sup*) (Advising > adv*) (Tutoring > tut*) (Value > val*) ///
	(Satisfaction > sat*) (Loyalty > loy*), ///
	structural(Value Support Advising Tutoring, ///
	Satisfaction Support Advising Tutoring Value, Loyalty Satisfaction) ///
	wscheme("centroid") digits(4) tol(1e-6) //boot(50)

// Round 3
set seed 123
use ./data/education, clear
drop sup_under loy_asha
plssem (Support > sup*) (Advising > adv*) (Tutoring > tut*) (Value > val*) ///
	(Satisfaction > sat*) (Loyalty > loy*), ///
	structural(Value Support Advising Tutoring, ///
	Satisfaction Support Advising Tutoring Value, Loyalty Satisfaction) ///
	wscheme("centroid") digits(4) tol(1e-6) // boot(50)

estat indirect, effects(Satisfaction Value Support, ///
	Satisfaction Value Advising, Satisfaction Value Tutoring, ///
	Loyalty Satisfaction Support) digits(5)

estat total, digits(7) plot

/* Example 15 */
/* ---------- */
/* [From Sanchez, G. (2013) PLS Path Modeling with R (Section 6.2.3)] */
use ./data/college, clear

bysort Gender: plssem (HighSchool > HS_GPA SAT_Verbal SAT_Math) ///
	(Intro > Biology1 Chemistry1 Math1 Physics1) ///
	(Medium > Biology2 Chemistry2 Math2 Physics2) (Graduation > FinalGPA), ///
	structural(Intro HighSchool, Medium Intro HighSchool, ///
	Graduation Medium Intro HighSchool) ///
	wscheme("centroid") digits(4) tol(1e-6) //boot(50)

/* Example 16 */
/* ---------- */
use ./data/ecsimobi, clear

*set seed 123
*generate group = rbinomial(1, .4)
generate group = 1
replace group = 2 in 126/250
plssem (Expectation > CUEX1-CUEX3) (Satisfaction > CUSA1-CUSA3) ///
	(Complaints > CUSCO) (Loyalty > CUSL1-CUSL3) (Image > IMAG1-IMAG5) ///
	(Quality > PERQ1-PERQ7) (Value > PERV1-PERV2), ///
	structural(Expectation Image, Quality Expectation, Value Expectation Quality, ///
	Satisfaction Value Quality Image Expectation, Complaints Satisfaction, ///
	Loyalty Complaints Satisfaction Image) ///
	wscheme("path") digits(7) tol(1e-5) ///
	group(group, reps(20) method(permutation) plot) //boot(50)

/* Example 17 */
/* ---------- */
/* [From Sanchez, G. (2013) PLS Path Modeling with R (Section 6.2.3)] */
use ./data/college, clear

pause on
set seed 123
plssem (HighSchool > HS_GPA SAT_Verbal SAT_Math) ///
	(Intro > Biology1 Chemistry1 Math1 Physics1) ///
	(Medium < Biology2 Chemistry2 Math2 Physics2) (Graduation > FinalGPA), ///
	structural(Intro HighSchool, Medium Intro HighSchool, ///
	Graduation Medium Intro HighSchool) ///
	wscheme("centroid") digits(4) tol(1e-6) correlate(mv lv cross, cutoff(.3)) ///
	group(Gender, reps(100) method(permutation) plot alpha(0.1) what(path)) ///
	//boot(50)

/* Example 18 */
/* ---------- */
use ./data/ecsimobi, clear
pause on
/* generate group = 1
replace group = 0 in 1/125
bysort group: */ plssem (Expectation > CUEX1-CUEX3) (Satisfaction > CUSA1-CUSA3) ///
	(Quality > PERQ1-PERQ7) (Image < IMAG1-IMAG5), ///
	structural(Quality Expectation, Satisfaction Expectation Quality Image, ///
	Image Expectation Quality) wscheme("path") seed(123) digits(5) //boot(50)

/* Example 19 */
/* ---------- */
pause on
use ./data/ecsimobi, clear
plssem (Expectation > CUEX1-CUEX3) (Satisfaction > CUSA1-CUSA3) ///
	(Complaints > CUSCO) (Loyalty > CUSL1-CUSL3) (Image > IMAG1-IMAG5) ///
	(Quality > PERQ1-PERQ7) (Value > PERV1-PERV2), ///
	structural(Expectation Image, Quality Expectation, Value Expectation Quality, ///
	Satisfaction Value Quality Image Expectation, Complaints Satisfaction, ///
	Loyalty Complaints Satisfaction Image) ///
	wscheme("path") digits(4) correlate(mv lv cross, cutoff(.3)) //boot(50)

/* Example 20 */
/* ---------- */
pause on
use ./data/ecsimobi, clear
set seed 123
generate group = rbinomial(2, .5) + 1
label define group_lbl 1 "Low" 2 "Mid" 3 "High"
label value group group_lbl
plssem (Expectation > CUEX1-CUEX3) (Satisfaction > CUSA1-CUSA3) ///
	(Complaints > CUSCO) (Loyalty > CUSL1-CUSL3) (Image > IMAG1-IMAG5) ///
	(Quality > PERQ1-PERQ7) (Value > PERV1-PERV2), ///
	structural(Expectation Image, Quality Expectation, Value Expectation Quality, ///
	Satisfaction Value Quality Image Expectation, Complaints Satisfaction, ///
	Loyalty Complaints Satisfaction Image) ///
	wscheme("path") digits(4) ///
	group(group, reps(50) method(bootstrap) plot alpha(0.1) what(path)) ///
	// boot(50)

/* Example 21 */
/* ---------- */
/* [From Sanchez, G. (2013) PLS Path Modeling with R (Section 7.3.1)] */
/* Product indicator approach */
pause on
use ./data/satisfaction, clear
forvalues i = 1/3 {
	forvalues j = 1/3 {
		local ninter = (`i' - 1)*3 + `j'
		generate inter`ninter' = imag`i'*sat`j'
	}
}
plssem (Image > imag1-imag3) (Satisfaction > sat1-sat3) ///
	(Loyalty > loy1-loy3) (Inter > inter1-inter9), ///
	structural(Loyalty Image Satisfaction Inter) ///
	wscheme("centroid") digits(5) tol(1e-6) //boot(200)

plssem (Image > imag1-imag3) (Satisfaction > sat1-sat3) ///
	(Loyalty > loy1-loy3), structural(Loyalty Image*Satisfaction) ///
	wscheme("centroid") digits(5) tol(1e-6) //boot(200) ///
	// group(gender, reps(50) method(normal) plot alpha(0.1) what(loadings))

/* Two-stage path modeling approach */
pause on
use ./data/satisfaction, clear
// Stage 1
plssem (Image > imag1-imag3) (Satisfaction > sat1-sat3) ///
	(Loyalty > loy1-loy3), structural(Loyalty Image Satisfaction) ///
	wscheme("centroid") digits(5) tol(1e-6) //boot(200)

// Stage 2
generate ImageSatisfaction = Image*Satisfaction
plssem (Image > imag1-imag3) (Satisfaction > sat1-sat3) ///
	(Loyalty > loy1-loy3) (Inter > ImageSatisfaction), ///
	structural(Loyalty Image Satisfaction Inter) ///
	wscheme("centroid") digits(5) tol(1e-6) //boot(200)

/* Two-stage regression approach */
pause on
use ./data/satisfaction, clear
// Stage 1
plssem (Image > imag1-imag3) (Satisfaction > sat1-sat3) ///
	(Loyalty > loy1-loy3), structural(Loyalty Image Satisfaction) ///
	wscheme("centroid") digits(5) tol(1e-6) //boot(200)

// Stage 2
generate ImageSatisfaction = Image*Satisfaction
regress Loyalty Image ImageSatisfaction Satisfaction

/* Example 22 */
/* ---------- */
pause on
use ./data/ecsimobi, clear
set seed 123
generate group = rbinomial(1, .5) + 1
label define group_lbl 1 "Low" 2 "High"
label value group group_lbl
plssem (Expectation > CUEX1-CUEX3) (Satisfaction > CUSA1-CUSA3) ///
	(Complaints > CUSCO) (Loyalty > CUSL1-CUSL3) (Image > IMAG1-IMAG5) ///
	(Quality > PERQ1-PERQ7) (Value > PERV1-PERV2), ///
	structural(Expectation Image, Quality Expectation, Value Expectation Quality, ///
	Satisfaction Value Quality Image*Expectation, Complaints Satisfaction, ///
	Loyalty Complaints Satisfaction Image) ///
	wscheme("path") digits(4) tol(1e-6) ///
	group(group, reps(50) method(normal) plot alpha(0.1) what(loadings)) ///
	//boot(50)

/* Example 23 */
/* ---------- */
/* [From Sanchez, G. (2013) PLS Path Modeling with R (Section 8.1.3)] */
/* Repeated indicators approach */
pause on
use ./data/offense, clear
plssem (Special < FieldGoals OtherTDs) (Scoring > PointsGame OffensTD TDGame) ///
	(Passing > YardsPassComp PassYards PassFirstDown) ///
	(Rushing > YardsRushAtt RushYards RushFirstDown) ///
	(Offense > YardsPassComp PassYards PassFirstDown YardsRushAtt RushYards RushFirstDown), ///
	structural(Scoring Special Offense, Offense Passing Rushing) ///
	wscheme("centroid") digits(5) tol(1e-6) //boot(200)

/* Example 24 */
/* ---------- */
pause on
use ./data/ecsimobi, clear
generate group = rbinomial(1, .5) + 1
label define group_lbl 1 "Low" 2 "High"
label value group group_lbl
plssem (Expectation > CUEX1-CUEX3) (Satisfaction > CUSA1-CUSA3) ///
	(Complaints > CUSCO) (Loyalty > CUSL1-CUSL3) (Image > IMAG1-IMAG5) ///
	(Quality > PERQ1-PERQ7) (Value > PERV1-PERV2), digits(4) init(eigen) ///
	//group(group, reps(50) method(normal) plot alpha(0.1) what(loadings)) ///
	/* structural(Expectation Image, Quality Expectation, Value Expectation Quality, ///
	Satisfaction Value Quality Image Expectation, Complaints Satisfaction, ///
	Loyalty Complaints Satisfaction Image) wscheme("path") tol(1e-6) ///
	//boot(50) */

/* Example 25 */
/* ---------- */
/* [From Sanchez, G. (2013) PLS Path Modeling with R (Section 8.1.3)] */
/* Repeated indicators approach */
pause on
use ./data/offense, clear
plssem (Special < FieldGoals OtherTDs) (Scoring > PointsGame OffensTD TDGame) ///
	(Passing > YardsPassComp PassYards PassFirstDown) ///
	(Rushing > YardsRushAtt RushYards RushFirstDown) ///
	(Offense > YardsPassComp PassYards PassFirstDown  YardsRushAtt RushYards RushFirstDown), ///
	str(Scoring Special Offense, Offense Passing Rushing) ///
	wscheme("centroid") digits(5) tol(1e-6) //boot(200)

/* Example 26 */
/* ---------- */
/* [From Sanchez, G. (2013) PLS Path Modeling with R (Chapter 4)] */
pause on
use ./data/spainfoot, clear
generate NGCH = -1*GCH
generate NGCA = -1*GCA
plssem (Attack > GSH GSA SSH SSA) (Defense > NGCH NGCA CSH CSA) ///
	(Success > WMH WMA LWR LRWL), ///
	structural(Success Attack Defense) correlate(cross) ///
	wscheme("centroid") digits(5) tol(1e-6) //boot(200)

* plssemplot, scores
* plssemplot, crossloadings
* plssemplot, loadings
plssemplot, stats(Attack)

/* Example 27 */
/* ---------- */
/* [From Sanchez, G. (2013) PLS Path Modeling with R (Section 6.2.3)] */
use ./data/college, clear

plssem (HighSchool > HS_GPA SAT_Verbal SAT_Math) ///
	(Intro > Biology1 Chemistry1 Math1 Physics1) ///
	(Medium < Biology2 Chemistry2 Math2 Physics2) (Graduation > FinalGPA), ///
	structural(Intro HighSchool, Medium Intro HighSchool, ///
	Graduation Medium Intro HighSchool) ///
	wscheme("centroid") digits(4) tol(1e-6) correlate(mv lv cross, cutoff(.3)) ///
	group(Gender, plot what(loadings))

/* Example 28 */
/* ---------- */
/* [From Sanchez, G. (2013) PLS Path Modeling with R (Section 6.2.3)] */
use ./data/college, clear

pause on
plssem (HighSchool > HS_GPA SAT_Verbal SAT_Math) ///
	(Intro > Biology1 Chemistry1 Math1 Physics1) ///
	(Medium < Biology2 Chemistry2 Math2 Physics2) (Graduation > FinalGPA), ///
	structural(Intro HighSchool, Medium Intro HighSchool, ///
	Graduation Medium Intro HighSchool) ///
	digits(4) rawsum

/* Example 29 */
/* ---------- */
/* [From Sanchez, G. (2013) PLS Path Modeling with R (Section 7.3.1)] */
/* Product indicator approach */
use ./data/satisfaction, clear

pause on
plssem (Image > imag1-imag3) (Satisfaction > sat1-sat3) ///
	(Loyalty > loy1-loy3), structural(Loyalty Image*Satisfaction) ///
	wscheme("centroid") digits(5) tol(1e-6) ///
	group(gender, reps(10) method(permutation) groupseed(123))

/* Example 30 */
/* ---------- */
use ./data/ecsimobi, clear

/* two formative model does not work [SERGIO: NOW IT WORKS] */
plssem (Expectation < CUEX1-CUEX3) (Satisfaction < CUSA1-CUSA3), ///
	structural(Satisfaction Expectation)

/* Example 31 */
/* ---------- */
use ./data/ecsimobi, clear

set seed 123
generate BIN1 = rbinomial(1, .4)
generate BIN2 = rbinomial(1, .6)
generate BIN3 = rbinomial(4, .3)
/* generate group = 1
replace group = 0 in 1/125
bysort group: */ plssem (Expectation > CUEX1-CUEX3) (Satisfaction > CUSA1-CUSA3) ///
	(Quality > PERQ1-PERQ7) (Image < IMAG1-IMAG5) (Virtual > BIN1), ///
	structural(Quality Expectation Virtual, Satisfaction Expectation Quality Image, ///
	Image Expectation Quality, Virtual Image) wscheme("path") ///
	seed(123) digits(5) binary(Virtual) //boot(50)

/* Example 32 */
/* ---------- */
use ./data/ecsimobi, clear
pause on
plssem (Expectation > CUEX1-CUEX3) (Satisfaction > CUSA1-CUSA3) ///
	(Image > IMAG1-IMAG4), ///
	structural(Expectation Image, Satisfaction Expectation Image) ///
	wscheme("path") boot(25)

mat list e(loadings)
mat list e(loadings_bs)
mat list e(pathcoef)
mat list e(pathcoef_bs)

/* Example 33 */
/* ---------- */
/* This is the application included in the JSS paper */
use ./data/workout2, clear
plssem (Attractive > face sexy) ///
			(Appearance > body appear attract) ///
			(Muscle > muscle strength endur) ///
			(Weight > lweight calories cweight), ///
			structural(Appearance Attractive, ///
	               Muscle Appearance, ///
	               Weight Appearance) ///
	    boot(25) seed(123) stats corr(lv)
		
estat indirect, effects(Muscle Appearance Attractive, ///
                        Weight Appearance Attractive) ///
								boot(25) seed(456)

plssemplot, loadings

/* Example 34 */
/* ---------- */
/* From Garson's book */
use ./data/jobsat, clear
plssem (SES > OccStat StdEduc) ///
			(Incentives > Incent1 Incent2) ///
			(Motivation > Motive1 Motive2), ///
			structural(Motivation Incentives SES) ///
	    //boot(25) seed(123) stats corr(lv)
		
plssemplot, loadings
plssemplot, crossloadings

plssem (SES > OccStat StdEduc) ///
			(Incentives > Incent1 Incent2) ///
			(Motivation > Motive1 Motive2), ///
			structural(Motivation Incentives SES) ///
			group(Gender, what("path")) ///
	    //boot(25) seed(123) stats corr(lv)