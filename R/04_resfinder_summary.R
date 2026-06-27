library(tidyverse)

base_dir <- "~/TFM/data/ResFinder_Results"
out_dir <- "~/TFM/results/R_analysis"

dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

files <- list.files(
  path = base_dir,
  pattern = "ResFinder_results_tab.txt",
  recursive = TRUE,
  full.names = TRUE
)

resfinder_data <- map_dfr(files, function(file) {
  sample <- basename(dirname(file))
  
  df <- read.delim(file, sep = "\t", header = TRUE, check.names = FALSE)
  
  names(df)[1] <- "Gene"
  
  df %>%
    mutate(Sample = sample) %>%
    relocate(Sample)
})

write.csv(
  resfinder_data,
  file.path(out_dir, "resfinder_all_results.csv"),
  row.names = FALSE
)

gene_presence <- resfinder_data %>%
  distinct(Sample, Gene) %>%
  mutate(Presence = 1) %>%
  pivot_wider(
    names_from = Gene,
    values_from = Presence,
    values_fill = 0
  )

write.csv(
  gene_presence,
  file.path(out_dir, "resfinder_gene_presence_matrix.csv"),
  row.names = FALSE
)

gene_frequency <- resfinder_data %>%
  count(Gene, sort = TRUE)

write.csv(
  gene_frequency,
  file.path(out_dir, "resfinder_gene_frequency.csv"),
  row.names = FALSE
)
