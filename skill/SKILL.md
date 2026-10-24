---
name: r-figure-to-pptx
description: Creates a figure in R (ggplot2 or base graphics) and exports it to a PowerPoint (.pptx) file with the graph2ppt() function from the R package "export". Use this skill whenever the user wants to make a chart / figure / plot in R and get it into PowerPoint, a slide, or a .pptx, or mentions graph2ppt, the export package, ggplot2 to PowerPoint, or an editable vector figure in PowerPoint, even if they do not name the package explicitly.
---

# R figure → PowerPoint with `export::graph2ppt()`

This skill produces a figure in R and exports it to a `.pptx` where the chart is **vector and editable** in PowerPoint (editable shapes, text and axes), using `graph2ppt()` from the `export` package.

## Workflow

### 1. Understand the request
Gather the following (inferring what is already in the conversation, without needlessly questioning the user):
- the **data** (uploaded CSV/Excel file, pasted data.frame, or a dataset built into R);
- the **type of figure** (scatter plot, bars, boxplot, lines, histogram, etc.);
- the x / y / colour / facet variables, titles and units;
- the desired **size** on the slide (default 7 × 5 inches ≈ 18 × 12.7 cm).

If some information is missing and a reasonable choice exists, make it and say so; ask a question only if the request is truly ambiguous.

### 2. Check the environment
```bash
Rscript --version
```
- **R is available**: run the script yourself (steps 3 to 5).
- **R is not available** (common in a plain chat): still write the complete `.R` script, give it to the user and explain how to run it locally (RStudio → *Source*, or `Rscript figure.R`).

### 3. Install packages if needed
Use the installation block from `assets/template.R`. Key points:
- `export` installs from CRAN, and otherwise from GitHub: `remotes::install_github("tomwenseleers/export")`.
- It depends on `officer`, `rvg` and `flextable` (installed automatically, but allow some time).
- Loading `library(export)` **after** ggplot2 is safe; do not mix it with another package that masks `graph2ppt`.

### 4. Write the script
Start from `assets/template.R` and adapt it. Rules:
- **Prefer ggplot2**: store the plot in an object (`p <- ggplot(...) + ...`) then export with `graph2ppt(x = p, ...)`. This is the most reliable method, including with non-interactive `Rscript`.
- **Base R graphics**: draw the plot, then call `graph2ppt(file = ..., width = ..., height = ...)` *right after* (without `x`) to capture the current graphics device.
- Choose a theme that is readable in a presentation: `theme_minimal(base_size = 16)` or `theme_classic(base_size = 16)`, fonts ≥ 14 pt, distinguishable colours (viridis or ColorBrewer palette), legends and axes with units.
- One figure per slide. For **several figures in the same file**, use `append = TRUE` from the 2nd call onwards (see template).

### 5. Export call
Useful signature:
```r
graph2ppt(x = p, file = "figure.pptx", width = 7, height = 5,
          append = FALSE, vector.graphic = TRUE)
```
| Argument | Role |
|---|---|
| `x` | ggplot object (or `NULL` = current graphic) |
| `file` | output file name (`.pptx` added if missing) |
| `width`, `height` | size in inches |
| `append` | `TRUE` = adds a slide to an existing file |
| `vector.graphic` | `TRUE` (default) = editable vector; `FALSE` = bitmap image (visually more faithful, not editable) |
| `aspectr` | width/height ratio to enforce |

### 6. Check the result
- Check that the `.pptx` exists and its size is not zero.
- If LibreOffice is present (`soffice`), convert to PDF/PNG to check the slide visually.
- Deliver the `.pptx` to the user (through the file-sharing tool if available) together with the `.R` script used, so they can rerun it.

## Common problems

| Symptom | Solution |
|---|---|
| Different fonts in PowerPoint | Use a font installed on the machine (Arial, Calibri): `theme(text = element_text(family = "Arial"))` |
| Odd vector rendering (transparency, `geom_smooth` with ribbon, ggrepel) | Retry with `vector.graphic = FALSE` (bitmap) |
| `export` installation error | Install `officer`, `rvg`, `flextable` first, then `remotes::install_github("tomwenseleers/export")` |
| `graph2ppt` fails with a recent ggplot | Direct alternative with `officer` + `rvg`: see the "Plan B" block of the template |
| Empty base R plot on the slide | Call `graph2ppt()` immediately after the plot, without closing the device; otherwise switch to ggplot2 |
| `.pptx` file open in PowerPoint | Close it before rerunning the script (Windows file lock) |

## Response format for the user
Keep it brief: say which figure was produced, provide the `.pptx` file and the `.R` script, and point out any default choices made (size, theme, palette). Reply in the user's language.
