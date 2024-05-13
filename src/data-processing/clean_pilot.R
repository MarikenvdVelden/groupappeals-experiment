d <- read_sav(here("data/raw/PilotSurveyResults.sav")) |> 
  select(Q1 = Q1_,
         Q2, Q3,
         Q4 = Q4_, 
         Q5, Q6 = Q6_,
         Q7, Q8_1:Q8_10,
         Q9:outGroup_shown)

#d$Q12a %>% attr(which = "label")
#d %>% surveytoolbox::extract_vallab("Q12a")
#d %>% .[,101:120] %>% surveytoolbox::varl_tb()
