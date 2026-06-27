library(tidyverse)

# Leer matriz plasmídica
df <- read.csv(
  "~/TFM/results/R_analysis/plasmidfinder_presence_matrix.csv",
  check.names = FALSE
)

# Convertir a formato largo
long_df <- df %>%
  pivot_longer(
    cols = -Sample,
    names_to = "Plasmid",
    values_to = "Presence"
  )

# Filtrar replicones presentes en al menos 3 muestras
plasmid_freq <- long_df %>%
  group_by(Plasmid) %>%
  summarise(n = sum(Presence), .groups = "drop") %>%
  filter(n >= 3)

plot_df <- long_df %>%
  filter(Plasmid %in% plasmid_freq$Plasmid)

# Crear heatmap
p <- ggplot(plot_df, aes(x = Plasmid, y = Sample, fill = factor(Presence))) +

  geom_tile(color = "grey85") +

  scale_fill_manual(
    values = c("0" = "white", "1" = "black"),
    labels = c("Ausente", "Presente"),
    name = "Plásmido"
  ) +

  labs(
    title = "Replicones plasmídicos detectados mediante PlasmidFinder",
    x = "Replicones plasmídicos",
    y = "Muestras"
  ) +

  theme_minimal(base_size = 16) +

  theme(
    axis.text.x = element_text(
      angle = 45,
      hjust = 1,
      size = 13
    ),

    axis.text.y = element_text(size = 11),

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
  "~/TFM/results/R_analysis/plasmidfinder_heatmap.png",
  plot = p,
  width = 14,
  height = 9,
  dpi = 600,
  bg = "white"
)
