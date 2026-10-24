# r-figure-to-pptx

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![Made with R](https://img.shields.io/badge/Made%20with-R-276DC3?logo=r&logoColor=white)
![ggplot2](https://img.shields.io/badge/ggplot2-compatible-brightgreen)
![PowerPoint](https://img.shields.io/badge/Export-PowerPoint-B7472A?logo=microsoftpowerpoint&logoColor=white)
![Claude Skill](https://img.shields.io/badge/Claude-Skill-D97757)
[![GitHub stars](https://img.shields.io/github/stars/alexbioinf-hash/r-figure-to-pptx?style=social)](https://github.com/alexbioinf-hash/r-figure-to-pptx/stargazers)

Un **skill Claude** qui crée une figure avec **R** (ggplot2 ou graphiques de base) puis l'exporte dans un **PowerPoint** avec `graph2ppt()` du package [`export`](https://github.com/tomwenseleers/export). La figure est **vectorielle et modifiable** directement dans PowerPoint.

> 📸 *Ajoute ici une capture d'écran ou un GIF : demande à Claude → figure → diapo.*

## Installation

1. Télécharge [`r-figure-to-pptx.skill`](./r-figure-to-pptx.skill) (ou la page *Releases*).
2. Dans Claude, ajoute-le à tes skills (bouton **Save skill** sur la carte du fichier).
3. Pour Claude Code : copie le dossier `skill/` dans `~/.claude/skills/r-figure-to-pptx/`.

## Utilisation

Demande simplement à Claude, par exemple :

- « Fais-moi un nuage de points `mpg` vs `wt` avec `mtcars` en R et exporte-le en PowerPoint. »
- « Voici mon CSV : un boxplot de `taille` par `groupe` avec ggplot2, exporté avec `graph2ppt`. »
- « 3 figures dans le même .pptx, une par diapo. »

Si le skill ne se déclenche pas, cite-le : « utilise le skill r-figure-to-pptx ».

## Contenu

| Fichier | Rôle |
|---|---|
| `skill/SKILL.md` | Instructions du skill (workflow, arguments, dépannage) |
| `skill/assets/template.R` | Script R prêt à adapter (installation, figure, export, plan B `officer` + `rvg`) |
| `r-figure-to-pptx.skill` | Skill empaqueté, prêt à installer |

## Prérequis (côté R)

`ggplot2`, `export`, `officer`, `rvg`, `flextable` (installés automatiquement par le template).

## Soutenir le projet

Si ce skill t'est utile, mets une ⭐ sur le dépôt. Les suggestions et pull requests sont bienvenues.

## Licence

[MIT](./LICENSE)
