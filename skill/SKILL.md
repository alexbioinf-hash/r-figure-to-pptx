---
name: r-figure-to-pptx
description: Crée une figure avec R (ggplot2 ou graphiques de base) puis l'exporte dans un fichier PowerPoint (.pptx) avec la fonction graph2ppt() du package R "export". Utilise ce skill dès que l'utilisateur veut faire un graphique / une figure / un plot en R et l'obtenir dans PowerPoint, une diapo, un .pptx, ou mentionne graph2ppt, le package export, ggplot2 vers PowerPoint, ou une figure vectorielle modifiable dans PowerPoint, même s'il ne cite pas explicitement le package.
---

# Figure R → PowerPoint avec `export::graph2ppt()`

Ce skill produit une figure en R puis l'exporte dans un `.pptx` où le graphique est **vectoriel et modifiable** dans PowerPoint (formes, textes et axes éditables), via `graph2ppt()` du package `export`.

## Workflow

### 1. Comprendre la demande
Récupère (en déduisant ce qui est déjà dans la conversation, sans interroger l'utilisateur inutilement) :
- les **données** (fichier CSV/Excel uploadé, data.frame collé, ou jeu de données intégré à R) ;
- le **type de figure** (nuage de points, barres, boxplot, courbes, histogramme, etc.) ;
- les variables en x / y / couleur / facette, les titres, les unités ;
- la **taille** voulue sur la diapo (par défaut 7 × 5 pouces ≈ 18 × 12,7 cm).

Si une information manque et qu'un choix raisonnable existe, fais-le et dis-le ; ne pose qu'une question si la demande est vraiment ambiguë.

### 2. Vérifier l'environnement
```bash
Rscript --version
```
- **R est disponible** : exécute le script toi-même (étapes 3 à 5).
- **R n'est pas disponible** (cas fréquent dans un simple chat) : écris quand même le script `.R` complet, donne-le à l'utilisateur et explique comment le lancer chez lui (RStudio → *Source*, ou `Rscript figure.R`).

### 3. Installer les packages si besoin
Utilise le bloc d'installation de `assets/template.R`. Points importants :
- `export` s'installe depuis CRAN, et à défaut depuis GitHub : `remotes::install_github("tomwenseleers/export")`.
- Il dépend de `officer`, `rvg` et `flextable` (installés automatiquement, mais prévoir du temps).
- Charger `library(export)` **après** ggplot2 est sans risque ; ne pas mélanger avec un autre package qui masque `graph2ppt`.

### 4. Écrire le script
Pars de `assets/template.R` et adapte-le. Règles :
- **ggplot2 de préférence** : stocke le graphique dans un objet (`p <- ggplot(...) + ...`) puis exporte avec `graph2ppt(x = p, ...)`. C'est la méthode la plus fiable, y compris en `Rscript` non interactif.
- **Graphique de base R** : trace le plot, puis appelle `graph2ppt(file = ..., width = ..., height = ...)` *juste après* (sans `x`) pour capturer le périphérique graphique courant.
- Choisis un thème lisible en présentation : `theme_minimal(base_size = 16)` ou `theme_classic(base_size = 16)`, polices ≥ 14 pt, couleurs distinguables (palette viridis ou ColorBrewer), légendes et axes avec unités.
- Une figure par diapo. Pour **plusieurs figures dans le même fichier**, utilise `append = TRUE` à partir du 2ᵉ appel (voir template).

### 5. Appel d'export
Signature utile :
```r
graph2ppt(x = p, file = "figure.pptx", width = 7, height = 5,
          append = FALSE, vector.graphic = TRUE)
```
| Argument | Rôle |
|---|---|
| `x` | objet ggplot (ou `NULL` = graphique courant) |
| `file` | nom du fichier de sortie (`.pptx` ajouté si absent) |
| `width`, `height` | taille en pouces |
| `append` | `TRUE` = ajoute une diapo à un fichier existant |
| `vector.graphic` | `TRUE` (défaut) = vectoriel modifiable ; `FALSE` = image bitmap (plus fidèle visuellement, non modifiable) |
| `aspectr` | ratio largeur/hauteur à imposer |

### 6. Vérifier le résultat
- Contrôle que le `.pptx` existe et que sa taille n'est pas nulle.
- Si LibreOffice est présent (`soffice`), convertis en PDF/PNG pour vérifier visuellement la diapo.
- Livre le `.pptx` à l'utilisateur (via l'outil de partage de fichiers si disponible) avec le script `.R` utilisé, pour qu'il puisse le relancer.

## Problèmes fréquents

| Symptôme | Solution |
|---|---|
| Polices différentes dans PowerPoint | Utiliser une police présente sur la machine (Arial, Calibri) : `theme(text = element_text(family = "Arial"))` |
| Rendu vectoriel étrange (transparences, `geom_smooth` avec bande, ggrepel) | Réessayer avec `vector.graphic = FALSE` (bitmap) |
| Erreur d'installation de `export` | Installer d'abord `officer`, `rvg`, `flextable`, puis `remotes::install_github("tomwenseleers/export")` |
| `graph2ppt` échoue avec un ggplot récent | Alternative directe avec `officer` + `rvg` : voir bloc « Plan B » du template |
| Graphique de base R vide dans la diapo | Appeler `graph2ppt()` immédiatement après le plot, sans fermer le périphérique ; sinon passer à ggplot2 |
| Fichier `.pptx` ouvert dans PowerPoint | Le fermer avant de relancer le script (verrouillage Windows) |

## Format de réponse à l'utilisateur
Reste bref : dis quelle figure a été produite, donne le fichier `.pptx` et le script `.R`, et signale tout choix fait par défaut (taille, thème, palette). Réponds dans la langue de l'utilisateur.
