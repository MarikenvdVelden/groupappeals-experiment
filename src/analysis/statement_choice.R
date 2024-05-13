df <- d |> 
  mutate(has_ingroup = ifelse(Q5>3, 1, 0),
         has_ingroup = ifelse(Q6>3, 1, has_ingroup),
         has_ingroup = ifelse(Q7>3, 1, has_ingroup),
         has_ingroup = replace_na(has_ingroup, 0),
         congruent = ifelse(has_ingroup == 1 & Q14==1, 1, 0),
         congruent = replace_na(congruent, 0))

p4 <- tidy(lm(congruent~Q12a, df)) |> 
  mutate(term = recode(term,
                       `(Intercept)` = "Intercept",
                       `Q12a` = "Feeling Represented"),
         lower = estimate - (1.96 * std.error),
         upper = estimate + (1.96 * std.error))  |> 
  ggplot(aes(y = term, x = estimate,
             xmin = lower, xmax = upper)) +
  geom_point(color = fig_cols[9]) +
  geom_errorbar(width = 0, color = fig_cols[9]) +
  theme_ipsum() +
  labs(x = "Effect of Feeling Represented on Choosing Congruent Statement \n (0 = not congruent, 1 = conguent)",
       y = "") +
  theme(legend.position = "none",
        legend.title = element_blank()) +
  geom_vline(xintercept = 0, linetype = "dashed", linewidth = .7, color = "lightgray")

  
