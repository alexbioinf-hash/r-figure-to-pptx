# r-figure-to-pptx

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![Made with R](https://img.shields.io/badge/Made%20with-R-276DC3?logo=r&logoColor=white)
![ggplot2](https://img.shields.io/badge/ggplot2-compatible-brightgreen)
![PowerPoint](https://img.shields.io/badge/Export-PowerPoint-B7472A?logo=microsoftpowerpoint&logoColor=white)
![Claude Skill](https://img.shields.io/badge/Claude-Skill-D97757)
![Views](https://visitor-badge.laobi.icu/badge?page_id=alexbioinf-hash.r-figure-to-pptx&left_text=views)
[![Downloads](https://img.shields.io/github/downloads/alexbioinf-hash/r-figure-to-pptx/total?label=downloads&color=blue)](https://github.com/alexbioinf-hash/r-figure-to-pptx/releases)
[![GitHub stars](https://img.shields.io/github/stars/alexbioinf-hash/r-figure-to-pptx?style=social)](https://github.com/alexbioinf-hash/r-figure-to-pptx/stargazers)

A **Claude skill** that creates a figure with **R** (ggplot2 or base graphics) and exports it to a **PowerPoint** file with `graph2ppt()` from the [`export`](https://github.com/tomwenseleers/export) package. The figure is **vector and editable** directly in PowerPoint.

## Installation

1. Download [`r-figure-to-pptx.skill`](./r-figure-to-pptx.skill) (or get it from the *Releases* page).
2. In Claude, add it to your skills (**Save skill** button on the file card).
3. For Claude Code: copy the `skill/` folder to `~/.claude/skills/r-figure-to-pptx/`.

## Usage

Just ask Claude, for example:

- "Make me a scatter plot of `mpg` vs `wt` from `mtcars` in R and export it to PowerPoint."
- "Here is my CSV: a boxplot of `height` by `group` with ggplot2, exported with `graph2ppt`."
- "3 figures in the same .pptx, one per slide."

If the skill does not trigger, name it: "use the r-figure-to-pptx skill".

## Contents

| File | Role |
|---|---|
| `skill/SKILL.md` | Skill instructions (workflow, arguments, troubleshooting) |
| `skill/assets/template.R` | Ready-to-adapt R script (installation, figure, export, `officer` + `rvg` plan B) |
| `r-figure-to-pptx.skill` | Packaged skill, ready to install |

## Requirements (R side)

`ggplot2`, `export`, `officer`, `rvg`, `flextable` (installed automatically by the template).

## Credits

This skill uses the [`export`](https://github.com/tomwenseleers/export) R package (GPL-2) by Tom Wenseleers. This project is independent and not affiliated with its author.

## Support the project

If this skill is useful to you, give the repository a ⭐. Suggestions and pull requests are welcome.

## License

[MIT](./LICENSE)
