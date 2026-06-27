library(tidyverse)

df <- read.csv(
  "~/TFM/results/R_analysis/amr_plasmid_associations.csv"
)

top_assoc <- df %>%
  arrange(desc(n)) %>%
  slice(1:10)

write.csv(
  top_assoc,
  "~/TFM/results/R_analysis/top_amr_plasmid_associations.csv",
  row.names = FALSE
)

print(top_assoc)
