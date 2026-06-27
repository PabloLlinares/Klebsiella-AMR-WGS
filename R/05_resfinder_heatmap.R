library(tidyverse)

# Leer matriz
df <- read.csv(
  "~/TFM/results/R_analysis/resfinder_gene_presence_matrix.csv",
  check.names = FALSE
)

# Guardar nombres de muestras
samples <- df$Sample

# Quitar columna Sample
df_matrix <- df %>%
  select(-Sample)

# Filtrar genes frecuentes (>=3 muestras)
gene_freq <- colSums(df_matrix)

df_matrix <- df_matrix[, gene_freq >= 3]

# Convertir a matriz
mat <- as.matrix(df_matrix)

# Asignar nombres de filas
rownames(mat) <- samples

# Generar heatmap
heatmap(
  mat,
  Rowv = NA,
  Colv = NA,
  scale = "none",
  margins = c(10,10),
  xlab = "Genes de resistencia",
  ylab = "Muestras",
  main = "Heatmap de genes AMR detectados mediante ResFinder"
)

# Guardar figura
png(
  "~/TFM/results/R_analysis/resfinder_heatmap.png",
  width = 1400,
  height = 1000
)

heatmap(
  mat,
  Rowv = NA,
  Colv = NA,
  scale = "none",
  margins = c(10,10),
  xlab = "Genes de resistencia",
  ylab = "Muestras",
  main = "Heatmap de genes AMR detectados mediante ResFinder"
)

dev.off()
