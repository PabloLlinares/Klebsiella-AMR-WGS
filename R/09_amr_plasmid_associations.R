library(tidyverse)

# Leer matrices
genes <- read.csv(
  "~/TFM/results/R_analysis/resfinder_gene_presence_matrix.csv",
  check.names = FALSE
)

plasmids <- read.csv(
  "~/TFM/results/R_analysis/plasmidfinder_presence_matrix.csv",
  check.names = FALSE
)

# Pasar a formato largo
genes_long <- genes %>%
  pivot_longer(
    cols = -Sample,
    names_to = "Gene",
    values_to = "GenePresence"
  ) %>%
  filter(GenePresence == 1)

plasmids_long <- plasmids %>%
  pivot_longer(
    cols = -Sample,
    names_to = "Plasmid",
    values_to = "PlasmidPresence"
  ) %>%
  filter(PlasmidPresence == 1)

# Unir por muestra
associations <- inner_join(
  genes_long,
  plasmids_long,
  by = "Sample"
)

# Contar coexistencias
association_summary <- associations %>%
  count(Gene, Plasmid, sort = TRUE)

# Filtrar asociaciones frecuentes
association_summary_filtered <- association_summary %>%
  filter(n >= 3)

# Guardar resultados
write.csv(
  association_summary_filtered,
  "~/TFM/results/R_analysis/amr_plasmid_associations.csv",
  row.names = FALSE
)
