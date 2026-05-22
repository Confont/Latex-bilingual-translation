---
name: latex-bilingual-translate
description: Generate a Chinese-English bilingual review version from an English LaTeX manuscript. Use when asked to translate an English LaTeX paper, article, manuscript, thesis chapter, or report into Chinese with English/Chinese side-by-side or paragraph-by-paragraph comparison, preserving equations, citations, figures, tables, and bibliography, and outputting only the translated .tex and compiled .pdf files.
---

# LaTeX Bilingual Translate

Create a Chinese-English bilingual review document from an English LaTeX manuscript.

## Output Rule

Only leave these final files in the requested output directory:

- `<chosen-name>.tex`
- `<chosen-name>.pdf`

Do not leave reports, build scripts, README files, auxiliary LaTeX files, logs, `.bbl`, `.aux`, `.out`, `.xdv`, `.fls`, `.fdb_latexmk`, or copied figure/reference folders in the output directory.

## Workflow

1. Read the source `.tex` and identify the main manuscript body, figures, tables, equations, citations, and bibliography.
2. Create a standalone bilingual `.tex` in the user-requested output directory.
3. Use `ctexart` or another XeLaTeX-compatible Chinese document class unless the user explicitly requires the original journal class.
4. Preserve English paragraphs, then add Chinese translations immediately below them.
5. Preserve equations exactly unless the user requests formula translation or notation changes.
6. Preserve citation commands and bibliography linkage.
7. Preserve figures and tables; use relative paths back to the original project instead of copying assets unless copying is explicitly requested.
8. Add bilingual captions when practical.
9. Compile with XeLaTeX plus BibTeX as needed.
10. Clean all generated auxiliary files so the output directory contains only the bilingual `.tex` and `.pdf`.

## Recommended LaTeX Pattern

Use compact macros like:

```latex
\newcommand{\EN}[1]{\noindent\textbf{English}\quad #1\par}
\newcommand{\ZH}[1]{\noindent\textbf{中文}\quad #1\par\vspace{0.45em}}
\newenvironment{bilingual}{\par\smallskip}{\par\medskip}
\newcommand{\bicaption}[2]{\caption{#1\\\smallskip\textnormal{中文：#2}}}
```

For bibliography paths, point to the original `.bib` relative to the output directory:

```latex
\bibliographystyle{elsarticle-num}
\bibliography{../cas-refs}
```

Adjust the relative path if the output directory is not one level below the manuscript root.

## Compilation

Prefer the bundled script:

```powershell
powershell -ExecutionPolicy Bypass -File <skill-dir>\scripts\build_and_clean.ps1 -TexPath <output-dir>\<chosen-name>.tex
```

If compiling manually:

```powershell
latexmk -xelatex -interaction=nonstopmode -halt-on-error <chosen-name>.tex
```

Then delete all auxiliary files with the same basename, leaving only `.tex` and `.pdf`.

## Translation Guidance

- Translate technical terms consistently.
- Keep acronyms such as GNSS, INS, ODO, CPN, THR, SIL, CCF, RAMS, and 2oo2 unless a Chinese explanation is helpful on first use.
- Keep math symbols and labels unchanged.
- Do not translate BibTeX keys, labels, file paths, or LaTeX command names.
- Do not alter the scientific claims unless the user requests revision rather than translation.
