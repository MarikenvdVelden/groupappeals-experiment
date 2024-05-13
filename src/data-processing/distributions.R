p1 <- d |>
  zap_labels() |> 
  select(Q12a) |> 
  pivot_longer(cols = everything()) |> 
  drop_na() |>
  group_by(name, value) |> 
  mutate(name = recode(name,
                       `Q12a` = "In-Group Representation \n (0 = not at all represented, 10 = very well represented)",
                       `Q13a` = "Agreement with Out-Group Representation \n (2 = strongly disagree, 10 = strongly agree)")) |> 
  ggplot(aes(y = value, x = name)) +
  see::geom_violinhalf(fill=fig_cols[9], color="#e9ecef", alpha=0.5) +
  theme_ipsum() +
  labs(x = "",
       y = "") 

p2 <- d |>
  zap_labels() |> 
  select(Q13a) |> 
  pivot_longer(cols = everything()) |> 
  drop_na() |>
  group_by(name, value) |> 
  mutate(name = recode(name,
                       `Q12a` = "In-Group Representation \n (0 = not at all represented, 10 = very well represented)",
                       `Q13a` = "Agreement with Out-Group Representation \n (1 = strongly disagree, 5 = strongly agree)")) |> 
  ggplot(aes(y = value, x = name)) +
  see::geom_violinhalf(fill=fig_cols[9], color="#e9ecef", alpha=0.5) +
  theme_ipsum() +
  labs(x = "",
       y = "") 
