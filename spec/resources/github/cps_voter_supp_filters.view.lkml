include: "cps_voter_supp_base.view.lkml"
view: CPS_Voting_and_Registration_Filters {
  extends: [CPS_Voting_and_Registration]

  filter: select_hehousut {
    label: "Type of living quarters"
    view_label: "Group Household Variables"
    suggest_dimension: hehousut
  }

  filter: select_hephoneo {
    label: "Phone interview acceptable,y/n"
    view_label: "Group Household Variables"
    suggest_dimension: hephoneo
  }

  filter: select_hetelavl {
    label: "No residential phone,available elsewhere,y/n"
    view_label: "Group Household Variables"
    suggest_dimension: hetelavl
  }

  filter: select_hetelhhd {
    label: "Phone in living quarters,y/n"
    view_label: "Group Household Variables"
    suggest_dimension: hetelhhd
  }

  filter: select_hetenure {
    label: "Own/rent living quarters"
    view_label: "Group Household Variables"
    suggest_dimension: hetenure
  }

  filter: select_hrhtype {
    label: "Type of family/single individual"
    view_label: "Group Household Variables"
    suggest_dimension: hrhtype
  }

  filter: select_hrintsta {
    label: "Interview/non-interview status"
    view_label: "Group Household Variables"
    suggest_dimension: hrintsta
  }

  filter: select_hrlonglk {
    label: "Longitudinal link indicator"
    view_label: "Group Household Variables"
    suggest_dimension: hrlonglk
  }

  filter: select_hrmis {
    label: "Month-in-sample"
    view_label: "Group Household Variables"
    suggest_dimension: hrmis
  }

  filter: select_hrmonth {
    label: "Month of interview"
    view_label: "Group Household Variables"
    suggest_dimension: hrmonth
  }

  filter: select_hrnumhou {
    label: "Total # of members"
    view_label: "Group Household Variables"
    suggest_dimension: hrnumhou
  }

  filter: select_hubus {
    label: "Presence of business/farm in hhld,y/n"
    view_label: "Group Labor Force Variables"
    suggest_dimension: hubus
  }

  filter: select_hubusl1 {
    label: "Line numbers of business/farm owners 1"
    view_label: "Group Labor Force Variables"
    suggest_dimension: hubusl1
  }

  filter: select_hubusl2 {
    label: "Line numbers of business/farm owners 2"
    view_label: "Group Labor Force Variables"
    suggest_dimension: hubusl2
  }

  filter: select_hubusl3 {
    label: "Line numbers of business/farm owners 3"
    view_label: "Group Labor Force Variables"
    suggest_dimension: hubusl3
  }

  filter: select_hubusl4 {
    label: "Line numbers of business/farm owners 4"
    view_label: "Group Labor Force Variables"
    suggest_dimension: hubusl4
  }

  filter: select_huinttyp {
    label: "Type of interview,personal/telephone"
    view_label: "Group Household Variables"
    suggest_dimension: huinttyp
  }

  filter: select_hurespli {
    label: "Line number of current respondent"
    view_label: "Group Household Variables"
    suggest_dimension: hurespli
  }

  filter: select_hutypb {
    label: "Type b non-interview categories"
    view_label: "Group Household Variables"
    suggest_dimension: hutypb
  }

  filter: select_peafnow {
    label: "Currently in armed forces,y/n"
    view_label: "Group Demographic Variables"
    suggest_dimension: peafnow
  }

  filter: select_peeduca {
    label: "Highest level of school completed"
    view_label: "Group Demographic Variables"
    suggest_dimension: peeduca
  }

  filter: select_pemaritl {
    label: "Marital status"
    view_label: "Group Demographic Variables"
    suggest_dimension: pemaritl
  }

  filter: select_peparent {
    label: "Parent line number"
    view_label: "Group Demographic Variables"
    suggest_dimension: peparent
  }

  filter: select_perrp {
    label: "Relationship to reference person"
    view_label: "Group Demographic Variables"
    suggest_dimension: perrp
  }

  filter: select_pesex {
    label: "Sex"
    view_label: "Group Demographic Variables"
    suggest_dimension: pesex
  }

  filter: select_pespouse {
    label: "Spouse line number"
    view_label: "Group Demographic Variables"
    suggest_dimension: pespouse
  }

  filter: select_prcitflg {
    label: "Citizenship allocation flag"
    view_label: "Group Demographic Variables"
    suggest_dimension: prcitflg
  }

  filter: select_prcitshp {
    label: "United states citizenship group"
    view_label: "Group Demographic Variables"
    suggest_dimension: prcitshp
  }

  filter: select_prfamnum {
    label: "Family number"
    view_label: "Group Demographic Variables"
    suggest_dimension: prfamnum
  }

  filter: select_prfamrel {
    label: "Family relationship(recode)"
    view_label: "Group Demographic Variables"
    suggest_dimension: prfamrel
  }

  filter: select_prfamtyp {
    label: "Family type(recode)"
    view_label: "Group Demographic Variables"
    suggest_dimension: prfamtyp
  }

  filter: select_prmarsta {
    label: "Marital status(recode)"
    view_label: "Group Demographic Variables"
    suggest_dimension: prmarsta
  }

  filter: select_prpertyp {
    label: "Person type(recode)"
    view_label: "Group Demographic Variables"
    suggest_dimension: prpertyp
  }

  filter: select_prtage {
    label: "Demographics - age topcoded at 85, 90 or 80 (see full description)"
    view_label: "Group Demographic Variables"
    suggest_dimension: prtage
  }

  filter: select_prtfage {
    label: "Top coded flag for age"
    view_label: "Group Demographic Variables"
    suggest_dimension: prtfage
  }

  filter: select_puchinhh {
    label: "Reason for the changes in household composition"
    view_label: "Group Demographic Variables"
    suggest_dimension: puchinhh
  }

  filter: select_pulineno {
    label: "Line number"
    view_label: "Group Demographic Variables"
    suggest_dimension: pulineno
  }

  filter: select_peabspdo {
    label: "Paid absence from work,y/n"
    view_label: "Group Labor Force Variables"
    suggest_dimension: peabspdo
  }

  filter: select_peabsrsn {
    label: "Reason for work absence last week"
    view_label: "Group Labor Force Variables"
    suggest_dimension: peabsrsn
  }

  filter: select_pedw4wk {
    label: "(not in,discouraged)worked in last 4 weeks"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pedw4wk
  }

  filter: select_pedwavl {
    label: "(not in,discouraged)available for job last week"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pedwavl
  }

  filter: select_pedwavr {
    label: "(not in,discouraged)reason can't work"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pedwavr
  }

  filter: select_pedwlko {
    label: "(not in,discouraged)look for work in past year"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pedwlko
  }

  filter: select_pedwlkwk {
    label: "(not in,discouraged)looked since last job,y/n"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pedwlkwk
  }

  filter: select_pedwrsn {
    label: "(not in,discouraged)reason not looking"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pedwrsn
  }

  filter: select_pedwwk {
    label: "(not in,discouraged)worked in past year,y/n"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pedwwk
  }

  filter: select_pedwwnto {
    label: "(not in,discouraged)wanted a job,y/n"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pedwwnto
  }

  filter: select_pehract1 {
    label: "# hours actually worked at main job"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pehract1
  }

  filter: select_pehract2 {
    label: "# hours actually worked at other job(s)"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pehract2
  }

  filter: select_pehractt {
    label: "# hours actually worked at all jobs"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pehractt
  }

  filter: select_pehravl {
    label: "(part-timer)available for full-time,y/n"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pehravl
  }

  filter: select_pehrftpt {
    label: "Usually work full-time,y/n"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pehrftpt
  }

  filter: select_pehrrsn1 {
    label: "(part-timer)reason"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pehrrsn1
  }

  filter: select_pehrrsn2 {
    label: "(part-timer)reason not full-time"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pehrrsn2
  }

  filter: select_pehrrsn3 {
    label: "(full-timer)reason part-time last week"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pehrrsn3
  }

  filter: select_pehrusl1 {
    label: "# hours usually worked at main job"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pehrusl1
  }

  filter: select_pehrusl2 {
    label: "# hours usually worked at other job(s)"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pehrusl2
  }

  filter: select_pehruslt {
    label: "# hours usually worked at all jobs"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pehruslt
  }

  filter: select_pehrwant {
    label: "Full-time work desired,y/n"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pehrwant
  }

  filter: select_pejhrsn {
    label: "(not in,job history)reason left last job"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pejhrsn
  }

  filter: select_pejhwant {
    label: "(not in,job history)look for work in next year"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pejhwant
  }

  filter: select_pejhwko {
    label: "(not in,job history)worked in past year,y/n"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pejhwko
  }

  filter: select_pelayavl {
    label: "(layoff)available for work if recalled,y/n"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pelayavl
  }

  filter: select_pelaydur {
    label: "(layoff)# weeks looking for job"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pelaydur
  }

  filter: select_pelayfto {
    label: "(layoff)from full-time job,y/n"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pelayfto
  }

  filter: select_pelaylk {
    label: "(layoff)called back,still looking for work,y/n"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pelaylk
  }

  filter: select_pelkavl {
    label: "(unemployed)available for work last week,y/n"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pelkavl
  }

  filter: select_pelkdur {
    label: "(unemployed)#weeks on job search"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pelkdur
  }

  filter: select_pelkfto {
    label: "(unemployed)looking-full-time work wanted,y/n"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pelkfto
  }

  filter: select_pelkll1o {
    label: "(unemployed)looking-activity before search"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pelkll1o
  }

  filter: select_pelkll2o {
    label: "(unemployed)looking-lost/quit job"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pelkll2o
  }

  filter: select_pelklwo {
    label: "(unemployed)looking-when last worked"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pelklwo
  }

  filter: select_pelkm1 {
    label: "(unemployed)looking-search methods"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pelkm1
  }

  filter: select_pemjnum {
    label: "# of jobs had"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pemjnum
  }

  filter: select_pemjot {
    label: "Had multiple jobs,y/n"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pemjot
  }

  filter: select_pemlr {
    label: "Employment status"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pemlr
  }

  filter: select_penlfact {
    label: "(not in)reason"
    view_label: "Group Labor Force Variables"
    suggest_dimension: penlfact
  }

  filter: select_penlfjh {
    label: "(not in)last worked at job/business"
    view_label: "Group Labor Force Variables"
    suggest_dimension: penlfjh
  }

  filter: select_penlfret {
    label: "(retired) from job/business,y/n"
    view_label: "Group Labor Force Variables"
    suggest_dimension: penlfret
  }

  filter: select_peret1 {
    label: "(retired)want full/part-time job,y/n"
    view_label: "Group Labor Force Variables"
    suggest_dimension: peret1
  }

  filter: select_prabsrea {
    label: "Work absence,reason & pay status"
    view_label: "Group Labor Force Variables"
    suggest_dimension: prabsrea
  }

  filter: select_prcivlf {
    label: "Part of/not part of"
    view_label: "Group Labor Force Variables"
    suggest_dimension: prcivlf
  }

  filter: select_prdisc {
    label: "Discouraged worker/conditionally interested"
    view_label: "Group Labor Force Variables"
    suggest_dimension: prdisc
  }

  filter: select_premphrs {
    label: "Reason for work absence or hours at work"
    view_label: "Group Labor Force Variables"
    suggest_dimension: premphrs
  }

  filter: select_prempnot {
    label: "Employment status,recode"
    view_label: "Group Labor Force Variables"
    suggest_dimension: prempnot
  }

  filter: select_prerelg {
    label: "Earnings edit eligibility flag"
    view_label: "Group Earnings Variables"
    suggest_dimension: prerelg
  }

  filter: select_prexplf {
    label: "Employed/unemployed"
    view_label: "Group Labor Force Variables"
    suggest_dimension: prexplf
  }

  filter: select_prftlf {
    label: "Full-time/part-time"
    view_label: "Group Labor Force Variables"
    suggest_dimension: prftlf
  }

  filter: select_prhrusl {
    label: "Hours usually worked weekly"
    view_label: "Group Labor Force Variables"
    suggest_dimension: prhrusl
  }

  filter: select_prjobsea {
    label: "Job search,recode"
    view_label: "Group Labor Force Variables"
    suggest_dimension: prjobsea
  }

  filter: select_prpthrs {
    label: "(part-timer)economic/non-economic reasons,hours"
    view_label: "Group Labor Force Variables"
    suggest_dimension: prpthrs
  }

  filter: select_prptrea {
    label: "(part-timer)specific reason"
    view_label: "Group Labor Force Variables"
    suggest_dimension: prptrea
  }

  filter: select_prunedur {
    label: "Unemployment duration"
    view_label: "Group Labor Force Variables"
    suggest_dimension: prunedur
  }

  filter: select_pruntype {
    label: "Unemployment reason"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pruntype
  }

  filter: select_prwksch {
    label: "Employment status by time worked/lost"
    view_label: "Group Labor Force Variables"
    suggest_dimension: prwksch
  }

  filter: select_prwkstat {
    label: "Full-time/part-time work status"
    view_label: "Group Labor Force Variables"
    suggest_dimension: prwkstat
  }

  filter: select_prwntjob {
    label: "(not in)or wants job-recode"
    view_label: "Group Labor Force Variables"
    suggest_dimension: prwntjob
  }

  filter: select_puabsot {
    label: "Output var determines absence from job"
    view_label: "Group Labor Force Variables"
    suggest_dimension: puabsot
  }

  filter: select_pubus1 {
    label: "Unpaid work in family business/farm,y/n"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pubus1
  }

  filter: select_pubus2ot {
    label: "Stores bus2 entry"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pubus2ot
  }

  filter: select_pubusck1 {
    label: "Filter for question on unpaid work"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pubusck1
  }

  filter: select_pubusck2 {
    label: "(family business)skips owners,no work last week"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pubusck2
  }

  filter: select_pubusck3 {
    label: "Filter for business owners to absence reason"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pubusck3
  }

  filter: select_pubusck4 {
    label: "Filter for business owners skip pattern"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pubusck4
  }

  filter: select_pudis {
    label: "Verify disability status from previous month"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pudis
  }

  filter: select_pudis1 {
    label: "Probe #1 for disability"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pudis1
  }

  filter: select_pudis2 {
    label: "Probe #2 for disability"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pudis2
  }

  filter: select_pudwck1 {
    label: "Filter for discouraged worker screening"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pudwck1
  }

  filter: select_pudwck2 {
    label: "Filter for disabled"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pudwck2
  }

  filter: select_pudwck3 {
    label: "Filter for retired"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pudwck3
  }

  filter: select_pudwck4 {
    label: "Filter/plug for passive jobseekers"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pudwck4
  }

  filter: select_pudwck5 {
    label: "Filter/plug for passive jobseeker"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pudwck5
  }

  filter: select_puhrck1 {
    label: "Remove groups from actual hours series"
    view_label: "Group Labor Force Variables"
    suggest_dimension: puhrck1
  }

  filter: select_puhrck12 {
    label: "Filter for <15 hours to go to looking series"
    view_label: "Group Labor Force Variables"
    suggest_dimension: puhrck12
  }

  filter: select_puhrck2 {
    label: "Skips persons out of pt series"
    view_label: "Group Labor Force Variables"
    suggest_dimension: puhrck2
  }

  filter: select_puhrck3 {
    label: "Skips persons out of pt series"
    view_label: "Group Labor Force Variables"
    suggest_dimension: puhrck3
  }

  filter: select_puhrck4 {
    label: "Skips persons"
    view_label: "Group Labor Force Variables"
    suggest_dimension: puhrck4
  }

  filter: select_puhrck5 {
    label: "Filter for multiple jobholders for job 2 hours"
    view_label: "Group Labor Force Variables"
    suggest_dimension: puhrck5
  }

  filter: select_puhrck6 {
    label: "Filter for actual hours jobs 1 and 2"
    view_label: "Group Labor Force Variables"
    suggest_dimension: puhrck6
  }

  filter: select_puhrck7 {
    label: "Filter for hours worked paths"
    view_label: "Group Labor Force Variables"
    suggest_dimension: puhrck7
  }

  filter: select_puhroff1 {
    label: "Any work hours were lost last week"
    view_label: "Group Labor Force Variables"
    suggest_dimension: puhroff1
  }

  filter: select_puhroff2 {
    label: "Number of work hours lost last week"
    view_label: "Group Labor Force Variables"
    suggest_dimension: puhroff2
  }

  filter: select_puhrot1 {
    label: "Extra hours worked last week"
    view_label: "Group Labor Force Variables"
    suggest_dimension: puhrot1
  }

  filter: select_puhrot2 {
    label: "Number of extra hours worked last week"
    view_label: "Group Labor Force Variables"
    suggest_dimension: puhrot2
  }

  filter: select_pujhck1 {
    label: "Filter for outgoing rotations"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pujhck1
  }

  filter: select_pujhck2 {
    label: "Filter for persons going thru i&o series"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pujhck2
  }

  filter: select_pujhck3 {
    label: "Filter for unemployed job history"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pujhck3
  }

  filter: select_pujhck4 {
    label: "(not in)filter for dependent"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pujhck4
  }

  filter: select_pujhck5 {
    label: "(not in)filter/carryover for dependent"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pujhck5
  }

  filter: select_pujhdp1o {
    label: "Out variable for jhdp1"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pujhdp1o
  }

  filter: select_pulay {
    label: "Person on layoff from job"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pulay
  }

  filter: select_pulay6m {
    label: "Person on layoff,recalled in 6 months,y/n"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pulay6m
  }

  filter: select_pulayavr {
    label: "Person on layoff,reason unavailable to work"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pulayavr
  }

  filter: select_pulayck1 {
    label: "Filter for previous month layoff status"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pulayck1
  }

  filter: select_pulayck2 {
    label: "Filter/plug for dependent layoff"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pulayck2
  }

  filter: select_pulayck3 {
    label: "Dependent i & o filter/carryover"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pulayck3
  }

  filter: select_pulaydt {
    label: "Person on layoff,has return date,y/n"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pulaydt
  }

  filter: select_pulk {
    label: "Looked for work in last 4 wks"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pulk
  }

  filter: select_pulkavr {
    label: "Reason jobseeker unavailable last week"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pulkavr
  }

  filter: select_pulkdk1 {
    label: "(unemployed) followup to lkm1"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pulkdk1
  }

  filter: select_pulkdk2 {
    label: "(looking for work)followup to lkm2"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pulkdk2
  }

  filter: select_pulkdk3 {
    label: "(looking for work)followup to lkm3"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pulkdk3
  }

  filter: select_pulkdk4 {
    label: "(looking for work)followup to lkm4"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pulkdk4
  }

  filter: select_pulkdk5 {
    label: "(looking for work)followup to lkm5"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pulkdk5
  }

  filter: select_pulkdk6 {
    label: "(looking for work)followup to lkm6"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pulkdk6
  }

  filter: select_pulkm2 {
    label: "(job search)methods,all in last 4 weeks"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pulkm2
  }

  filter: select_pulkm3 {
    label: "(job search)methods-followup"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pulkm3
  }

  filter: select_pulkm4 {
    label: "(job search)methods-followup2"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pulkm4
  }

  filter: select_pulkm5 {
    label: "(job search)methods followup3"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pulkm5
  }

  filter: select_pulkm6 {
    label: "(job search)methods followup4"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pulkm6
  }

  filter: select_pulkps1 {
    label: "(job search)passive entry to lkm1-followup"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pulkps1
  }

  filter: select_pulkps2 {
    label: "(job search)passive entry to lkm2-followup"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pulkps2
  }

  filter: select_pulkps3 {
    label: "(job search)passive entry to lkm3-followup"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pulkps3
  }

  filter: select_pulkps4 {
    label: "(job search)passive entry to lkm4-followup"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pulkps4
  }

  filter: select_pulkps5 {
    label: "(job search)passive entry to lkm5-followup"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pulkps5
  }

  filter: select_pulkps6 {
    label: "(job search)passive entry to lkm6-followup"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pulkps6
  }

  filter: select_punlfck1 {
    label: "Age filter for retirement question"
    view_label: "Group Labor Force Variables"
    suggest_dimension: punlfck1
  }

  filter: select_punlfck2 {
    label: "Outgoing rotation filter"
    view_label: "Group Labor Force Variables"
    suggest_dimension: punlfck2
  }

  filter: select_puretot {
    label: "Verify retirement status,previous month"
    view_label: "Group Labor Force Variables"
    suggest_dimension: puretot
  }

  filter: select_puslfprx {
    label: "Information given by self/proxy"
    view_label: "Group Labor Force Variables"
    suggest_dimension: puslfprx
  }

  filter: select_puwk {
    label: "Did work for pay/profit"
    view_label: "Group Labor Force Variables"
    suggest_dimension: puwk
  }

  filter: select_peio1cow {
    label: "(main job)class of worker"
    view_label: "Group Industry"
    suggest_dimension: peio1cow
  }

  filter: select_peio2cow {
    label: "(second job)class of worker"
    view_label: "Group Industry"
    suggest_dimension: peio2cow
  }

  filter: select_puio1mfg {
    label: "(main job)in manufacturing/wholesale/retail"
    view_label: "Group Industry"
    suggest_dimension: puio1mfg
  }

  filter: select_puio2mfg {
    label: "(second job)in manufacturing/wholesale/retail"
    view_label: "Group Industry"
    suggest_dimension: puio2mfg
  }

  filter: select_puiock1 {
    label: "Filter for dependent industry & occupation"
    view_label: "Group Industry"
    suggest_dimension: puiock1
  }

  filter: select_puiock2 {
    label: "Filter for previous month's referred i&o cases"
    view_label: "Group Industry"
    suggest_dimension: puiock2
  }

  filter: select_puiock3 {
    label: "Filter for previous month's unknown occupation"
    view_label: "Group Industry"
    suggest_dimension: puiock3
  }

  filter: select_puiodp1 {
    label: "Verification of previous month's employer"
    view_label: "Group Industry"
    suggest_dimension: puiodp1
  }

  filter: select_puiodp2 {
    label: "Job duties changed since last month,y/n"
    view_label: "Group Industry"
    suggest_dimension: puiodp2
  }

  filter: select_puiodp3 {
    label: "Verify previous month's occupation description"
    view_label: "Group Industry"
    suggest_dimension: puiodp3
  }

  filter: select_ptern {
    label: "(weekly)amount of overtime earnings"
    view_label: "Group Earnings Variables"
    suggest_dimension: ptern
  }

  filter: select_peerncov {
    label: "Covered by labor union/employee contract,y/n"
    view_label: "Group Earnings Variables"
    suggest_dimension: peerncov
  }

  filter: select_pternh1o {
    label: "Hourly pay rate,amount"
    view_label: "Group Earnings Variables"
    suggest_dimension: pternh1o
  }

  filter: select_pternh2 {
    label: "(main job)hourly pay rate,amount"
    view_label: "Group Earnings Variables"
    suggest_dimension: pternh2
  }

  filter: select_peernhro {
    label: "#hours usually worked"
    view_label: "Group Earnings Variables"
    suggest_dimension: peernhro
  }

  filter: select_peernhry {
    label: "Hourly/non-hourly worker"
    view_label: "Group Earnings Variables"
    suggest_dimension: peernhry
  }

  filter: select_peernlab {
    label: "Union member,y/n"
    view_label: "Group Earnings Variables"
    suggest_dimension: peernlab
  }

  filter: select_peernper {
    label: "When received,periodicity"
    view_label: "Group Earnings Variables"
    suggest_dimension: peernper
  }

  filter: select_peernrt {
    label: "Paid hourly,y/n"
    view_label: "Group Earnings Variables"
    suggest_dimension: peernrt
  }

  filter: select_peernuot {
    label: "Overtime pay/tips/commission,y/n"
    view_label: "Group Earnings Variables"
    suggest_dimension: peernuot
  }

  filter: select_peernwkp {
    label: "#paid weeks per year"
    view_label: "Group Earnings Variables"
    suggest_dimension: peernwkp
  }

  filter: select_pternhly {
    label: "Hourly pay rate,amount-recode"
    view_label: "Group Earnings Variables"
    suggest_dimension: pternhly
  }

  filter: select_pternwa {
    label: "Weekly earnings,amount-recode"
    view_label: "Group Earnings Variables"
    suggest_dimension: pternwa
  }

  filter: select_prhernal {
    label: "Persons hourly earnings recode allocation flag"
    view_label: "Group Earnings Variables"
    suggest_dimension: prhernal
  }

  filter: select_prwernal {
    label: "(person)weekly earnings allocation flag-recode"
    view_label: "Group Earnings Variables"
    suggest_dimension: prwernal
  }

  filter: select_pthr {
    label: "Hourly pay-top code"
    view_label: "Group Earnings Variables"
    suggest_dimension: pthr
  }

  filter: select_ptot {
    label: "Weekly overtime,amount-top code flag"
    view_label: "Group Earnings Variables"
    suggest_dimension: ptot
  }

  filter: select_ptwk {
    label: "Weekly-top code flag"
    view_label: "Group Earnings Variables"
    suggest_dimension: ptwk
  }

  filter: select_ptern2 {
    label: "(calculated)weekly overtime"
    view_label: "Group Earnings Variables"
    suggest_dimension: ptern2
  }

  filter: select_pternh1c {
    label: "Hourly pay rate,excluding overtime"
    view_label: "Group Earnings Variables"
    suggest_dimension: pternh1c
  }

  filter: select_peschenr {
    label: "In high school/college/university,y/n"
    view_label: "Group Basic CPS School Enrollment Variables"
    suggest_dimension: peschenr
  }

  filter: select_peschft {
    label: "Full-time/part-time student"
    view_label: "Group Basic CPS School Enrollment Variables"
    suggest_dimension: peschft
  }

  filter: select_peschlvl {
    label: "In high school/college/university"
    view_label: "Group Basic CPS School Enrollment Variables"
    suggest_dimension: peschlvl
  }

  filter: select_prnlfsch {
    label: "(not in labor force)school/not in school"
    view_label: "Group Basic CPS School Enrollment Variables"
    suggest_dimension: prnlfsch
  }

  filter: select_gereg {
    label: "Region"
    view_label: "Group Geography Variables"
    suggest_dimension: gereg
  }

  filter: select_pedipged {
    label: "High school,graduation/ged"
    view_label: "Group Demographic Variables"
    suggest_dimension: pedipged
  }

  filter: select_pehgcomp {
    label: "Highest grade completed before ged"
    view_label: "Group Demographic Variables"
    suggest_dimension: pehgcomp
  }

  filter: select_pecyc {
    label: "Years of college credit completed"
    view_label: "Group Demographic Variables"
    suggest_dimension: pecyc
  }

  filter: select_pegrprof {
    label: "(have b.s./b.a.)taken graduate/prof. courses"
    view_label: "Group Demographic Variables"
    suggest_dimension: pegrprof
  }

  filter: select_pegr6cor {
    label: "Completed 6 or more graduate courses,y/n"
    view_label: "Group Demographic Variables"
    suggest_dimension: pegr6cor
  }

  filter: select_pems123 {
    label: "Master's program 1, 2, or 3 years"
    view_label: "Group Demographic Variables"
    suggest_dimension: pems123
  }

  filter: select_hryear4 {
    label: "4 digit year of interview"
    view_label: "Group Household Variables"
    suggest_dimension: hryear4
  }

  filter: select_prchld {
    label: "Presence of own children <18 years by age group"
    view_label: "Group Demographic Variables"
    suggest_dimension: prchld
  }

  filter: select_prnmchld {
    label: "Number of own children <18 years of age"
    view_label: "Group Demographic Variables"
    suggest_dimension: prnmchld
  }

  filter: select_pehspnon {
    label: "Hispanic origin"
    view_label: "Group Demographic Variables"
    suggest_dimension: pehspnon
  }

  filter: select_prmlr {
    label: "Employment status recode"
    view_label: "Group Labor Force Variables"
    suggest_dimension: prmlr
  }

  filter: select_prmjind1 {
    label: "(main job)industry,major groups"
    view_label: "Group Industry"
    suggest_dimension: prmjind1
  }

  filter: select_prmjind2 {
    label: "(second job)industry,major groups-recode"
    view_label: "Group Industry"
    suggest_dimension: prmjind2
  }

  filter: select_prmjocc1 {
    label: "(main job)occupation,major groups-recode"
    view_label: "Group Industry"
    suggest_dimension: prmjocc1
  }

  filter: select_prmjocc2 {
    label: "(second job)occupation,major groups-recode"
    view_label: "Group Industry"
    suggest_dimension: prmjocc2
  }

  filter: select_prcow1 {
    label: "(main job)class of worker-recode"
    view_label: "Group Industry"
    suggest_dimension: prcow1
  }

  filter: select_prcow2 {
    label: "(second job)class of worker-recode"
    view_label: "Group Industry"
    suggest_dimension: prcow2
  }

  filter: select_prdtcow1 {
    label: "(main job)detailed class of worker"
    view_label: "Group Industry"
    suggest_dimension: prdtcow1
  }

  filter: select_prdtcow2 {
    label: "(second job)detailed class of worker-recode"
    view_label: "Group Industry"
    suggest_dimension: prdtcow2
  }

  filter: select_prdtind1 {
    label: "(main job)detailed industry"
    view_label: "Group Industry"
    suggest_dimension: prdtind1
  }

  filter: select_prdtind2 {
    label: "(second job)detailed industry-recode"
    view_label: "Group Industry"
    suggest_dimension: prdtind2
  }

  filter: select_prdtocc1 {
    label: "(main job)detailed occupation groups-recode"
    view_label: "Group Industry"
    suggest_dimension: prdtocc1
  }

  filter: select_prdtocc2 {
    label: "(second job)detailed occupation groups-recode"
    view_label: "Group Industry"
    suggest_dimension: prdtocc2
  }

  filter: select_premp {
    label: "Employed non-farm/non-private hhld industries"
    view_label: "Group Labor Force Variables"
    suggest_dimension: premp
  }

  filter: select_prnagws {
    label: "Non-agriculture/salary workers"
    view_label: "Group Industry"
    suggest_dimension: prnagws
  }

  filter: select_prnagpws {
    label: "Non-agriculture/private/salary workers-recode"
    view_label: "Group Industry"
    suggest_dimension: prnagpws
  }

  filter: select_pragna {
    label: "Industry,agriculture/non-agriculture"
    view_label: "Group Industry"
    suggest_dimension: pragna
  }

  filter: select_prsjmj {
    label: "Single/multiple jobholder-recode"
    view_label: "Group Industry"
    suggest_dimension: prsjmj
  }

  filter: select_prcowpg {
    label: "(main job)class of worker,private/government"
    view_label: "Group Industry"
    suggest_dimension: prcowpg
  }

  filter: select_prmjocgr {
    label: "(main job)occupation,7 groups"
    view_label: "Group Industry"
    suggest_dimension: prmjocgr
  }

  filter: select_prioelg {
    label: "Industry and occupation edit eligibility flag"
    view_label: "Group Labor Force Variables"
    suggest_dimension: prioelg
  }

  filter: select_primind1 {
    label: "(main job)detailed industry"
    view_label: "Group Industry"
    suggest_dimension: primind1
  }

  filter: select_primind2 {
    label: "(second job)detailed industry"
    view_label: "Group Industry"
    suggest_dimension: primind2
  }

  filter: select_preduca4 {
    label: "Recode - 4 categories"
    view_label: "Group Demographic Variables"
    suggest_dimension: preduca4
  }

  filter: select_preduca5 {
    label: "Recode - 5 categories"
    view_label: "Group Demographic Variables"
    suggest_dimension: preduca5
  }

  filter: select_gtcbsast {
    label: "Principal city/balance status"
    view_label: "Group Geography Variables"
    suggest_dimension: gtcbsast
  }

  filter: select_gtmetsta {
    label: "Metropolitan status"
    view_label: "Group Geography Variables"
    suggest_dimension: gtmetsta
  }

  filter: select_gtindvpc {
    label: "Individual central city code"
    view_label: "Group Geography Variables"
    suggest_dimension: gtindvpc
  }

  filter: select_gtcbsasz {
    label: "Metropolitan statistical area size"
    view_label: "Group Geography Variables"
    suggest_dimension: gtcbsasz
  }

  filter: select_hutypc {
    label: "Type c non-interview categories"
    view_label: "Group Household Variables"
    suggest_dimension: hutypc
  }

  filter: select_huprscnt {
    label: "# of actual & attempted personal contacts"
    view_label: "Group Household Variables"
    suggest_dimension: huprscnt
  }

  filter: select_hufinal {
    label: "Final code,status of interview"
    view_label: "Group Household Variables"
    suggest_dimension: hufinal
  }

  filter: select_peafever {
    label: "Ever serve on active duty"
    view_label: "Group Demographic Variables"
    suggest_dimension: peafever
  }

  filter: select_peafwhn1 {
    label: "Past military service, period of active duty"
    view_label: "Group Demographic Variables"
    suggest_dimension: peafwhn1
  }

  filter: select_peafwhn2 {
    label: "Past military service, period of active duty"
    view_label: "Group Demographic Variables"
    suggest_dimension: peafwhn2
  }

  filter: select_peafwhn3 {
    label: "Past military service, period of active duty"
    view_label: "Group Demographic Variables"
    suggest_dimension: peafwhn3
  }

  filter: select_peafwhn4 {
    label: "Past military service, period of active duty"
    view_label: "Group Demographic Variables"
    suggest_dimension: peafwhn4
  }

  filter: select_pedadtyp {
    label: "Type of father"
    view_label: "Group Demographic Variables"
    suggest_dimension: pedadtyp
  }

  filter: select_pelnmom {
    label: "Line number of mother"
    view_label: "Group Demographic Variables"
    suggest_dimension: pelnmom
  }

  filter: select_pelndad {
    label: "Line number of father"
    view_label: "Group Demographic Variables"
    suggest_dimension: pelndad
  }

  filter: select_pemomtyp {
    label: "Type of mother"
    view_label: "Group Demographic Variables"
    suggest_dimension: pemomtyp
  }

  filter: select_pecohab {
    label: "Line number of cohabiting partner"
    view_label: "Group Demographic Variables"
    suggest_dimension: pecohab
  }

  filter: select_pedisear {
    label: "Disability - deaf or serious difficulty hearing"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pedisear
  }

  filter: select_pediseye {
    label: "Disability - blind or difficulty seeing even with glasses"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pediseye
  }

  filter: select_pedisrem {
    label: "Disability - difficulty remembering or making decisions"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pedisrem
  }

  filter: select_pedisphy {
    label: "Disability - difficulty walking or climbing stairs"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pedisphy
  }

  filter: select_pedisdrs {
    label: "Disability - difficulty dressing or bathing"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pedisdrs
  }

  filter: select_pedisout {
    label: "Disability - difficulty doing errands"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pedisout
  }

  filter: select_prdisflg {
    label: "Disability - recode, disabled"
    view_label: "Group Labor Force Variables"
    suggest_dimension: prdisflg
  }

  filter: select_hutypea {
    label: "Type a non-interview categories"
    view_label: "Group Household Variables"
    suggest_dimension: hutypea
  }

  filter: select_hefaminc {
    label: "Total family income in past 12 months"
    view_label: "Group Household Variables"
    suggest_dimension: hefaminc
  }

  filter: select_ptdtrace {
    label: "Demographics- race of respondent"
    view_label: "Group Demographic Variables"
    suggest_dimension: ptdtrace
  }

  filter: select_penatvty {
    label: "Demographics - native country of sample person"
    view_label: "Group Demographic Variables"
    suggest_dimension: penatvty
  }

  filter: select_pefntvty {
    label: "Demographics - native country of father"
    view_label: "Group Demographic Variables"
    suggest_dimension: pefntvty
  }

  filter: select_pemntvty {
    label: "Demographics - native country of mother"
    view_label: "Group Demographic Variables"
    suggest_dimension: pemntvty
  }

  filter: select_ptio1ocd {
    label: "(main job)occupation code"
    view_label: "Group Industry"
    suggest_dimension: ptio1ocd
  }

  filter: select_ptio2ocd {
    label: "(second job)occupation code"
    view_label: "Group Industry"
    suggest_dimension: ptio2ocd
  }

  filter: select_prdasian {
    label: "Demographics detailed asian subgroup"
    view_label: "Group Demographic Variables"
    suggest_dimension: prdasian
  }

  filter: select_peio1icd {
    label: "(main job)industry code"
    view_label: "Group Industry"
    suggest_dimension: peio1icd
  }

  filter: select_peio2icd {
    label: "(second job)industry code"
    view_label: "Group Industry"
    suggest_dimension: peio2icd
  }

  filter: select_prdthsp {
    label: "Detailed hispanic recode"
    view_label: "Group Demographic Variables"
    suggest_dimension: prdthsp
  }

  filter: select_pepdemp1 {
    label: "Individual has paid employees?"
    view_label: "Group Industry"
    suggest_dimension: pepdemp1
  }

  filter: select_pepdemp2 {
    label: "Individual has paid employees, second job"
    view_label: "Group Industry"
    suggest_dimension: pepdemp2
  }

  filter: select_ptnmemp1 {
    label: "-main job"
    view_label: "Group Industry"
    suggest_dimension: ptnmemp1
  }

  filter: select_ptnmemp2 {
    label: "-second job"
    view_label: "Group Industry"
    suggest_dimension: ptnmemp2
  }

  filter: select_prinuyer {
    label: "Recoded year of entry for foreign born"
    view_label: "Group Demographic Variables"
    suggest_dimension: prinuyer
  }

  filter: select_gtcsa {
    label: "Combined statistical area fips code"
    view_label: "Group Geography Variables"
    suggest_dimension: gtcsa
  }

  filter: select_gtcbsa {
    label: "Metropolitan statistical area fips code"
    view_label: "Group Geography Variables"
    suggest_dimension: gtcbsa
  }

  filter: select_pes1 {
    label: "Vote in the november election"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes1
  }

  filter: select_pes2 {
    label: "Registered to vote in the november election"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes2
  }

  filter: select_pusck4 {
    label: "Self or other reported for person"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pusck4
  }

  filter: select_pes3 {
    label: "Reason not registered"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes3
  }

  filter: select_pes4 {
    label: "Main reason (you/name) did not vote?"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes4
  }

  filter: select_pes5 {
    label: "Did you vote in person or did you vote by mail"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes5
  }

  filter: select_pes6 {
    label: "Was that on election day or before election day"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes6
  }

  filter: select_pes7 {
    label: "How did (you/name) register to vote?"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes7
  }

  filter: select_prs8 {
    label: "Time at current address"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: prs8
  }

  filter: select_gestcen {
    label: "Census state code"
    view_label: "Group Geography Variables"
    suggest_dimension: gestcen
  }

  filter: select_prdthsp_census_2012 {
    label: "Demographics- detailed hispanic origin subgroup"
    view_label: "Group Demographic Variables"
    suggest_dimension: prdthsp_census_2012
  }

  filter: select_peio2icd_census_2012 {
    label: "(second job)industry code"
    view_label: "Group Industry"
    suggest_dimension: peio2icd_census_2012
  }

  filter: select_pes8 {
    label: "Time at current address"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes8
  }

  filter: select_pupelig {
    label: "Interview status of persons in the household"
    view_label: "Group Demographic Variables"
    suggest_dimension: pupelig
  }

  filter: select_ptdtrace_census_2010 {
    label: "Demographics- race of respondent"
    view_label: "Group Demographic Variables"
    suggest_dimension: ptdtrace_census_2010
  }

  filter: select_prdthsp_census_2010 {
    label: "Demographics- detailed hispanic origin subgroup"
    view_label: "Group Demographic Variables"
    suggest_dimension: prdthsp_census_2010
  }

  filter: select_hutypea_census_2008 {
    label: "Type a non-interview categories"
    view_label: "Group Household Variables"
    suggest_dimension: hutypea_census_2008
  }

  filter: select_hufaminc {
    label: "Total family income in past 12 months"
    view_label: "Group Household Variables"
    suggest_dimension: hufaminc
  }

  filter: select_ptdtrace_census_2008 {
    label: "Demographics- race of respondent"
    view_label: "Group Demographic Variables"
    suggest_dimension: ptdtrace_census_2008
  }

  filter: select_prdthsp_census_2008 {
    label: "Demographics- detailed hispanic origin subgroup"
    view_label: "Group Demographic Variables"
    suggest_dimension: prdthsp_census_2008
  }

  filter: select_pes7_census_2008 {
    label: "How did you register to vote"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes7_census_2008
  }

  filter: select_huspnish {
    label: "Spanish only spoken"
    view_label: "Group Household Variables"
    suggest_dimension: huspnish
  }

  filter: select_hutypea_census_2006 {
    label: "Type a non-interview categories"
    view_label: "Group Household Variables"
    suggest_dimension: hutypea_census_2006
  }

  filter: select_pefntvty_census_2006 {
    label: "Native country of father"
    view_label: "Group Demographic Variables"
    suggest_dimension: pefntvty_census_2006
  }

  filter: select_pemntvty_census_2006 {
    label: "Native country of mother"
    view_label: "Group Demographic Variables"
    suggest_dimension: pemntvty_census_2006
  }

  filter: select_penatvty_census_2006 {
    label: "Native country of sample person"
    view_label: "Group Demographic Variables"
    suggest_dimension: penatvty_census_2006
  }

  filter: select_ptdtrace_census_2006 {
    label: "Demographics- race of respondent"
    view_label: "Group Demographic Variables"
    suggest_dimension: ptdtrace_census_2006
  }

  filter: select_prdthsp_census_2006 {
    label: "Demographics- detailed hispanic origin subgroup"
    view_label: "Group Demographic Variables"
    suggest_dimension: prdthsp_census_2006
  }

  filter: select_pes7_census_2006 {
    label: "How did you register to vote"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes7_census_2006
  }

  filter: select_hutypea_census_2004 {
    label: "Type a non-interview categories"
    view_label: "Group Household Variables"
    suggest_dimension: hutypea_census_2004
  }

  filter: select_peafwhen {
    label: "Past military service,period of active duty"
    view_label: "Group Demographic Variables"
    suggest_dimension: peafwhen
  }

  filter: select_pefntvty_census_2004 {
    label: "Native country of father"
    view_label: "Group Demographic Variables"
    suggest_dimension: pefntvty_census_2004
  }

  filter: select_pemntvty_census_2004 {
    label: "Native country of mother"
    view_label: "Group Demographic Variables"
    suggest_dimension: pemntvty_census_2004
  }

  filter: select_penatvty_census_2004 {
    label: "Native country of sample person"
    view_label: "Group Demographic Variables"
    suggest_dimension: penatvty_census_2004
  }

  filter: select_proldrrp {
    label: "Recode to collapse new rrp categories into old"
    view_label: "Group Demographic Variables"
    suggest_dimension: proldrrp
  }

  filter: select_puafever {
    label: "Ever did military service,y/n"
    view_label: "Group Demographic Variables"
    suggest_dimension: puafever
  }

  filter: select_ptdtrace_census_2004 {
    label: "Demographics- race of respondent"
    view_label: "Group Demographic Variables"
    suggest_dimension: ptdtrace_census_2004
  }

  filter: select_prdthsp_census_2004 {
    label: "Demographics- detailed hispanic origin subgroup"
    view_label: "Group Demographic Variables"
    suggest_dimension: prdthsp_census_2004
  }

  filter: select_pes7_census_2004 {
    label: "How did (you/name) register to vote?"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes7_census_2004
  }

  filter: select_hufinal_census_2002 {
    label: "Final code,status of interview"
    view_label: "Group Household Variables"
    suggest_dimension: hufinal_census_2002
  }

  filter: select_huhhnum {
    label: "Replacement number"
    view_label: "Group Household Variables"
    suggest_dimension: huhhnum
  }

  filter: select_huprscnt_census_2002 {
    label: "# of actual & attempted personal contacts"
    view_label: "Group Household Variables"
    suggest_dimension: huprscnt_census_2002
  }

  filter: select_hutypc_census_2002 {
    label: "Type c non-interview categories"
    view_label: "Group Household Variables"
    suggest_dimension: hutypc_census_2002
  }

  filter: select_hutypea_census_2002 {
    label: "Type a non-interview categories"
    view_label: "Group Household Variables"
    suggest_dimension: hutypea_census_2002
  }

  filter: select_pefntvty_census_2002 {
    label: "Native country of father"
    view_label: "Group Demographic Variables"
    suggest_dimension: pefntvty_census_2002
  }

  filter: select_pemntvty_census_2002 {
    label: "Native country of mother"
    view_label: "Group Demographic Variables"
    suggest_dimension: pemntvty_census_2002
  }

  filter: select_penatvty_census_2002 {
    label: "Native country of sample person"
    view_label: "Group Demographic Variables"
    suggest_dimension: penatvty_census_2002
  }

  filter: select_perace {
    label: "Race of respondent"
    view_label: "Group Demographic Variables"
    suggest_dimension: perace
  }

  filter: select_prhspnon {
    label: "Hispanic/non-hispanic origin"
    view_label: "Group Demographic Variables"
    suggest_dimension: prhspnon
  }

  filter: select_prorigin {
    label: "Hispanic origin or descent"
    view_label: "Group Demographic Variables"
    suggest_dimension: prorigin
  }

  filter: select_purelflg {
    label: "Flag for persons related to person owning bus."
    view_label: "Group Demographic Variables"
    suggest_dimension: purelflg
  }

  filter: select_pulbhsec {
    label: "Total seconds to complete labor force items"
    view_label: "Group Labor Force Variables"
    suggest_dimension: pulbhsec
  }

  filter: select_peio1icd_census_2002 {
    label: "(main job)industry code"
    view_label: "Group Industry"
    suggest_dimension: peio1icd_census_2002
  }

  filter: select_ptio1ocd_census_2002 {
    label: "(main job)occupation code"
    view_label: "Group Industry"
    suggest_dimension: ptio1ocd_census_2002
  }

  filter: select_peio2icd_census_2002 {
    label: "(second job)industry code"
    view_label: "Group Industry"
    suggest_dimension: peio2icd_census_2002
  }

  filter: select_ptio2ocd_census_2002 {
    label: "(second job)occupation code"
    view_label: "Group Industry"
    suggest_dimension: ptio2ocd_census_2002
  }

  filter: select_prdtind1_census_2002 {
    label: "(main job)detailed industry"
    view_label: "Group Industry"
    suggest_dimension: prdtind1_census_2002
  }

  filter: select_prdtind2_census_2002 {
    label: "(second job)detailed industry-recode"
    view_label: "Group Industry"
    suggest_dimension: prdtind2_census_2002
  }

  filter: select_prdtocc1_census_2002 {
    label: "(main job)detailed occupation groups-recode"
    view_label: "Group Industry"
    suggest_dimension: prdtocc1_census_2002
  }

  filter: select_prdtocc2_census_2002 {
    label: "(second job)detailed occupation groups-recode"
    view_label: "Group Industry"
    suggest_dimension: prdtocc2_census_2002
  }

  filter: select_prmjind1_census_2002 {
    label: "(main job)industry,major groups"
    view_label: "Group Industry"
    suggest_dimension: prmjind1_census_2002
  }

  filter: select_prmjind2_census_2002 {
    label: "(second job)industry,major groups-recode"
    view_label: "Group Industry"
    suggest_dimension: prmjind2_census_2002
  }

  filter: select_prmjocc1_census_2002 {
    label: "(main job)occupation,major groups-recode"
    view_label: "Group Industry"
    suggest_dimension: prmjocc1_census_2002
  }

  filter: select_prmjocc2_census_2002 {
    label: "(second job)occupation,major groups-recode"
    view_label: "Group Industry"
    suggest_dimension: prmjocc2_census_2002
  }

  filter: select_prmjocgr_census_2002 {
    label: "(main job)occupation,4 groups"
    view_label: "Group Industry"
    suggest_dimension: prmjocgr_census_2002
  }

  filter: select_peernvr1 {
    label: "(weekly),amount verification,y/n"
    view_label: "Group Earnings Variables"
    suggest_dimension: peernvr1
  }

  filter: select_peernvr3 {
    label: "(weekly)including over-time/tips/etc. amount,y/n"
    view_label: "Group Earnings Variables"
    suggest_dimension: peernvr3
  }

  filter: select_puernvr4 {
    label: "Confirm amount,y/n"
    view_label: "Group Earnings Variables"
    suggest_dimension: puernvr4
  }

  filter: select_gtcmsa {
    label: "Consolidated msa code"
    view_label: "Group Geography Variables"
    suggest_dimension: gtcmsa
  }

  filter: select_gecmsasz {
    label: "Cmsa/msa size"
    view_label: "Group Geography Variables"
    suggest_dimension: gecmsasz
  }

  filter: select_geindvcc {
    label: "Individual central city code"
    view_label: "Group Geography Variables"
    suggest_dimension: geindvcc
  }

  filter: select_gemetsta {
    label: "Metropolitan status"
    view_label: "Group Geography Variables"
    suggest_dimension: gemetsta
  }

  filter: select_gtmsast {
    label: "Msa/central city status"
    view_label: "Group Geography Variables"
    suggest_dimension: gtmsast
  }

  filter: select_gtmsasz {
    label: "Msa/pmsa size"
    view_label: "Group Geography Variables"
    suggest_dimension: gtmsasz
  }

  filter: select_gtmsa {
    label: "Msa code"
    view_label: "Group Geography Variables"
    suggest_dimension: gtmsa
  }

  filter: select_pes4_census_2002 {
    label: "Vote in person on election day or before, or by mail"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes4_census_2002
  }

  filter: select_pes5_census_2002 {
    label: "Did you register to vote after january 1, 1995"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes5_census_2002
  }

  filter: select_pes6_census_2002 {
    label: "Register when obtained or renewed license or other way"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes6_census_2002
  }

  filter: select_pes7_census_2002 {
    label: "How did you register to vote"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes7_census_2002
  }

  filter: select_pes3_census_2002 {
    label: "Main reason did not vote"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes3_census_2002
  }

  filter: select_hufinal_census_2000 {
    label: "Final code,status of interview"
    view_label: "Group Household Variables"
    suggest_dimension: hufinal_census_2000
  }

  filter: select_huprscnt_census_2000 {
    label: "# of actual & attempted personal contacts"
    view_label: "Group Household Variables"
    suggest_dimension: huprscnt_census_2000
  }

  filter: select_hutypc_census_2000 {
    label: "Type c non-interview categories"
    view_label: "Group Household Variables"
    suggest_dimension: hutypc_census_2000
  }

  filter: select_hutypea_census_2000 {
    label: "Type a non-interview categories"
    view_label: "Group Household Variables"
    suggest_dimension: hutypea_census_2000
  }

  filter: select_pefntvty_census_2000 {
    label: "Native country of father"
    view_label: "Group Demographic Variables"
    suggest_dimension: pefntvty_census_2000
  }

  filter: select_pemntvty_census_2000 {
    label: "Native country of mother"
    view_label: "Group Demographic Variables"
    suggest_dimension: pemntvty_census_2000
  }

  filter: select_penatvty_census_2000 {
    label: "Native country of sample person"
    view_label: "Group Demographic Variables"
    suggest_dimension: penatvty_census_2000
  }

  filter: select_peio1icd_census_2000 {
    label: "(main job)industry code"
    view_label: "Group Industry"
    suggest_dimension: peio1icd_census_2000
  }

  filter: select_ptio1ocd_census_2000 {
    label: "(main job)occupation code"
    view_label: "Group Industry"
    suggest_dimension: ptio1ocd_census_2000
  }

  filter: select_peio2icd_census_2000 {
    label: "(second job)industry code"
    view_label: "Group Industry"
    suggest_dimension: peio2icd_census_2000
  }

  filter: select_ptio2ocd_census_2000 {
    label: "(second job)occupation code"
    view_label: "Group Industry"
    suggest_dimension: ptio2ocd_census_2000
  }

  filter: select_prdtind1_census_2000 {
    label: "(main job)detailed industry"
    view_label: "Group Industry"
    suggest_dimension: prdtind1_census_2000
  }

  filter: select_prdtind2_census_2000 {
    label: "(second job)detailed industry-recode"
    view_label: "Group Industry"
    suggest_dimension: prdtind2_census_2000
  }

  filter: select_prdtocc1_census_2000 {
    label: "(main job)detailed occupation groups-recode"
    view_label: "Group Industry"
    suggest_dimension: prdtocc1_census_2000
  }

  filter: select_prdtocc2_census_2000 {
    label: "(second job)detailed occupation groups-recode"
    view_label: "Group Industry"
    suggest_dimension: prdtocc2_census_2000
  }

  filter: select_prmjind1_census_2000 {
    label: "(main job)industry,major groups"
    view_label: "Group Industry"
    suggest_dimension: prmjind1_census_2000
  }

  filter: select_prmjind2_census_2000 {
    label: "(second job)industry,major groups-recode"
    view_label: "Group Industry"
    suggest_dimension: prmjind2_census_2000
  }

  filter: select_prmjocc1_census_2000 {
    label: "(main job)occupation,major groups-recode"
    view_label: "Group Industry"
    suggest_dimension: prmjocc1_census_2000
  }

  filter: select_prmjocc2_census_2000 {
    label: "(second job)occupation,major groups-recode"
    view_label: "Group Industry"
    suggest_dimension: prmjocc2_census_2000
  }

  filter: select_prmjocgr_census_2000 {
    label: "(main job)occupation,4 groups"
    view_label: "Group Industry"
    suggest_dimension: prmjocgr_census_2000
  }

  filter: select_pes4_census_2000 {
    label: "Vote in person on election day or before, or by mail"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes4_census_2000
  }

  filter: select_pes5_census_2000 {
    label: "Did you register to vote after january 1, 1995"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes5_census_2000
  }

  filter: select_pes6_census_2000 {
    label: "Register when obtained or renewed license or other way"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes6_census_2000
  }

  filter: select_pes7_census_2000 {
    label: "How did you register to vote"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes7_census_2000
  }

  filter: select_pes3_census_2000 {
    label: "Main reason did not vote"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes3_census_2000
  }

  filter: select_hufinal_census_1998 {
    label: "Final code,status of interview"
    view_label: "Group Household Variables"
    suggest_dimension: hufinal_census_1998
  }

  filter: select_hulensec {
    label: "Total time(seconds) to complete interview"
    view_label: "Group Household Variables"
    suggest_dimension: hulensec
  }

  filter: select_huprscnt_census_1998 {
    label: "# of actual & attempted personal contacts"
    view_label: "Group Household Variables"
    suggest_dimension: huprscnt_census_1998
  }

  filter: select_hutypc_census_1998 {
    label: "Type c non-interview categories"
    view_label: "Group Household Variables"
    suggest_dimension: hutypc_census_1998
  }

  filter: select_hutypea_census_1998 {
    label: "Type a non-interview categories"
    view_label: "Group Household Variables"
    suggest_dimension: hutypea_census_1998
  }

  filter: select_pefntvty_census_1998 {
    label: "Native country of father"
    view_label: "Group Demographic Variables"
    suggest_dimension: pefntvty_census_1998
  }

  filter: select_pemntvty_census_1998 {
    label: "Native country of mother"
    view_label: "Group Demographic Variables"
    suggest_dimension: pemntvty_census_1998
  }

  filter: select_penatvty_census_1998 {
    label: "Native country of sample person"
    view_label: "Group Demographic Variables"
    suggest_dimension: penatvty_census_1998
  }

  filter: select_peio1icd_census_1998 {
    label: "(main job)industry code"
    view_label: "Group Industry"
    suggest_dimension: peio1icd_census_1998
  }

  filter: select_ptio1ocd_census_1998 {
    label: "(main job)occupation code"
    view_label: "Group Industry"
    suggest_dimension: ptio1ocd_census_1998
  }

  filter: select_peio2icd_census_1998 {
    label: "(second job)industry code"
    view_label: "Group Industry"
    suggest_dimension: peio2icd_census_1998
  }

  filter: select_ptio2ocd_census_1998 {
    label: "(second job)occupation code"
    view_label: "Group Industry"
    suggest_dimension: ptio2ocd_census_1998
  }

  filter: select_prdtind1_census_1998 {
    label: "(main job)detailed industry"
    view_label: "Group Industry"
    suggest_dimension: prdtind1_census_1998
  }

  filter: select_prdtind2_census_1998 {
    label: "(second job)detailed industry-recode"
    view_label: "Group Industry"
    suggest_dimension: prdtind2_census_1998
  }

  filter: select_prdtocc1_census_1998 {
    label: "(main job)detailed occupation groups-recode"
    view_label: "Group Industry"
    suggest_dimension: prdtocc1_census_1998
  }

  filter: select_prdtocc2_census_1998 {
    label: "(second job)detailed occupation groups-recode"
    view_label: "Group Industry"
    suggest_dimension: prdtocc2_census_1998
  }

  filter: select_prmjind1_census_1998 {
    label: "(main job)industry,major groups"
    view_label: "Group Industry"
    suggest_dimension: prmjind1_census_1998
  }

  filter: select_prmjind2_census_1998 {
    label: "(second job)industry,major groups-recode"
    view_label: "Group Industry"
    suggest_dimension: prmjind2_census_1998
  }

  filter: select_prmjocc1_census_1998 {
    label: "(main job)occupation,major groups-recode"
    view_label: "Group Industry"
    suggest_dimension: prmjocc1_census_1998
  }

  filter: select_prmjocc2_census_1998 {
    label: "(second job)occupation,major groups-recode"
    view_label: "Group Industry"
    suggest_dimension: prmjocc2_census_1998
  }

  filter: select_prmjocgr_census_1998 {
    label: "(main job)occupation,4 groups"
    view_label: "Group Industry"
    suggest_dimension: prmjocgr_census_1998
  }

  filter: select_pes4_census_1998 {
    label: "Vote in person on election day or before, or by mail"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes4_census_1998
  }

  filter: select_pes5_census_1998 {
    label: "Did you register to vote after january 1, 1995"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes5_census_1998
  }

  filter: select_pes6_census_1998 {
    label: "Register when obtained or renewed license or other way"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes6_census_1998
  }

  filter: select_pes3_census_1998 {
    label: "Main reason did not vote"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes3_census_1998
  }

  filter: select_pes7_census_1998 {
    label: "How did you register to vote"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes7_census_1998
  }

  filter: select_hryear {
    label: "2 digit year of interview"
    view_label: "Group Household Variables"
    suggest_dimension: hryear
  }

  filter: select_hufinal_census_1996 {
    label: "Final code,status of interview"
    view_label: "Group Household Variables"
    suggest_dimension: hufinal_census_1996
  }

  filter: select_huprscnt_census_1996 {
    label: "# of actual & attempted personal contacts"
    view_label: "Group Household Variables"
    suggest_dimension: huprscnt_census_1996
  }

  filter: select_hutypc_census_1996 {
    label: "Type c non-interview categories"
    view_label: "Group Household Variables"
    suggest_dimension: hutypc_census_1996
  }

  filter: select_hutypea_census_1996 {
    label: "Type a non-interview categories"
    view_label: "Group Household Variables"
    suggest_dimension: hutypea_census_1996
  }

  filter: select_pefntvty_census_1996 {
    label: "Native country of father"
    view_label: "Group Demographic Variables"
    suggest_dimension: pefntvty_census_1996
  }

  filter: select_pemntvty_census_1996 {
    label: "Native country of mother"
    view_label: "Group Demographic Variables"
    suggest_dimension: pemntvty_census_1996
  }

  filter: select_penatvty_census_1996 {
    label: "Native country of sample person"
    view_label: "Group Demographic Variables"
    suggest_dimension: penatvty_census_1996
  }

  filter: select_peio1icd_census_1996 {
    label: "(main job)industry code"
    view_label: "Group Industry"
    suggest_dimension: peio1icd_census_1996
  }

  filter: select_ptio1ocd_census_1996 {
    label: "(main job)occupation code"
    view_label: "Group Industry"
    suggest_dimension: ptio1ocd_census_1996
  }

  filter: select_peio2icd_census_1996 {
    label: "(second job)industry code"
    view_label: "Group Industry"
    suggest_dimension: peio2icd_census_1996
  }

  filter: select_ptio2ocd_census_1996 {
    label: "(second job)occupation code"
    view_label: "Group Industry"
    suggest_dimension: ptio2ocd_census_1996
  }

  filter: select_prdtind1_census_1996 {
    label: "(main job)detailed industry"
    view_label: "Group Industry"
    suggest_dimension: prdtind1_census_1996
  }

  filter: select_prdtind2_census_1996 {
    label: "(second job)detailed industry-recode"
    view_label: "Group Industry"
    suggest_dimension: prdtind2_census_1996
  }

  filter: select_prdtocc1_census_1996 {
    label: "(main job)detailed occupation groups-recode"
    view_label: "Group Industry"
    suggest_dimension: prdtocc1_census_1996
  }

  filter: select_prdtocc2_census_1996 {
    label: "(second job)detailed occupation groups-recode"
    view_label: "Group Industry"
    suggest_dimension: prdtocc2_census_1996
  }

  filter: select_prmjind1_census_1996 {
    label: "(main job)industry,major groups"
    view_label: "Group Industry"
    suggest_dimension: prmjind1_census_1996
  }

  filter: select_prmjind2_census_1996 {
    label: "(second job)industry,major groups-recode"
    view_label: "Group Industry"
    suggest_dimension: prmjind2_census_1996
  }

  filter: select_prmjocc1_census_1996 {
    label: "(main job)occupation,major groups-recode"
    view_label: "Group Industry"
    suggest_dimension: prmjocc1_census_1996
  }

  filter: select_prmjocc2_census_1996 {
    label: "(second job)occupation,major groups-recode"
    view_label: "Group Industry"
    suggest_dimension: prmjocc2_census_1996
  }

  filter: select_prmjocgr_census_1996 {
    label: "(main job)occupation,4 groups"
    view_label: "Group Industry"
    suggest_dimension: prmjocgr_census_1996
  }

  filter: select_pes3_census_1996 {
    label: "Main reason did not vote"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes3_census_1996
  }

  filter: select_pes4_census_1996 {
    label: "Vote in person on election day or before, or by mail"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes4_census_1996
  }

  filter: select_pes5_census_1996 {
    label: "Did you register to vote after january 1, 1995"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes5_census_1996
  }

  filter: select_pes6_census_1996 {
    label: "Register when obtained or renewed license or other way"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes6_census_1996
  }

  filter: select_pes7_census_1996 {
    label: "How did you register to vote"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes7_census_1996
  }

  filter: select_hufinal_census_1994 {
    label: "Final code,status of interview"
    view_label: "Group Household Variables"
    suggest_dimension: hufinal_census_1994
  }

  filter: select_huprscnt_census_1994 {
    label: "# of actual & attempted personal contacts"
    view_label: "Group Household Variables"
    suggest_dimension: huprscnt_census_1994
  }

  filter: select_hutypc_census_1994 {
    label: "Type c non-interview categories"
    view_label: "Group Household Variables"
    suggest_dimension: hutypc_census_1994
  }

  filter: select_hutypea_census_1994 {
    label: "Type a non-interview categories"
    view_label: "Group Household Variables"
    suggest_dimension: hutypea_census_1994
  }

  filter: select_pefntvty_census_1994 {
    label: "Native country of father"
    view_label: "Group Demographic Variables"
    suggest_dimension: pefntvty_census_1994
  }

  filter: select_pemntvty_census_1994 {
    label: "Native country of mother"
    view_label: "Group Demographic Variables"
    suggest_dimension: pemntvty_census_1994
  }

  filter: select_penatvty_census_1994 {
    label: "Native country of sample person"
    view_label: "Group Demographic Variables"
    suggest_dimension: penatvty_census_1994
  }

  filter: select_prioelg_census_1994 {
    label: "Industry and occupation edit eligibility flag"
    view_label: "Group Labor Force Variables"
    suggest_dimension: prioelg_census_1994
  }

  filter: select_peio1icd_census_1994 {
    label: "(main job)industry code"
    view_label: "Group Industry"
    suggest_dimension: peio1icd_census_1994
  }

  filter: select_ptio1ocd_census_1994 {
    label: "(main job)occupation code"
    view_label: "Group Industry"
    suggest_dimension: ptio1ocd_census_1994
  }

  filter: select_peio2icd_census_1994 {
    label: "(second job)industry code"
    view_label: "Group Industry"
    suggest_dimension: peio2icd_census_1994
  }

  filter: select_ptio2ocd_census_1994 {
    label: "(second job)occupation code"
    view_label: "Group Industry"
    suggest_dimension: ptio2ocd_census_1994
  }

  filter: select_prdtind1_census_1994 {
    label: "(main job)detailed industry"
    view_label: "Group Industry"
    suggest_dimension: prdtind1_census_1994
  }

  filter: select_prdtind2_census_1994 {
    label: "(second job)detailed industry-recode"
    view_label: "Group Industry"
    suggest_dimension: prdtind2_census_1994
  }

  filter: select_prdtocc1_census_1994 {
    label: "(main job)detailed occupation groups-recode"
    view_label: "Group Industry"
    suggest_dimension: prdtocc1_census_1994
  }

  filter: select_prdtocc2_census_1994 {
    label: "(second job)detailed occupation groups-recode"
    view_label: "Group Industry"
    suggest_dimension: prdtocc2_census_1994
  }

  filter: select_prmjind1_census_1994 {
    label: "(main job)industry,major groups"
    view_label: "Group Industry"
    suggest_dimension: prmjind1_census_1994
  }

  filter: select_prmjind2_census_1994 {
    label: "(second job)industry,major groups-recode"
    view_label: "Group Industry"
    suggest_dimension: prmjind2_census_1994
  }

  filter: select_prmjocc1_census_1994 {
    label: "(main job)occupation,major groups-recode"
    view_label: "Group Industry"
    suggest_dimension: prmjocc1_census_1994
  }

  filter: select_prmjocc2_census_1994 {
    label: "(second job)occupation,major groups-recode"
    view_label: "Group Industry"
    suggest_dimension: prmjocc2_census_1994
  }

  filter: select_prmjocgr_census_1994 {
    label: "(main job)occupation,4 groups"
    view_label: "Group Industry"
    suggest_dimension: prmjocgr_census_1994
  }

  filter: select_perace_census_1994 {
    label: "Race of respondent"
    view_label: "Group Demographic Variables"
    suggest_dimension: perace_census_1994
  }

  filter: select_prvel {
    label: "Voting eligibility recode"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: prvel
  }

  filter: select_pes3_census_1994 {
    label: "Vote in the november _ election?"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes3_census_1994
  }

  filter: select_pes4_census_1994 {
    label: "Registered to vote in the november _ election?"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes4_census_1994
  }

  filter: select_pes5_census_1994 {
    label: "Time of day voted?"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes5_census_1994
  }

  filter: select_pes6_census_1994 {
    label: "Time at current address"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes6_census_1994
  }

  filter: select_pes7_census_1994 {
    label: "Self or other reported for person"
    view_label: "Group Voting and Registration Supplement Variables"
    suggest_dimension: pes7_census_1994
  }
}
