library(tidyverse)

df <- read.csv(
  "~/TFM/results/R_analysis/resfinder_gene_presence_matrix.csv",
  check.names = FALSE
)

long_df <- df %>%
  pivot_longer(
    cols = -Sample,
    names_to = "Gene",
    values_to = "Presence"
  )

gene_freq <- long_df %>%
  group_by(Gene) %>%
  summarise(n = sum(Presence), .groups = "drop") %>%
  filter(n >= 4)

library(tidyverse)

# Leer matriz de presencia/ausencia
df <- read.csv(
  "~/TFM/results/R_analysis/resfinder_gene_presence_matrix.csv",
  check.names = FALSE
)

# Convertir a formato largo
long_df <- df %>%
  pivot_longer(
    cols = -Sample,
    names_to = "Gene",
    values_to = "Presence"
  )

# Filtrar genes presentes en al menos 4 muestras
gene_freq <- long_df %>%
  group_by(Gene) %>%
  summarise(n = sum(Presence), .groups = "drop") %>%
  filter(n >= 4)

plot_df <- long_df %>%
  filter(Gene %in% gene_freq$Gene)

# Crear heatmap
p <- ggplot(plot_df, aes(x = Gene, y = Sample, fill = factor(Presence))) +
  geom_tile(color = "grey85") +

  scale_fill_manual(
    values = c("0" = "white", "1" = "black"),
    labels = c("Ausente", "Presente"),
    name = "Gen"
  ) +

  labs(
    title = "Genes de resistencia detectados mediante ResFinder",
    x = "Genes de resistencia",
    y = "Muestras"
  ) +

  theme_minimal(base_size = 16) +

  theme(
    axis.text.x = element_text(
      angle = 45,
      hjust = 1,
      size = 14
    ),

    axis.text.y = element_text(size = 12),

    panel.grid = element_blank(),

    plot.title = element_text(
      face = "bold",
      hjust = 0.5,
      size = 18
    ),

    legend.title = element_text(size = 14),
    legend.text = element_text(size = 12)
  )

# Guardar figura
ggsave(
  "~/TFM/results/R_analysis/resfinder_heatmap_clean.png",
  plot = p,
  width = 16,
  height = 10,
  dpi = 600,
  bg = "white"
)
