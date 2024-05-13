df <- d |> 
  select(Q12a, Q12c_0_2:Q12c_10)  |> 
  zap_labels()

m1 <- regression_direct_in(df) |> 
  mutate(y = recode(y,
                    `Q12c_0_2` = "Political Efficacy",
                    `Q12c_3_4` = "Sharing information about party with network",
                    `Q12c_5_6` = "Feeling seen",
                    `Q12c_7_8` = "Feeling Repersented as Group",
                    `Q12c_9` = "Promotes policy views I hold",
                    `Q12c_10` = "Raises issue important to me"),
         id = "X: Feeling Represented \n In-Group")

df <- d |> 
  select(Q16a,matches("Q16c"))  |> 
  zap_labels()

m2 <- regression_direct_out(df) |> 
  mutate(y = recode(y,
                    `Q16c_3_4` = "Sharing information about party with network",
                    `Q16c_9` = "Promotes policy views I hold",
                    `Q16c_10` = "Raises issue important to me",
                    `Q16c_11_16` = "Promotes policies of out-group"),
         id = "X: Agreement with Statement \n Out-Group")
  
p3 <- m1 |> 
  add_case(m2) |> 
  ggplot(aes(y = y, x = estimate,
             xmin = lower, xmax = upper,
             colour = id)) +
  geom_point() +
  geom_errorbar(width = 0) +
  theme_ipsum() +
  facet_grid(.~ id, scales = "free") +
  labs(x = "Effect of X on DVs \n (0 = not at all represented, 10 = very well represented)",
       y = "Dependent Variables \n (DVs)") +
  scale_color_manual(values = c(fig_cols[5:6])) +
  theme(legend.position = "none",
        legend.title = element_blank()) +
  geom_vline(xintercept = 0, linetype = "dashed", linewidth = .7, color = "lightgray")
  
