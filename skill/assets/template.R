# =====================================================================
# Figure R -> PowerPoint avec export::graph2ppt()
# =====================================================================

# ---- 1. Packages ----------------------------------------------------
need <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) install.packages(pkg)
}
for (p in c("ggplot2", "officer", "rvg", "flextable", "remotes")) need(p)

if (!requireNamespace("export", quietly = TRUE)) {
  ok <- tryCatch({ install.packages("export"); requireNamespace("export", quietly = TRUE) },
                 error = function(e) FALSE, warning = function(w) FALSE)
  if (!ok) remotes::install_github("tomwenseleers/export")
}

library(ggplot2)
library(export)

# ---- 2. Données -----------------------------------------------------
# Remplacer par les données de l'utilisateur, par ex. :
# df <- read.csv("mes_donnees.csv")
df <- mtcars
df$cyl <- factor(df$cyl)

# ---- 3. Figure ------------------------------------------------------
p <- ggplot(df, aes(x = wt, y = mpg, colour = cyl)) +
  geom_point(size = 3) +
  labs(x = "Poids (1000 lb)", y = "Consommation (miles/gallon)",
       colour = "Cylindres") +
  theme_minimal(base_size = 16)

print(p)  # aperçu (utile en session interactive)

# ---- 4. Export PowerPoint ------------------------------------------
# Taille en pouces ; vector.graphic = TRUE -> figure modifiable dans PowerPoint
graph2ppt(x = p, file = "figure.pptx", width = 7, height = 5,
          append = FALSE, vector.graphic = TRUE)

# Ajouter une 2e figure dans le même fichier (nouvelle diapo) :
# graph2ppt(x = p2, file = "figure.pptx", width = 7, height = 5, append = TRUE)

# Variante graphique de base R (appeler graph2ppt juste après le plot) :
# plot(mtcars$wt, mtcars$mpg, pch = 19, xlab = "Poids", ylab = "mpg")
# graph2ppt(file = "figure_base.pptx", width = 7, height = 5)

# ---- 5. Plan B : officer + rvg (si graph2ppt échoue) -----------------
# library(officer); library(rvg)
# doc <- read_pptx()
# doc <- add_slide(doc, layout = "Title and Content", master = "Office Theme")
# doc <- ph_with(doc, dml(ggobj = p), location = ph_location_fullsize())
# print(doc, target = "figure_officer.pptx")

cat("Fichier créé :", normalizePath("figure.pptx"), "\n")
