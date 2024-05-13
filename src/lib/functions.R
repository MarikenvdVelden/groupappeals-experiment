library(tidyverse)
library(haven)
library(here)
library(hrbrthemes)
library(patchwork)
library(broom)

fig_cols <- yarrr::piratepal(palette = "basel", 
                             trans = .2)
fig_cols <- as.character(fig_cols)

regression_direct_in <- function(df){
  
  depVarList <- df |> 
    select(matches("Q12c_"))
  indepVarList <- df |> 
    select(Q12a) 
  allModels <- apply(depVarList,2,function(xl)lm(xl ~ Q12a,
                                                 data= indepVarList))
  depVarList <- df |> 
    select(matches("Q12c_"))  |> 
    colnames()
  
  for(i in 1:length(depVarList)){
    if(i==1){
      m <- tidy(allModels[[i]])  |> 
        filter(term == "Q12a") |> 
        mutate(x = term,
               y = depVarList[i],
               lower = estimate - (1.96 * std.error),
               upper = estimate + (1.96 * std.error)) |> 
        select(estimate, upper, lower, y, x, std.error, p.value)
    }
    else{
      tmp <- tidy(allModels[[i]])  |> 
        filter(term == "Q12a") |> 
        mutate(x = term,
               y = depVarList[i],
               lower = estimate - (1.96 * std.error),
               upper = estimate + (1.96 * std.error))  |> 
        select(estimate, upper, lower, y, x, std.error, p.value)
      m <- m  |> 
        add_case(tmp)
    }
  }
  return(m)
}

regression_direct_out <- function(df){
  
  depVarList <- df |> 
    select(matches("Q16c_"))
  indepVarList <- df |> 
    select(Q16a) 
  allModels <- apply(depVarList,2,function(xl)lm(xl ~ Q16a,
                                                 data= indepVarList))
  depVarList <- df |> 
    select(matches("Q16c_"))  |> 
    colnames()
  
  for(i in 1:length(depVarList)){
    if(i==1){
      m <- tidy(allModels[[i]])  |> 
        filter(term == "Q16a") |> 
        mutate(x = term,
               y = depVarList[i],
               lower = estimate - (1.96 * std.error),
               upper = estimate + (1.96 * std.error)) |> 
        select(estimate, upper, lower, y, x, std.error, p.value)
    }
    else{
      tmp <- tidy(allModels[[i]])  |> 
        filter(term == "Q16a") |> 
        mutate(x = term,
               y = depVarList[i],
               lower = estimate - (1.96 * std.error),
               upper = estimate + (1.96 * std.error))  |> 
        select(estimate, upper, lower, y, x, std.error, p.value)
      m <- m  |> 
        add_case(tmp)
    }
  }
  return(m)
}
