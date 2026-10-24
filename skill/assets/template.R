# =====================================================================
# R figure -> PowerPoint with export::graph2ppt()
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

# ---- 2. Data --------------------------------------------------------
# Replace with the user's data, e.g.:
# df <- read.csv("my_data.csv")
df <- mtcars
df$cyl <- factor(df$cyl)

# ---- 3. Figure ------------------------------------------------------
p <- ggplot(df, aes(x = wt, y = mpg, colour = cyl)) +
  geom_point(size = 3) +
  labs(x = "Weight (1000 lb)", y = "Fuel economy (miles/gallon)",
       colour = "Cylinders") +
  theme_minimal(base_size = 16)

print(p)  # preview (useful in an interactive session)

# ---- 4. PowerPoint export -------------------------------------------
# Size in inches; vector.graphic = TRUE -> figure is editable in PowerPoint
graph2ppt(x = p, file = "figure.pptx", width = 7, height = 5,
          append = FALSE, vector.graphic = TRUE)

# Add a 2nd figure to the same file (new slide):
# graph2ppt(x = p2, file = "figure.pptx", width = 7, height = 5, append = TRUE)

# Base R graphics variant (call graph2ppt right after the plot):
# plot(mtcars$wt, mtcars$mpg, pch = 19, xlab = "Weight", ylab = "mpg")
# graph2ppt(file = "figure_base.pptx", width = 7, height = 5)

# ---- 5. Plan B: officer + rvg (if graph2ppt fails) ------------------
# library(officer); library(rvg)
# doc <- read_pptx()
# doc <- add_slide(doc, layout = "Title and Content", master = "Office Theme")
# doc <- ph_with(doc, dml(ggobj = p), location = ph_location_fullsize())
# print(doc, target = "figure_officer.pptx")

cat("File created:", normalizePath("figure.pptx"), "\n")
