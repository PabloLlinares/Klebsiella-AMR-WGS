library(tidyverse)
library(jsonlite)

base_dir <- "~/TFM/data/PlasmidFinder_Results"
out_dir <- "~/TFM/results/R_analysis"

dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

json_files <- list.files(
  path = base_dir,
  pattern = "results.json",
  recursive = TRUE,
  full.names = TRUE
)

plasmid_data <- map_dfr(json_files, function(file) {

  sample <- basename(dirname(file))

  json <- fromJSON(file)

  if(length(json$seq_regions) == 0) {
    return(NULL)
  }

  plasmids <- map_chr(json$seq_regions, "name")

  tibble(
    Sample = sample,
    Plasmid = plasmids
  )
})

write.csv(
  plasmid_data,
  file.path(out_dir, "plasmidfinder_all_results.csv"),
  row.names = FALSE
)

plasmid_presence <- plasmid_data %>%
  distinct(Sample, Plasmid) %>%
  mutate(Presence = 1) %>%
  pivot_wider(
    names_from = Plasmid,
    values_from = Presence,
    values_fill = 0
  )

write.csv(
  plasmid_presence,
  file.path(out_dir, "plasmidfinder_presence_matrix.csv"),
  row.names = FALSE
)

plasmid_frequency <- plasmid_data %>%
  count(Plasmid, sort = TRUE)

write.csv(
  plasmid_frequency,
  file.path(out_dir, "plasmidfinder_frequency.csv"),
  row.names = FALSE
)
