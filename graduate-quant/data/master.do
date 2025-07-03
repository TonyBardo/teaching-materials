********************************************************************************
/*GSS 1972-2018
Cross-Sectional Cummulative Data (Release 1, March 19, 2019) Stata V8.0 File
Program for SOC 781*/
********************************************************************************
/*Install spost13_ado pachage*/
* net install spost13_ado
/*Examples from book*/
*net get spost13_do
********************************************************************************
clear all
set maxvar 30000
********************************************************************************
use \\ad.uky.edu\AS\Sociology\aba423\Desktop\Data\GSS_stata\GSS7218.dta, clear
set more off
set seed 12132016
************smaller dataset for folks w/ student version of stata***************
/*clean key variables*/
/*keep satfam satfrnd sathealt sathobby satcity year income region partyid relig 
attend happy hapmar satfin finalter finrela cohort hompop wrkstat marital age 
educ paeduc maeduc degree padeg madeg sex race ballot chldnum*/
********************************************************************************
               /*run below before moving on to analyses*/
******************************Starting N=64,814*********************************
/*happiness*/
*tab happy, m /*4,760 (7.3%) missing*/
/*recode in positive direction*/
gen hap=.
replace hap=1 if happy==3 /*not so happy*/
replace hap=2 if happy==2 /*pretty happy*/
replace hap=3 if happy==1 /*very happy*/
/*check recode: crosstab w/ original*/
*tab hap happy,m

/*variable labels*/
*label variable hap "Recode original happiness variable in positive direction"
/*value labels*/
*label define happy 1 nottoohappy 2 prettyhappy 3 veryhappy
*label values hap happy
*tab hap happy
/*relable hap back to hap*/
*label variable hap "hap"
/*drop label values*/
*label values hap .

/*dichotomize happiness (very/pretty vs. not so happy)*/
gen hap_dic=.
replace hap_dic=0 if hap==1
replace hap_dic=1 if hap==2 | hap==3
/*check recode*/
*tab hap_dic hap,m

/*domain satisfaction index: 5 items 1-7 very great deal to none: reverse code*/
gen satfamily=8-satfam
replace satfamily=. if satfamily>7
gen satfriends=8-satfrnd
replace satfriends=. if satfriends>7
gen sathealth=8-sathealt
replace sathealth=. if sathealth>7
gen sathobbies=8-sathobby
replace sathobbies=. if sathobbies>7
gen satresidence=8-satcity
replace satresidence=. if satresidence>7
/*sum all 5 to create index*/
gen domsat=satfamily + satfriends + sathealth + sathobbies + satresidence
/*subtract 4 so range=1 to 31*/
replace domsat=domsat - 4


/*age*/
*tab age,m
replace age=. if age>89
/*polynomial transformations: capture non-linear patterns*/
/*quadratic (one inflection point)*/
gen age2=age*age
/*cubic (two inflection points)*/
gen age3=age*age*age
/*quartic (three inflection points)*/
gen age4=age*age*age*age
/*note must include main effect and any terms that come before last in reg  
models (e.g., if want to capture 3 inflection points then must include: 
age, age2, age3, age4)...another technique to capture non-linear patterns is to 
respectively include all but one unit as a predictor(e.g., a dummy for each year 
of age excluding a single year as the reference category*/

/*sex*/
gen female=.
replace female=0 if sex==1
replace female=1 if sex==2
*tab female sex

/*race*/
gen nonwhite=.
replace nonwhite=1 if race==2 | race==3
replace nonwhite=0 if race==1
*tab nonwhite race

/*educational attainment: based on years completed*/
gen lhs=0 /*less than high school*/
replace lhs=1 if educ<12
gen hs=0 /*high school*/
replace hs=1 if educ==12
gen ghs=0 /*greater than high school - includes some college*/
replace ghs=1 if educ>12
/*exlude one edu dummy as reference category if not treating edu as continuous*/
/*indicator edu attainment variable to use with factor notation "i."*/
gen educat=.
replace educat=0 if lhs==1
replace educat=1 if hs==1
replace educat=2 if ghs==1

/*marital status*/
gen married=.
replace married=1 if marital==1
replace married=0 if marital!=1
*tab married marital

*****************************Loop Examples**************************************
/*Generate dummy for each year of age, respectively*/
foreach i of numlist 18/89{
gen age`i'=1 if age==`i' 
replace age`i'=0 if age`i'!=1
}

/*Compute mean happiness for each year of age, respectively*/
gen hapm=. /*generate a new var to store mean values by age*/
quietly foreach i of numlist 18/89{ /*note what quietly did*/
egen hapm`i'=mean(hap) if age==`i' /*use "egen" when construcing a new variable 
using a function (e.g., mean(hap)) "gen" will NOT work*/
replace hapm=hapm`i' if hapm`i'!=.
}

/*Rather than mean, consider percent in each response category*/
/*Create indicators for each of the 3 happiness response categories*/
gen vhap=1 if hap==3 & hap!=. /*very happy*/
replace vhap=0 if hap!=3 & hap!=.
gen phap=1 if hap==2 & hap!=. /*pretty happy*/
replace phap=0 if hap!=2 & hap!=.
gen nhap=1 if hap==1 & hap!=. /*not too happy*/
replace nhap=0 if hap!=1 & hap!=.

gen vhappc=.
gen phappc=.
gen nhappc=.
quietly foreach i of numlist 18/89{
egen vhappc`i'=mean(vhap) if age==`i'
replace vhappc=vhappc`i' if vhappc`i'!=.
egen phappc`i'=mean(phap) if age==`i'
replace phappc=phappc`i' if phappc`i'!=.
egen nhappc`i'=mean(nhap) if age==`i'
replace nhappc=nhappc`i' if nhappc`i'!=.
}
****************************Missing Data****************************************
/*Generate variable to store information on missing data*/
egen nmiss=rmiss(hap age female nonwhite educ married)
*tab nmiss
/*What's missing? Tab through each variable to figure out*/
*keep if nmiss==0 /*drops only those w/ any missing information on listed vars*/
*sum hap female nonwhite if nmiss==0 /*comand to include only analytic sample*/ 
/*if you don't limit to analytic sample when computing descriptive statistics
then you will obtain different Ns for each variable w/ missing data*/
***********************************STOP*****************************************
***********************************STOP*****************************************
*************************Run to here for data prep******************************
/*save dataset*/
save "\\ad.uky.edu\AS\Sociology\aba423\Desktop\Data\GSS_stata\GSS7218V2.dta" 
****************************Read in clean data**********************************
clear all
set maxvar 30000
********************************************************************************
use \\ad.uky.edu\AS\Sociology\aba423\Desktop\Data\GSS_stata\GSS7218V2.dta, clear
set more off
set seed 12132016
*******************************Descriptives*************************************
/*first: ID analytic sample, and then either construct ID variable or remove
respondents who are not in analytic sample from the data set. ID var example->*/

/*make sure limit to analytic sample*/
sum hap if nmiss==0
/*use detail command for more information*/
*sum hap if nmiss==0, detail

/*can summarize more than one variable at a time*/
sum hap age female if nmiss==0

/*consider that happiness is an ordinal variable*/
/*can use factor notation and compute reference group*/
sum i.hap age female if nmiss==0
/*or use tab for full information*/
tab hap if nmiss==0

/*crosstabs*/
tab female hap if nmiss==0
tab female hap if nmiss==0, ro co cell /* percentage options*/

/*subgroup summaries*/
sort female
by female: sum hap if nmiss==0

/*t-test: two-sample grouping var has 2 categories and other is continuous*/
ttest hap if nmiss==0, by(female) /*recall happiness is ordinal*/
/*more appropriate for age*/
ttest age if nmiss==0, by(female)

/*ANOVA: grouping var has 3+ categories and outcome is continuous*/
anova age educat if nmiss==0

/*chi-square: when nominal & nominal*/
tab nonwhite female if nmiss==0, co chi2

/*Kruskal Wallis: grouping 2 or more levels and outcome ordinal*/
kwallis hap, by(female)

/*correlation matrix*/
cor hap age female nonwhite educ married if nmiss==0
pwcorr hap age female nonwhite educ married if nmiss==0, sig /*need "pwcorr" 
for ",sig" option*/

/*graphing: histogram*/
hist hap if nmiss==0, discrete percent
/*"discrete" puts bars together, "percent" makes Yaxis % - try without*/
hist hap if nmiss==0

/*graphing: bivariate*/
scatter hap age if nmiss==0
/*lets treat happiness like an ordinal measure: remember our loop*/
scatter vhappc age if nmiss==0
scatter vhappc phappc nhappc age if nmiss==0

/*We could also treat happiness as continuous and look at mean values*/
scatter hapm age if nmiss==0
/*use graph twoway command to include other options such as reg line*/
graph twoway (scatter hapm age) (lfit hapm age) if nmiss==0 /*add reg line*/
/*doesn't look very linear, but it still fit a line*/
/*other way to generate mean values by group other than loop*/
egen hapmo=mean(hap), by(age)
graph twoway (scatter hapmo age) (lfit hapmo age) if nmiss==0 /*add reg line*/
*******************************OLS Examples*************************************
/*linear regression*/
reg hap age
*polynomial transformations of age for non-linear patterns
/*one inflection point*/
reg hap age age2
/*two inflection points*/
reg hap age age2 age3
/*three inflection points*/
reg hap age age2 age3 age4
/*Let's take these estimates and plot in RStudio*/

/*Let's add some covariates and see what happens*/
/*We can also plot in Stata, but need to use factor notation so that Stata 
plots command knows it is dealing with a transformed variable*/
/*linear regression*/
reg hap age female nonwhite educ married
estimates store base
margins, at(age=(18(1)89)) atmeans
marginsplot
/*one inflection point*/
reg hap age c.age#c.age female nonwhite educ married
estimates store base
margins, at(age=(18(1)89)) atmeans
marginsplot
/*two inflection points*/
reg hap age c.age#c.age c.age#c.age#c.age female nonwhite educ married
estimates store base
margins, at(age=(18(1)89)) atmeans
marginsplot
/*three inflection points*/
reg hap age c.age#c.age c.age#c.age#c.age c.age#c.age#c.age#c.age female ///
nonwhite educ married
estimates store base
margins, at(age=(18(1)89)) atmeans
marginsplot

/*let's look at age pattern by education and graph in R*/
reg hap age if nmiss==0
reg hap age lhs ghs if nmiss==0
/*let' see if age pattern differs by education: more on this later*/
gen agelhs=age*lhs 
gen ageghs=age*ghs
reg hap age lhs agelhs ghs ageghs if nmiss==0
/*lhs is 0, so reference group. Same results as...*/
reg hap age i.educat if nmiss==0
reg hap age hs ghs if nmiss==0
/*need factor notation to graph in stata*/
reg hap age i.educat c.age#i.educat if nmiss==0
reg hap c.age##ib1.educat if nmiss==0 /*change reference group ib1 ///
shorten code with double ##*/
margins educat, at(age=(18(1)89))
marginsplot
*******************************OLS Diagnostics**********************************
/*switching examples to domain satisfaction index*/
sum domsat if nmiss==0, detail
/*normally distributed: visual*/
histogram domsat if nmiss==0, normal
/*mean domsat by age*/
egen domsatm=mean(domsat), by(age)
scatter domsatm age

/*simple linear regression*/
reg domsat age if nmiss==0
/*add age squared term*/
reg domsat age age2 if nmiss==0

/*linearity: add some demographic covariates*/
/*simple regression is easy*/
twoway (scatter domsatm age) (lfit domsat age) (lowess domsat age) if nmiss==0
/*more complicated with multivariate*/
reg domsat age c.age#c.age female nonwhite if nmiss==0
acprplot age, lowess
/*domsat is left skewed: try log transformation*/
gen domsatlog=ln(domsat)
reg domsatlog age c.age#c.age female nonwhite if nmiss==0
acprplot age, lowess 

/*constant error varriance*/
/*heteroscadasticity*/
reg domsat age c.age#c.age female nonwhite if nmiss==0
rvfplot, yline(0)
estat hettest
/*can add robust SE*/
reg domsat age c.age#c.age female nonwhite if nmiss==0, robust

/*normal distribution of errors*/
reg domsat age c.age#c.age female nonwhite if nmiss==0
predict r, resid
kdensity r, normal
drop r

reg domsat age c.age#c.age female nonwhite if nmiss==0
predict resid if nmiss==0, resid
pnorm resid
qnorm resid
drop resid

/*multicollinearity*/
/*obviously polynomial transformation will be highly collinear*/
reg domsat age c.age#c.age female nonwhite if nmiss==0
vif

/*Influential observations*/
*findit iqr
iqr domsat if nmiss==0
*findit extremes
extremes domsat

*******************************Additional Techniques****************************
/*scale reliability*/
alpha satcity sathobby satfam satfrnd sathealt if nmiss==0, item std casewise 

/*standardization*/
/*standardize Xs using beta command*/
reg domsat age c.age#c.age female nonwhite if nmiss==0, beta
/*compute standardized y*/
egen zdomsat=std(domsat)
reg zdomsat age c.age#c.age female nonwhite if nmiss==0
*******************************OLS Mediation************************************
/*Does income mediate relationship between domsat and age*/
/*step one: reg domsat on age + CVs w/o income*/
reg domsat age female nonwhite if age<65 & income<13 & nmiss==0
/*step two: reg income on age + CVs w/o domsat*/
reg income age female nonwhite if age<65 & income<13 & nmiss==0 & domsat!=.
/*step 3: reg domsat on income + age + CVs*/
reg domsat income age female nonwhite if age<65 & income<13 & nmiss==0
/*step four: compute mediation...let Stata do this*/
sgmediation domsat if age<65 & nmiss==0, mv(income) iv(age) cv(female nonwhite)
/*hey it does all steps with one command*/ 
*******************************OLS Moderation***********************************
/*dummy * dummy interaction*/
/*does the effect of marital status differ by sex*/
/*first examine main effects...not doing this for every example*/
reg domsat female married age age2 nonwhite educ if nmiss==0
/*compute interaction term*/
gen marriedfemale=married*female
reg domsat female married marriedfemale age age2 nonwhite educ if nmiss==0

/*dummy * interval interaction*/
/*does the effect of education differ by sex*/
/*use factor notation for interaction*/
reg domsat c.educ##i.female nonwhite married age age2 if nmiss==0
margins female, at(educ=(0(1)20))
marginsplot

/*interval * interval interaction*/
/*does the effect of age differ by education*/
reg domsat c.age##c.educ female nonwhite married if nmiss==0
*********************************GLM Examples***********************************
*user program for interpreting GLM results: download before running below
*findit spostado
*********************************GLM Basics*************************************
/*regress happiness dicotomous variable: OLS exampe*/
reg hap_dic age if nmiss==0
/*let's look at the observed vs. fitted values*/
graph twoway (scatter hap_dic age) (lfit hap_dic age) if nmiss==0

/*can look at predicted values in R*/

/*mean hap_dic with fitted linear slope for age*/
egen hap_dicm=mean(hap_dic), by(age)
graph twoway (scatter hap_dicm age) (lfit hap_dicm age) if nmiss==0

/*MLE*/
/*reaching maximum of likelihood function: iterations*/
logit hap_dic c.age##c.age i.female i.nonwhite ib1.educat i.married if nmiss==0
/*obtain var names*/
logit, coeflegend

/*overall goodness of fit*/
/*model without education compared to model with*/
logit hap_dic c.age##c.age i.female i.nonwhite i.married if nmiss==0
fitstat, saving(noedu)
logit hap_dic c.age##c.age i.female i.nonwhite ib1.educat i.married if nmiss==0
fitstat, using(noedu)

/*estat*/
/*summarize: check out descriptives as you build models*/
logit hap_dic c.age##c.age i.female i.nonwhite ib1.educat i.married if nmiss==0
estat summarize

/*different types of predictions*/
/*each observation*/
logit hap_dic c.age##c.age i.female i.nonwhite ib1.educat i.married if nmiss==0
predict prob if nmiss==0
summarize prob
drop prob

/*can get mean probability with CIs*/
logit hap_dic c.age##c.age i.female i.nonwhite ib1.educat i.married if nmiss==0
margins

/*predicted probability with ALL x's at mean value*/
logit hap_dic c.age##c.age i.female i.nonwhite ib1.educat i.married if nmiss==0
margins, atmeans
/*predicted probability: ideal types*/
/*age 30, female, white, college educated, married*/
logit hap_dic c.age##c.age i.female i.nonwhite ib1.educat i.married if nmiss==0
margins, at(age=30 female=1 nonwhite=0 educat=2 married=1)
/*age 30, female, white, college educated, married*/
logit hap_dic c.age##c.age i.female i.nonwhite ib1.educat i.married if nmiss==0
margins, at(age=30 female=1 nonwhite=0 educat=0 married=1)
/*all X values same except change to <HS educated*/
logit hap_dic c.age##c.age i.female i.nonwhite ib1.educat i.married if nmiss==0
margins, at(age=30 female=1 nonwhite=0 educat=0 married=1)
/*multiple profiles: simplified within one at()*/
logit hap_dic c.age##c.age i.female i.nonwhite ib1.educat i.married if nmiss==0
margins, at(age=30 female=1 nonwhite=0 educat=0 educat=1 educat=2 married=1)
/*multiple profiles: simplified within one at() by decades of age*/
logit hap_dic c.age##c.age i.female i.nonwhite ib1.educat i.married if nmiss==0
margins, at(age=(20(10)90) female=1 nonwhite=0 educat=0 educat=1 educat=2 ///
married=1) noatlegend 
mlistat
/*let's try the above with mtable rather than margins*/
logit hap_dic c.age##c.age i.female i.nonwhite ib1.educat i.married if nmiss==0
mtable, at(age=(20(10)90) female=1 nonwhite=0 educat=0 educat=1 educat=2 ///
married=1) statistics(ci)

/*marginal effects: with margins*/
logit hap_dic c.age##c.age i.female i.nonwhite ib1.educat i.married if nmiss==0
margins, dydx(*)
/*marginal effects: with mchange*/
logit hap_dic c.age##c.age i.female i.nonwhite ib1.educat i.married if nmiss==0
mchange, statistics(ci)
/*some effects are small - add decimals option*/
logit hap_dic c.age##c.age i.female i.nonwhite ib1.educat i.married if nmiss==0
mchange, statistics(ci) decimals(8)

/*plotting predictions*/
logit hap_dic c.age##c.age i.female i.nonwhite ib1.educat i.married if nmiss==0
margins, at(age=(20(10)90) educat=(0 1 2)) atmeans
marginsplot
*********************************Binary Logit***********************************
/*Add factor notation to all examples*/

/*what do these log odds mean?*/
logit hap_dic c.age##c.age i.female i.nonwhite ib1.educat i.married if nmiss==0

/*try some bivariate ORs by hand, and check with "or" command*/
/*OR = 1*/
tab hap_dic female if nmiss==0
logit hap_dic female, or
/*OR > 1*/
tab hap_dic married if nmiss==0
logit hap_dic married, or
/*OR < 1*/
gen unmarried=.
replace unmarried=0 if married==1
replace unmarried=1 if married==0
tab married unmarried if nmiss==0
tab hap_dic unmarried
logit hap_dic unmarried if nmiss==0, or
listcoef, percent

/*let's consider a multivariate model*/
logit hap_dic c.age##c.age i.female i.nonwhite ib1.educat i.married ///
if nmiss==0, or

/*ORs are relative to the base group: sometimes want to compare other group, 
then need to treat variables as factor to meet spost package requirements
use educat with factor variable notation: (0)lhs, (1)hs, (2)ghs*/
logit hap_dic c.age##c.age i.female i.nonwhite ib1.educat i.married ///
if nmiss==0, or
pwcompare educat, effects eform /*"effects" p-values, "eform" odds ratios*/

/*let's look at edu years to interpret continuous IV*/
logit hap_dic c.age##c.age i.female i.nonwhite c.educ i.married ///
if nmiss==0, or

/*What about magnitude? Predicted probability: probs for entire sample*/
logit hap_dic c.age##c.age i.female i.nonwhite ib1.educat i.married ///
if nmiss==0, or
predict prlogit if nmiss==0 
/*can name "prlogit" anything: just storing predicted probs. Will compute
for entire sample if not limited*/
dotplot prlogit
/*can also use Stata generated variable to limit to analytic sample*/
predict prlogit2 if e(sample)==1
/*now don't limit to analytic sample*/
predict prlogitwrong
/*see what happens*/
codebook prlogit prlogit2 prlogitwrong, compact
/*let's compute the average probability and save it for later*/
egen mprlogit = mean(prlogit) if nmiss==0
tab mprlogit /*p Y=1 = 0.873*/

/*Predicted probabilities: Marginal effects*/
/*Average marginal effect (AME)*/
logit hap_dic c.age##c.age i.female i.nonwhite c.educ i.married ///
if nmiss==0, or
/*continuous: educ in years*/
mchange educ, decimals(5)
/*over range of education: 0 to 20 years*/
mchange educ, amount(range) statistics(change from to pvalue)
/*factor: educ groups*/
logit hap_dic c.age##c.age i.female i.nonwhite i.educat i.married ///
if nmiss==0, or
mchange educat, statistics(change from to pvalue)
/*Marginal effect at the mean (MEM)*/
logit hap_dic c.age##c.age i.female i.nonwhite i.educat i.married ///
if nmiss==0, or
mchange, atmeans statistics(ci) decimals(4)
/*mathematically linked variables need to be held constant at mean
i.e., mean(age)*mean(age) NOT mean(age2) - convert notation*/
/*See how we come to different conclusions if not handled properly?*/
logit hap_dic age age2 i.female i.nonwhite i.educat i.married ///
if nmiss==0, or
mchange, atmeans statistics(ci) decimals(4)
/*Marginal effect at representative values (MER)*/
logit hap_dic age age2 i.female i.nonwhite i.educat i.married ///
if nmiss==0, or
/*age 40, female, white, HS*/
mchange married, at(married=0 age=40 female=1 nonwhite=0 educat=1)
/*age 40, male, white, HS*/
mchange married, at(married=0 age=40 female=0 nonwhite=0 educat=1)
/*marginal effects with interactions*/ /*page 285 in text*/
logit hap_dic c.age##c.age i.female##i.nonwhite c.educ i.married ///
if nmiss==0, or
mtable, dydx(female) over (nonwhite) stat(ci) post /*over(var) appears on left
in the tabled output*/ /*post option save estimates to test*/
mlincom 1-2

/*ideal types*/
logit hap_dic c.age##c.age i.female i.nonwhite c.educ i.married ///
if nmiss==0, or
/*age 40 whites vs non-whites: all other Xs held at global means*/
mtable, at(age=40 nonwhite=0) atmeans ci
mtable, at(age==40 nonwhite==1) atmeans ci below
/*subgroup means: w vs nw differ on female educ married*/
sum female educ married if age==40 & nonwhite==0 & nmiss==0
sum female educ married if age==40 & nonwhite==1 & nmiss==0
/*creat indicator variables for each hypothetical group*/
gen _sel40W = age==40 & nonwhite==0
label var _sel40W "40yr whites"
gen _sel40N = age==40 & nonwhite==1
label var _sel40N "40yr non-whites"
/*female educ married at subgroub means*/
mtable if _sel40W==1, rowname(1 40yr whites) atmeans ci
mtable if _sel40N==1, rowname(2 40yr non-whites)atmeans ci below
/*comparing ideal types*/
logit hap_dic c.age##c.age i.female i.nonwhite c.educ i.married ///
if nmiss==0, or
estimates store base /*store estimates*/
mtable, post at(age=40 nonwhite=0 female=0 educ=12 married=0) at(age=40 ///
nonwhite=1 female=0 educ=12 married=0)
mlincom 1-2
estimates restore base /*restore estimates*/
*******************************Logit vs. Probit*********************************
logit hap_dic c.age##c.age i.female i.nonwhite i.educat i.married ///
if nmiss==0
predict prlogit if nmiss==0
estimates store Alogit
probit hap_dic c.age##c.age i.female i.nonwhite i.educat i.married ///
if nmiss==0
predict prprobit if nmiss==0
estimates store Aprobit
estimates table Alogit Aprobit /*compare coef*/
scatter prlogit prprobit /*compare pred. prob*/

/*can use same postestimation techniques, except or, to examine probit results*/
/*AME*/
logit hap_dic c.age##c.age i.female i.nonwhite i.educat i.married ///
if nmiss==0
mchange, decimals(4)
probit hap_dic c.age##c.age i.female i.nonwhite i.educat i.married ///
if nmiss==0
mchange, decimals(4)
/*MEM*/
logit hap_dic c.age##c.age i.female i.nonwhite i.educat i.married ///
if nmiss==0
mchange, atmeans decimals(4)
probit hap_dic c.age##c.age i.female i.nonwhite i.educat i.married ///
if nmiss==0
mchange, atmeans decimals(4)
/*MER*/
logit hap_dic c.age##c.age i.female i.nonwhite i.educat i.married ///
if nmiss==0
mchange, at(married=0 age=40 female=1 nonwhite=0 educat=1) decimals(4)
probit hap_dic c.age##c.age i.female i.nonwhite i.educat i.married ///
if nmiss==0
mchange, at(married=0 age=40 female=1 nonwhite=0 educat=1) decimals(4)
/*Ideal types*/
/*gen _sel40W = age==40 & nonwhite==0
label var _sel40W "40yr whites"
gen _sel40N = age==40 & nonwhite==1
label var _sel40N "40yr non-whites"*/
logit hap_dic c.age##c.age i.female i.nonwhite i.educat i.married ///
if nmiss==0
mtable if _sel40W==1, rowname(1 40yr whites) atmeans ci
mtable if _sel40N==1, rowname(2 40yr non-whites) atmeans ci below
probit hap_dic c.age##c.age i.female i.nonwhite i.educat i.married ///
if nmiss==0
mtable if _sel40W==1, rowname(1 40yr whites) atmeans ci
mtable if _sel40N==1, rowname(2 40yr non-whites) atmeans ci below
**************************Lotit & Probit Diagnostics****************************
/*before interpreting model check residuals*/
logit hap_dic c.age##c.age i.female i.nonwhite ib1.educat i.married ///
if nmiss==0, or
/*compute standardized residuals*/
predict rstd if nmiss==0, rstandard 
/*generate observation number*/
generate index = _n if nmiss==0
/*plot residuals against the index*/
graph twoway scatter rstd index, mlabel(index)
/*check out isolated cases*/
list age female nonwhite educat married in 3104
/*let's check out those with rstd <-4.5*/
list rstd index age female nonwhite educat married if rstd<-4.5 
/*check out influence using dbeta*/
predict deltabeta if nmiss==0, dbeta
graph twoway scatter deltabeta index, mlabel(index)
/*check for patterns in least likely probability*/
leastlikely age female nonwhite educat married

/*LR chi2: overall model fit*/ 
/*lets test a nested model, without and with education*/
logit hap_dic c.age##c.age i.female i.nonwhite i.married ///
if nmiss==0, or
/*see how LR chi2 value increases after adding educ.*/
logit hap_dic c.age##c.age i.female i.nonwhite ib1.educat i.married ///
if nmiss==0, or
/*also check out the pseudo R2: compare the two models*/

/*AIC & BIC*/
logit hap_dic c.age##c.age i.female i.nonwhite i.married ///
if nmiss==0, or
quietly fitstat, save
/*see how AIC & BIC decreases after adding educ.?*/
logit hap_dic c.age##c.age i.female i.nonwhite ib1.educat i.married ///
if nmiss==0, or
fitstat, dif
************************graphing predicted probabilities************************
/*margins plot easier now, but mgen will become ideal option later*/
/*age patterns*/
/*age pattern in happiness all other at mean*/
/*age*/
logit hap_dic c.age i.female i.nonwhite i.educat i.married ///
if nmiss==0, or
estimates store base
margins, at(age=(18(1)89)) atmeans
marginsplot
/*age2*/
logit hap_dic c.age##c.age i.female i.nonwhite i.educat i.married ///
if nmiss==0, or
estimates store base
margins, at(age=(18(1)89)) atmeans
marginsplot
/*age3*/
logit hap_dic c.age##c.age##c.age i.female i.nonwhite i.educat i.married ///
if nmiss==0, or
estimates store base
margins, at(age=(18(1)89)) atmeans
marginsplot

/*now let's use mgen*/
logit hap_dic c.age i.female i.nonwhite i.educat i.married ///
if nmiss==0, or
mgen, at(age=(18(1)89)) atmeans replace stub(PLT) predlabel(PR(AGE)) 
/*"stub" and "predlabel" make working with these plot variales easier*/
/*if run again, use "replace" option*/
/*let's see what mgen created*/
list PLTage PLTpr1 PLTll1 PLTul1 in 1/15
/*basic graph with just estimates*/
scatter PLTpr1 PLTage
/*more advanced*/
/*add CI, makes line, then gets rid of dots: order matters*/
twoway (rarea PLTul1 PLTll1 PLTage, color(gs12)) ///
(connected PLTpr1 PLTage, msymbol(i)), ///
title("Adjusted Predictions") ///
caption("Other variables held at their means") ///
ytitle(Pr(HAP)) legend(off)
/*now combine with age squared and age cubic*/
logit hap_dic c.age##c.age i.female i.nonwhite i.educat i.married ///
if nmiss==0, or
mgen, at(age=(18(1)89)) atmeans replace stub(PLT2) predlabel(PR(AGE2))
logit hap_dic c.age##c.age##c.age i.female i.nonwhite i.educat i.married ///
if nmiss==0, or
mgen, at(age=(18(1)89)) atmeans replace stub(PLT3) predlabel(PR(AGE3))
twoway (connected PLTpr1 PLT2pr1 PLT3pr1 PLTage)

/*predicted probabilities by level of categorical variable*/
/*age pattern in happiness by educat all other at mean*/
logit hap_dic c.age##c.age i.female i.nonwhite i.educat i.married ///
if nmiss==0, or
margins educat, at(age=(18(1)89)) atmeans
marginsplot, noci legend(cols(3))
/*with CIs - remember conservative*/
marginsplot, legend(cols(3))
/*now let's use mgen*/
logit hap_dic c.age##c.age i.female i.nonwhite i.educat i.married ///
if nmiss==0, or
/*need to create graph variables for each level of educat*/
mgen, at(age=(18(1)89) educat=0) atmeans replace stub(PLT1) predlab(LTHS)
mgen, at(age=(18(1)89) educat=1) atmeans replace stub(PLT2) predlab(HS)
mgen, at(age=(18(1)89) educat=2) atmeans replace stub(PLT3) predlab(GTHS)
twoway connected PLT1pr1 PLT2pr1 PLT3pr1 PLT1age, ///
title("Adjusted Predictions by Educat") ///
caption("Other variables at their means") ///
ytitle("Pr(Hap_Dic)") legend(cols(3))

/*global vs. local mean graphs*/
logit hap_dic c.age##c.age i.female i.nonwhite i.educat i.married ///
if nmiss==0, or
mgen, at(age=(18(9)89)) atmeans replace stub(GLOBAL) predlab(age)
twoway (connected GLOBALpr1 GLOBALage, msymbol(i))
/*create agecat variable by 9-year groups*/
gen age9 = trunc(age/9)
replace age9 = age9 - 1
tab age9, m
/*over agecat var to compute for each group with subgroup means*/
logit hap_dic i.female i.nonwhite i.educat i.married c.age##c.age ///
if nmiss==0, or
mtable, over(age9) atmeans ci
matrix localpred = r(table)
matlist localpred, format(%8.2g)
matrix localpred = r(table)
matrix localpred = localpred[1...,"age".."ul"]
matrix colnames localpred = LOCALage LOCALpr LOCALll LOCALul
svmat localpred, names(col)
label var LOCALpr "Local means"

twoway (connected GLOBALpr GLOBALage, clcol(black) clpat(solid) msym(i)) ///
(connected LOCALpr LOCALage, clcol(black) clpat(dash) msym(i)), ///
ytitle("Pr(Happy)")

/*lets plot age pattern without covariates*/
logit hap_dic c.age##c.age##c.age##c.age ///
if nmiss==0, or
margins, at(age=(18(1)89)) atmeans
marginsplot
*********************************Ordered Logit**********************************
/*compute odds for more than 2 categories*/
tab hap married if nmiss==0
ologit hap married if nmiss==0, or
listcoef, percent

/*coef -> log odds*/
ologit hap c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0

/*use "or" for odds ratios*/
ologit hap c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, or
/*same deal as logit, but now reference is lower category of the DV. 
Odd assumed = between each category (level) of the DV*/

/*interpreting coefs, and reverse option*/
ologit hap c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, or 
listcoef, help
listcoef, reverse help

/*parallel regression assumption: Brant test*/
ologit hap c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, or
brant
/*advanced*/
/*gologit relaxes parallel lines assumption*/
/*help gologit2: must download package*/
gologit2 hap c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, ///
or autofit

/*What about magnitude? Predicted probability: probs for entire sample*/
ologit hap c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, or
/*store predicted probabilities*/
predict prnot prpretty prvery if nmiss==0
dotplot prnot prpretty prvery
ylabel(0(.25)1,grid gmin gmax) ytitle("Probability")
/*let's compute the average probability*/
egen mprvery=mean(prvery) if nmiss==0
egen mprpretty=mean(prpretty) if nmiss==0
egen mprnot=mean(prnot) if nmiss==0
/*should be close to sample mean*/
tab hap if nmiss==0
sum mprnot mprpretty mprvery /*0.13, 0.56, 0.31*/ 

/*Predicted probabilities: Marginal effects*/
/*Average marginal effect (AME)*/
ologit hap c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, or
mchange educ
/*change educ to dummy groups*/
ologit hap c.age##c.age i.female i.nonwhite i.educat i.married if nmiss==0, or
mchange educat
/*Marginal effect at the mean (MEM)*/
mchange, atmeans statistics(ci) decimals(4)
/*Marginal effect at representative values (MER)*/
/*age 40, female, white, HS*/
mchange married, at(married=0 age=40 female=1 nonwhite=0 educat=1)
/*age 40, male, white, HS*/
mchange married, at(married=0 age=40 female=0 nonwhite=0 educat=1)

/*plot AMEs*/
/*graphing changes in predicted probabilities*/
ologit hap c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, or
mchange
mchangeplot, title("AME: N=NTH P=PH V=VH") symbols(N P V) sig(.05) ///
min(-.22) max(.22)
/*graphing changes in predicted probabilities: with categorical dummies*/
ologit hap c.age##c.age i.female i.nonwhite i.educat i.married if nmiss==0, or
mchange educat
mchangeplot educat, title("AME: N=NTH P=PH V=VH") symbols(N P V) sig(.05) ///
min(-.12) max(.12)

/*predicted probabilites*/
/*by education all else at global means*/
ologit hap c.age##c.age i.female i.nonwhite i.educat i.married if nmiss==0, or
mtable, at(educat=(0 1 2)) atmeans
/*by education and race at local means*/
ologit hap c.age##c.age i.female i.nonwhite i.educat i.married if nmiss==0, or
mtable, over(educat nonwhite) atmeans

/*ideal types*/
ologit hap c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, or
mtable, at(age==40 female==0 educ==12 married==0 nonwhite==0) ///
at (age==40 female==0 educ==12 married==0 nonwhite==1) ///
at (age==40 female==1 educ==12 married==0 nonwhite==0) ///
at (age==40 female==1 educ==12 married==0 nonwhite==1) ///
at (age==40 female==0 educ==12 married==1 nonwhite==0) ///
at (age==40 female==0 educ==12 married==1 nonwhite==1) ///
at (age==40 female==1 educ==12 married==1 nonwhite==0) ///
at (age==40 female==1 educ==12 married==1 nonwhite==1)
/*Advanced: comparing ideal types*/
ologit hap c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, or
/*store estimates to test with mlincom*/
estimates store olm
/*compare white vs nonwhite with everything else set at same value*/
mlincom, clear
forvalues iout = 1/3 { // start loop
quietly {
mtable, out(`iout') post at(age==40 female==0 educ==12 married==0 nonwhite==0) ///
at (age==40 female==0 educ==12 married==0 nonwhite==1)
mlincom 1-2, stats(est pvalue) rowname(outcome `iout') add
estimates restore olm
}
} // end loop
/*check results*/
mlincom

/*request ci*/
ologit hap c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, or
mtable, at(age==40 female==0 educ==12 married==0 nonwhite==0) ci ///
at (age==40 female==0 educ==12 married==0 nonwhite==1)

/*graphing predicted probabilities: age pattern in happiness all other at mean*/
/*age*/
ologit hap c.age i.female i.nonwhite c.educ i.married if nmiss==0, or
mgen, at(age=(18(1)89)) atmeans stub(CL5_)
graph twoway connected CL5_pr1 CL5_pr2 CL5_pr3 CL5_age
/*age2*/
ologit hap c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, or
mgen, at(age=(18(1)89)) atmeans stub(CL1_)
graph twoway connected CL1_pr1 CL1_pr2 CL1_pr3 CL1_age
/*age3*/
ologit hap c.age##c.age##c.age  i.female i.nonwhite c.educ i.married if nmiss==0, or
mgen, at(age=(18(1)89)) atmeans stub(CL2_)
graph twoway connected CL2_pr1 CL2_pr2 CL2_pr3 CL2_age
*******************************Ologit vs. Oprobit*******************************
ologit hap c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, or
predict prologit if nmiss==0
estimates store Aologit
oprobit hap c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0
predict proprobit if nmiss==0
estimates store Aoprobit
estimates table Aologit Aoprobit /*compare coef*/
scatter prologit proprobit /*compare pred. prob*/

/*can use same postestimation techniques, except or, to examine probit results*/
/*AME*/
ologit hap c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, or
mchange, decimals(4)
oprobit hap c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0
mchange, decimals(4)
/*MEM*/
ologit hap c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, or
mchange, atmeans decimals(4)
oprobit hap c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0
mchange, atmeans decimals(4)
/*MER*/
ologit hap c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, or
mchange, at(married=0 age=40 female=1 nonwhite=0 educat=1) decimals(4)
oprobit hap c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0
mchange, at(married=0 age=40 female=1 nonwhite=0 educat=1) decimals(4)
/*Ideal types*/
/*gen _sel40W = age==40 & nonwhite==0
label var _sel40W "40yr whites"
gen _sel40N = age==40 & nonwhite==1
label var _sel40N "40yr non-whites"*/
ologit hap c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, or
mtable if _sel40W==1, rowname(1 40yr whites) atmeans ci
mtable if _sel40N==1, rowname(2 40yr non-whites) atmeans ci below
oprobit hap c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0
mtable if _sel40W==1, rowname(1 40yr whites) atmeans ci
mtable if _sel40N==1, rowname(2 40yr non-whites) atmeans ci below
**************************Ologit & Oprobit Diagnostics**************************
/*LR chi2: overall model fit*/ 
/*lets test a nested model, without and with education*/
ologit hap c.age##c.age i.female i.nonwhite i.married if nmiss==0, or
/*see how LR chi2 value increases after adding educ.*/
ologit hap c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, or
/*also check out the pseudo R2: compare the two models*/

/*AIC & BIC*/
ologit hap c.age##c.age i.female i.nonwhite i.married if nmiss==0, or
quietly fitstat, save
/*see how AIC & BIC decreases after adding educ.?*/
ologit hap c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, or
fitstat, dif
*****************************logit & ologit review******************************
/*odds ratios: binary logit*/
logit hap_dic c.age##c.age i.female i.nonwhite i.married i.educat if nmiss==0, or
/*odds ratios: ordered logit*/
ologit hap c.age##c.age i.female i.nonwhite i.married i.educat if nmiss==0, or
/*compare ologit to linear reg*/
reg hap c.age##c.age i.female i.nonwhite i.married i.educat if nmiss==0

/*predicted probabilities: check out mean and range*/
/*binary logit*/
logit hap_dic c.age##c.age i.female i.nonwhite i.married i.educat if nmiss==0, or
/*store predicted probabilities*/
predict prlogit if e(sample)==1 /*"e(sample) stata generated for "in model"*/
sum prlogit
/*visually inspect distribution of predicted probabilities*/
dotplot prlogit
/*ordered logit*/
ologit hap c.age##c.age i.female i.nonwhite i.married i.educat if nmiss==0, or
/*store predicted probabilities: create one var for each outcome category*/
predict prnot prpretty prvery if e(sample)==1 
sum prnot prpretty prvery
dotplot prnot prpretty prvery

/*marginal effects: consider AME, MEM, MER*/
/*binary logit*/
logit hap_dic c.age##c.age i.female i.nonwhite i.married i.educat if nmiss==0, or
/*AME*/ mchange, decimals(4)
/*MEM*/ mchange, atmeans decimals(4)
/*MER*/ mchange, at(married=0 age=40 female=1 nonwhite=0 educat=1) decimals(4)
/*ordered logit*/
ologit hap c.age##c.age i.female i.nonwhite i.married i.educat if nmiss==0, or
/*AME*/ mchange, decimals(4)
/*MEM*/ mchange, atmeans decimals(4)
/*MER*/ mchange educat, at(married=0 age=40 female=1 nonwhite=0 educat=1) decimals(4)

/*predicted probabilities*/
/*subgroup means: w vs nw differ on female educ married*/
/*creat indicator variables for each hypothetical group*/
gen _sel40W = age==40 & nonwhite==0
label var _sel40W "40yr whites"
gen _sel40N = age==40 & nonwhite==1
label var _sel40N "40yr non-whites"
/*binary logit*/
logit hap_dic c.age##c.age i.female i.nonwhite i.married i.educat if nmiss==0, or
mtable if _sel40W==1, rowname(1 40yr whites) atmeans ci
mtable if _sel40N==1, rowname(2 40yr non-whites)atmeans ci below
/*ordered logit*/
ologit hap c.age##c.age i.female i.nonwhite i.married i.educat if nmiss==0, or
mtable if _sel40W==1, rowname(1 40yr whites) atmeans ci
mtable if _sel40N==1, rowname(2 40yr non-whites)atmeans ci below

/*graphing predicted probabilities*/
/*happiness by educational attainment (years)*/
/*binary logit*/
logit hap_dic c.age##c.age i.female i.nonwhite i.married c.educ if nmiss==0, or
mgen, at(educ=(0(1)20)) replace atmeans stub(CL0_)
graph twoway connected CL0_pr1 CL0_educ
/*ordered logit*/
ologit hap c.age##c.age i.female i.nonwhite i.married c.educ if nmiss==0, or
mgen, at(educ=(0(1)20)) atmeans replace stub(CL1_)
graph twoway connected CL1_pr1 CL1_pr2 CL1_pr3 CL1_educ
***************************Ologit cutpoint example******************************
/*does happiness differ by marital status?*/
tab hap married if nmiss==0, column chi2 /*doesn't tell us direction*/

ologit hap married if nmiss==0
/*compute predicted probabilites by married using cutpoints*/
generate probnothappymarried=1/(1+exp(_b[married]-_b[/cut1]))
generate probnothappysingle=exp(_b[/cut1])/(1+exp(_b[/cut1]))
generate probprettyhappymarried=1/(1+exp(_b[married]-_b[/cut2]))-probnothappymarried
generate probprettyhappysingle=exp(_b[/cut2])/(1+exp(_b[/cut2]))-probnothappysingle
generate probveryhappymarried=1-probnothappymarried-probprettyhappymarried
generate probveryhappysingle=1-probnothappysingle-probprettyhappysingle
sum probnothappymarried probprettyhappymarried probveryhappymarried ///
probnothappysingle probprettyhappysingle probveryhappysingle
/*should be close to Stata computed (rounding error)*/
mtable if married==1
mtable if married==0
*********************Ologit proportional odds example***************************
/*compute the cumulative odds*/
tab hap if nmiss==0
/*now by marrital status*/
tab hap married if nmiss==0, column
/*use cumulative odds to compute odds ratios*/
/*the odds ratios should be comparable to each other, if not this violates the 
assumption that they are...need ologit to test this with brant*/
/*recall, Stata takes a weighted average - should be close to ologit results*/
ologit hap i.married if nmiss==0, or 
brant
/*works same for inverse*/
gen single=.
replace single=1 if married==0
replace single=0 if married==1
ologit hap i.single if nmiss==0, or 
brant
*****************************Marginal flipping sign*****************************
ologit hap c.age i.female i.nonwhite i.married c.educ if nmiss==0, or
mgen, at(educ=(0(1)20)) atmeans replace stub(CL1_)
graph twoway connected CL1_pr1 CL1_pr2 CL1_pr3 CL1_educ
/*discrete change at education of zero-years*/
mchange educ, at(educ=0) atmeans stat(change) brief
/*discrete change at education of 15yrs*/
mchange educ, at(educ=15) atmeans stat(change) brief
*****************************O/logit Interaction********************************
/*binary logit*/
/*does the association of happiness with education differ by race*/
/*first let's check out the ORs and p-value of the main effects w/o interaction*/
logit hap_dic c.age##c.age i.female c.educ i.nonwhite i.married ///
if nmiss==0, or /*educ=1.10252***, nonwhite=0.6566978***/
quietly fitstat, save /*let's save to compare with interaction model*/
/*plot predicted probs for race by education at race-specific means*/
mgen if nonwhite==0, at(educ=(0(1)20)) replace stub(nonint0) predlab(white) atmeans
mgen if nonwhite==1, at(educ=(0(1)20)) replace stub(nonint1) predlab(nonwhite) atmeans
twoway connected nonint0pr1 nonint1pr1 nonint0educ
/*now lets check out the average marginal effects of education by race*/
mtable, dydx(educ) at(nonwhite=(0 1)) post
/*let's check if they are statistically differnt*/
mlincom 2-1
/*the AME for education is different for whites vs. nonwhites, however this 
does not mean education operates differently by race (i.e., race moderates edu)*/
/*To test this we need to include an interaction term (educ*race)*/
logit hap_dic c.age##c.age i.female c.educ##i.nonwhite i.married ///
if nmiss==0, or /*educ=1.118406***, nonwhite=1.12477, educ*race=0.9556351***/
fitstat, dif /*better fit compared to model without interaction*/
/*compared to the results based on a model with only main effects: nonwhite is 
no longer significant. Education appears to be more important for whites (the 
odds of happiness increase by 12% with each additional year of education, whereas
the odds of happines increase by only 8% for nonwhites with each additional year
of education.   Recall odds are linear, and the interaction effect could
differ across different combinations of other x values in terms of probability,
which is nonlinear*/
/*plot predicted probs for race by education*/
mgen if nonwhite==0, at(educ=(0(1)20)) replace stub(nonint0) predlab(white) atmeans
mgen if nonwhite==1, at(educ=(0(1)20)) replace stub(nonint1) predlab(nonwhite) atmeans
twoway connected nonint0pr1 nonint1pr1 nonint0educ
/*now lets check out the average marginal effects of education by race*/
mtable, dydx(educ) over(nonwhite) post
/*let's check if they are statistically differnt*/
mlincom 2-1
/*not significant - what about race by edu?*/
logit hap_dic c.age##c.age i.female c.educ##i.nonwhite i.married ///
if nmiss==0, or
mtable, dydx(nonwhite) over(educ) stat(ci) post
mlincom 2-1
mlincom 4-3
mlincom 6-5
mlincom 8-7
mlincom 10-9
mlincom 12-11
mlincom 14-13
mlincom 16-15
mlincom 18-17
mlincom 20-19
mlincom 21-20
/*should correspond with the diff in the prob between race-edu groups*/
logit hap_dic c.age##c.age i.female c.educ##i.nonwhite i.married ///
if nmiss==0, or
mtable, at(nonwhite=(0 1)) over(educ) stat(ci) 

/*see for stata files and programs from Long & Mustillo 2021*/
search groupsbrm
help groupsbrm
/*example converted from long-mustillow-groups-goodhlt - let's use some macros*/
//  Options for graphs
* prob curves
global LINwht clcol(blue) lpat(solid) lwid(*1.2) ///
              msym(S) mcol(blue) msiz(*.93)
global LINnon clcol(black) lpat(solid) lwid(*1.2) ///
              msym(O) mcol(black)  msiz(*1.1)
* dc curve
global LINdc  clcol(black*1) lpat(solid) lwid(*1.2) ///
              msym(T) mcol(black*.9) msiz(*.9)
global LINci  msym(i i) clwid(*.7 *.7) clcol(black*.5 black*.5) ///
              clpat(dash dash)

logit hap_dic c.age##c.age i.female c.educ##i.nonwhite i.married ///
if nmiss==0, or

mgen if nonwhite==0, at(educ=(0(1)20)) atmeans stub(AprW) ///
    predlabel(White) replace // pr(happy) if white

mgen if nonwhite==1, at(educ=(0(1)20)) atmeans stub(AprN) ///
    predlabel(Nonwhite) replace // pr(happy) if nonwhite
	
mgen, dydx(nonwhite) over(educ) stub(Adc) ///
    predlabel(DC) replace //  DCrace
label var Adcll1 "95% confidence interval"
label var Adcul1 "95% confidence interval"

twoway ///
    (connected AprWpr1 AprWeduc, $LINwht) ///
    (connected AprNpr1 AprWeduc, $LINnon), ///
    ytitle(Pr(Happy)) xtitle(Educ) ///
    xlabel(0(1)20) ylabel(.5(.1)1, gmin gmax grid) ///
    legend(rows(1) order(2 1)) scale(1.2)

graph export long-mustillo-groups-goodhlth-agePR.pdf, replace

gen RAdcd_pr1 = -1 * Adcd_pr1 // reversing the direction looks better
gen RAdcll1   = -1 * Adcll1
gen RAdcul1   = -1 * Adcul1
label var Adcll1 "95% confidence interval"

twoway  ///
    (connected Adcd_pr1      Adceduc, $LINdc) /// line
    (connected Adcll1 Adcul1 Adceduc, $LINci), /// ci
    ytitle("Pr(Happy | White)" "- Pr(Happy | Nonwhite)") ///
    xtitle(Educ) xlabel(0(1)20) ylabel(-.1(.1).2, grid gmin gmax) ///
    yline(0, lcol(black) lwid(*.6)) ///
    legend(pos(6) ring(1) cols(1) order(3) symxsize(7)) scale(1.2) 

*************************************Mlogit*************************************
/*let's introduce a new variable to practice Mlogit*/
/*political affiliation*/
tab partyid, m
/*recode to republican, democrat, independent*/
/*missing if "other"*/
codebook partyid
gen polparty=.
replace polparty=1 if partyid==0 | partyid==1 /*democrat*/
replace polparty=2 if partyid==5 | partyid==6 /*republican*/
replace polparty=3 if partyid==2 | partyid==3 | partyid==4 /*idependent*/
tab polparty partyid, m
/*let's add labels - mlogit can get confusing*/
label variable polparty "Political Affiliation"
label define polparty 1 Democrat 2 Republican 3 Independent
label values polparty "polparty"
tab polparty if nmiss==0

/*multiple BRM example: just for learning, don't do this IRL*/
gen dem_ind = .
replace dem_ind=1 if polparty==1
replace dem_ind=0 if polparty==3
tab dem_ind polparty, m

gen rep_ind = .
replace rep_ind=1 if polparty==2
replace rep_ind=0 if polparty==3
tab rep_ind polparty, m

gen dem_rep = .
replace dem_rep=1 if polparty==1
replace dem_rep=0 if polparty==2
tab rep_ind polparty, m

drop if nmiss!=0
drop if polparty==.
tab polparty, m
tab dem_ind, m
tab rep_ind, m
tab dem_rep, m

/*how does political affilation vary by education?: A BRM approach*/
logit dem_ind educ if nmiss==0
logit rep_ind educ if nmiss==0
logit dem_rep educ if nmiss==0
/*check against Mlogit results*/
mlogit polparty educ if nmiss==0, base(3)
/*this was just an exercise for learning - don't need to do this*/

/*can change base outcome to see other contrasts*/
mlogit polparty educ if nmiss==0, base(2)
mlogit polparty educ if nmiss==0, base(1)
/*can also use listcoef to see all possible contrasts*/
listcoef

/*let's add some more covariates*/
mlogit polparty hap c.age##c.age i.female i.nonwhite i.married c.educ ///
if nmiss==0, base(1)
listcoef

/*independence of alternatives assumption tests*/
/*won't work for me, but not encouraged anyways*/
/*hausman-mcfadden*/
mlogit polparty hap c.age##c.age i.female i.nonwhite i.married c.educ ///
if nmiss==0, base(1)
mlogtest, hausman
/*small-hsiao*/
mlogit polparty hap c.age##c.age i.female i.nonwhite i.married c.educ ///
if nmiss==0, base(1)
mlogtest, hausman
set seed 124386
mlogtest, smhsiao

/*predicted probabilities: check out mean and range*/
mlogit polparty hap c.age##c.age i.female i.nonwhite i.married c.educ ///
if nmiss==0, base(1)
estimates store mlogit
/*store predicted probabilities: create one var for each outcome category*/
predict mnlmD mnlmR mnlmI if e(sample)==1 
codebook mnlmD mnlmR mnlmI, compact
dotplot mnlmD mnlmR mnlmI

/*Predicted probabilities: Marginal effects*/
/*Average marginal effect (AME)*/
mlogit polparty hap c.age##c.age i.female i.nonwhite i.married c.educ ///
if nmiss==0, base(1)
mchange
/*Marginal effect at the mean (MEM)*/
mchange, atmeans
/*Marginal effect at representative values (MER)*/
/*very happy, married, age 40, female, white, 12-years edu*/
mchange female, at(female=1 hap=3 married=1 age=40 nonwhite=0 educ=12)
/*very happy, married, age 40, female, nonwhite, 12-years edu*/
mchange female, at(female=1 hap=3 married=1 age=40 nonwhite=1 educ=12)

/*plot AMEs*/
/*graphing changes in predicted probabilities*/
mlogit polparty hap c.age##c.age i.female i.nonwhite i.married c.educ ///
if nmiss==0, base(1)
mchange
mchangeplot, min(-.28) max(.28) sig(.05)

/*predicted probabilites*/
/*by education all else at global means*/
mlogit polparty hap c.age##c.age i.female i.nonwhite i.married i.educat ///
if nmiss==0, base(1)
mtable, at(educat=(0 1 2)) atmeans
/*by education and race at local means*/
mlogit polparty hap c.age##c.age i.female i.nonwhite i.married i.educat ///
if nmiss==0, base(1)
mtable, over(educat nonwhite) atmeans

/*ideal types*/
mlogit polparty hap c.age##c.age i.female i.nonwhite i.married c.educ ///
if nmiss==0, base(1)
mtable, at(age==40 female==0 educ==12 married==0 nonwhite==0) ///
at (age==40 female==0 educ==12 married==0 nonwhite==1) ///
at (age==40 female==1 educ==12 married==0 nonwhite==0) ///
at (age==40 female==1 educ==12 married==0 nonwhite==1) ///
at (age==40 female==0 educ==12 married==1 nonwhite==0) ///
at (age==40 female==0 educ==12 married==1 nonwhite==1) ///
at (age==40 female==1 educ==12 married==1 nonwhite==0) ///
at (age==40 female==1 educ==12 married==1 nonwhite==1)

/*graphing predicted probabilities: age pattern in happiness all other at mean*/
/*age*/
mlogit polparty hap c.age##c.age i.female i.nonwhite i.married c.educ ///
if nmiss==0, base(1)
mgen, at(educ=(0(1)20)) atmeans stub(mnl_) replace
graph twoway connected mnl_pr1 mnl_pr2 mnl_pr3 mnl_educ, ///
ylab(0(.2).6)
/*lets see if the education pattern is quadratic*/
mlogit polparty hap c.age##c.age i.female i.nonwhite i.married c.educ##c.educ ///
if nmiss==0, base(1)
mgen, at(educ=(0(1)20)) atmeans stub(mnl_) replace
graph twoway connected mnl_pr1 mnl_pr2 mnl_pr3 mnl_educ
/*for whites*/
mlogit polparty hap c.age##c.age i.female i.nonwhite i.married c.educ##c.educ ///
if nmiss==0, base(1)
mgen, at(educ=(0(1)20)nonwhite=0) atmeans stub(mnl_) replace
graph twoway connected mnl_pr1 mnl_pr2 mnl_pr3 mnl_educ, ylab(0(.2).8)
/*and nonwhites*/
mgen, at(educ=(0(1)20)nonwhite=1) atmeans stub(mnl_) replace
graph twoway connected mnl_pr1 mnl_pr2 mnl_pr3 mnl_educ, ylab(0(.2).8)

/*odds ratios*/
mlogit polparty hap c.age##c.age i.female i.nonwhite i.married i.educat ///
if nmiss==0, base(1) rrr
/*see all posible comparison groups for a given x (e.g., nonwhites)*/
listcoef nonwhite, help
/*plot the odds ratios*/
mlogitplot nonwhite, base(1) ormin(.05) ormax(6.35)
mlogitplot nonwhite, base(2) ormin(.05) ormax(6.35)
mlogitplot nonwhite, base(3) ormin(.05) ormax(6.35)

/*see distribution of marginal effects on pp 420*/
/*possibly add to logit and ologit*/

*********************************Mlogit vs Ologit*******************************
/*read in fresh data if changed sample with above exercises*/
clear all
set maxvar 30000
********************************************************************************
use \\ad.uky.edu\AS\Sociology\aba423\Desktop\Data\GSS_stata\GSS7218V2.dta, clear
set more off
set seed 12132016
********************************************************************************
ologit hap c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, or
brant /*violated parallel assumption: let's use mlogit*/
/*"rrr" = "or" for ologit: relative risk of being in group vs. base*/
mlogit hap c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, b(1) rrr
/*"b(1)" makes "not happy" base outcome category: default group w/ most resp.*/
listcoef /*can also specificy IVs if don't want results for all*/
/*"listcoef" to include all potential comparisons*/

/*compare range of predicted probs*/
/*see pp 413*/
mlogit hap c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, b(1) rrr
estimates store mlogit
predict mnlmN mnlmP mnlmV if nmiss==0
codebook mnlmN mnlmP mnlmV, compact

ologit hap c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, or
predict olmN olmP olmV if nmiss==0
codebook olm*, compact
/*Not Happy*/
label var olmN "ologit"
label var mnlmN "mlogit"
dotplot olmN mnlmN, ylabel(0(.2).8, grid) ytitle(Pr(Not Happy))
/*Pretty Happy*/
label var olmP "ologit"
label var mnlmP "mlogit"
dotplot olmP mnlmP, ylabel(0(.2).8, grid) ytitle(Pr(Pretty Happy))
/*Very Happy*/
label var olmV "ologit"
label var mnlmV "mlogit"
dotplot olmV mnlmV, ylabel(0(.2).8, grid) ytitle(Pr(Very Happy))
**************************ols, ologit, mlogit compare***************************
/*age pattern in happiness: predicted probs and predicted scores*/
mlogit hap c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, rrr nolog
mgen, at(age=(18(1)89)) atmeans stub(mlo1_)
ologit hap c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, or nolog
mgen, at(age=(18(1)89)) atmeans stub(olo1_)
label var mlo1_pr3 "mlogit"
label var olo1_pr3 "ologit"
graph twoway connected olo1_pr3 mlo1_pr3 olo1_age , ytitle(Pr(Very Happy)) ///
ylab(.20(.05).50)
label var mlo1_pr2 "mlogit"
label var olo1_pr2 "ologit"
graph twoway connected olo1_pr2 mlo1_pr2 mlo1_age , ytitle(Pr(Pretty Happy)) ///
ylab(.40(.05).70)
label var mlo1_pr1 "mlogit"
label var olo1_pr1 "ologit"
graph twoway connected olo1_pr1 mlo1_pr1 mlo1_age , ytitle(Pr(Not Happy)) ///
ylab(.00(.05).30)

reg hap c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0
mgen, at(age=(18(1)89)) atmeans stub(ols1_)
graph twoway connected ols1_xb ols1_age , ytitle(Happiness Score)ylab(2(.10)2.5)
**************************Poisson & negative binomial***************************
/*Poisson distribution example*/
clear all 
set obs 21
gen k = _n - 1
label var k "y = # of events"
gen psn1 = poissonp(0.8, k)
label var psn1 "&mu = 0.8"
gen psn2 = poissonp(1.5, k)
label var psn2 "&mu = 1.5"
gen psn3 = poissonp(2.9, k)
label var psn3 "&mu = 2.9"
gen psn4 = poissonp(10.5, k)
label var psn4 "&mu = 10.5"
graph twoway connected psn1 psn2 psn3 psn4 k, ///
ytitle("Probability") ylabel(0(.1).5) xlabel(0(2)20) ///
lwidth(thin thin thin thin) msymbol (O D S T)

********************************************************************************
clear all
set maxvar 30000
********************************************************************************
use \\ad.uky.edu\AS\Sociology\aba423\Desktop\Data\GSS_stata\GSS7218V2.dta, clear
set more off
set seed 12132016
********************************************************************************
/*let's create a count variable*/
/*number of opposite sex sex partners since 18*/
gen numpart =.
replace numpart = numwomen if female==0
replace numpart = nummen if female==1
replace numpart=. if numpart>750
tab numpart if nmiss==0

/*check out the mean and variance*/ 
sum numpart if nmiss==0, detail
hist numpart if nmiss==0

/*compare observed and predicted counts*/
poisson numpart if nmiss==0, nolog
mgen, pr(0/25) meanpred stub(psn) replace
list psnval psnobeq psnpreq in 1/21
label var psnobeq "Observed"
label var psnpreq "Poisson prediction"
label var psnval "# of Partners"
graph twoway connected psnobeq psnpreq psnval, ///
ytitle("Probability") ylabel(0(.1).26,gmax) xlabel(0/25) msym(O Th)

/*do number of partners differ by sex?*/
sort female
by female: sum numpar if nmiss==0, detail
/*looks like the mean for males is much higher, but need to test this*/
poisson numpart i.female if nmiss==0
/*let's make sex = male and compare*/
gen male=.
replace male=1 if female==0
replace male=0 if female==1
poisson numpart i.male if nmiss==0

*let's add our full set of usual controls*/
/*factor and percentage change*/
poisson numpart c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, irr
listcoef, percent help

/*marginal effects*/
/*AME*/
poisson numpart c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, irr
mchange
/*MEM*/
poisson numpart c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, irr
mchange, atmeans
/*MER*/
poisson numpart c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, irr
mchange female, at(female=1 nonwhite=0 educ=12 married=0 age=40)
mchange female, at(female=1 nonwhite=0 educ=12 married=1 age=40)
/*whatever you place after mchange is allowed to change, even if set in at()*/
mchange female, at(nonwhite=0 educ=12 married=0 age=40)

/*predicted probabilites*/
poisson numpart c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, irr
mtable, at(female=(0 1) married=0 nonwhite=0 educ=12 age=40) pr(0/100) width(3)
/*test if marginal effects are significant*/
poisson numpart c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, irr
mchange female, at(married=0 nonwhite=0 educ=12 age=40) pr(0/100) ///
stat(from to change p) brief

/*graphing predicted probabilites*/
poisson numpart c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, irr
mgen if married==0 & female==1, atmeans at(age=(20(5)35)) ///
stub(Fprm) pr(1) predlabel(Single Women)
mgen if married==0 & female==0, atmeans at(age=(20(5)35)) ///
stub(Mprm) pr(1) predlabel(Single Men)
graph twoway connected Fprmpr1 Mprmpr1 Mprmage, ///
ytitle("Probablility of Only 1 Sexual Partner Since 18")

/*Evaluate model: compare observed and predicted counts*/
poisson numpart  if nmiss==0
mgen, stub(PDF) pr(0/25) meanpred replace
poisson numpart c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, irr
mgen, stub(PRM) pr(0/25) meanpred replace
label var PDFobeq "Observed"
label var PDFpreq "Poisson PDF"
label var PRMpreq "PRM"
graph twoway connected PDFobeq PDFpreq PRMpreq PRMval, ///
ytitle("Probability") xlabel(0/25) msym(O Th Sh)

/*Negative binomial regression (NBRM)*/
nbreg numpart c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, irr
estimates store NBRM
/*compare with Poisson*/
quietly poisson numpart c.age##c.age i.female i.nonwhite c.educ i.married ///
 if nmiss==0, irr
 estimates store PRM
 estimates table PRM NBRM, b(%9.3f) t p(%9.3f) varlabel ///
stats(alpha N) eform vsquish

/*graphing predicted probabilites*/
/*make same graph as with poisson above*/
nbreg numpart c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, irr
mgen if married==0 & female==1, atmeans at(age=(20(5)35)) ///
stub(Fprm) pr(1) predlabel(Single Women) replace
mgen if married==0 & female==0, atmeans at(age=(20(5)35)) ///
stub(Mprm) pr(1) predlabel(Single Men) replace
graph twoway connected Fprmpr1 Mprmpr1 Mprmage, ///
ytitle("Probablility of Only 1 Sexual Partner Since 18")


/*let's compare poisson and NBER in regard to pr(0))*/
poisson numpart c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, irr
mgen, atmeans at(age=(20(5)35)) stub(PRM) pr(0) replace
nbreg numpart c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, irr
mgen, atmeans at(age=(20(5)35)) stub(NBRM) pr(0) replace
label var PRMpr0 "PRM"
label var NBRMpr0 "NBRM"
graph twoway ///
(rarea PRMll0 PRMul0 PRMage, color(gs14)) ///
(rarea NBRMll0 NBRMul0 NBRMage, color(gs14)) ///
(connected PRMpr0 NBRMage, lpattern(dash) msize(zero)) ///
(connected NBRMpr0 NBRMage, lpattern(solid) msize(zero)), ///
legend(on order(3 4)) ///
ytitle("Probability of a zero count")

/*compare mean probabilities across various models*/
poisson numpart c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, irr
mgen, stub(PRM) pr(0/25) meanpred replace
nbreg numpart c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, irr
mgen, stub(NBRM) pr(0/25) meanpred replace
zip numpart c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, ///
inflate(c.age##c.age i.female i.nonwhite c.educ i.married) 
mgen, stub(ZIP) pr(0/25) meanpred replace
/*couldn't get zinb to converge
zinb numpart c.age##c.age i.female i.nonwhite c.educ i.married if nmiss==0, ///
inflate(c.age##c.age i.female i.nonwhite c.educ i.married) nolog
mgen, stub(ZINB) pr(0/25) meanpred replace*/
label var PRMobeq "Observed"
label var PRMpreq "PRM"
label var NBRMpreq "NBRM"
label var ZIPpreq "ZIP"
/*label var ZINBpreq "ZINB"*/
graph twoway connected PRMobeq PRMpreq NBRMpreq ZIPpreq PRMval, ///
ytitle(Average Predicted Probability) xlabel(0/25) msymbol(TH Oh Sh O) ///
legend(col(3) holes(3))

/*formal tests to compare models*/
countfit numpart c.age##c.age i.female i.nonwhite c.educ i.married ///
 if nmiss==0, inflate(i.female i.married) prm nbreg zip replace maxcount(25)


