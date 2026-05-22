# Latex中英对照翻译

这是一个 Codex skill，用于把英文 LaTeX 论文、手稿、章节或报告生成中英对照审阅版。

## 功能

- 读取英文 `.tex` 主文件
- 保留公式、引用、标签、图、表和参考文献结构
- 在英文段落下方加入中文翻译
- 生成可编译的中英对照 `.tex`
- 使用 XeLaTeX 编译输出 PDF
- 清理编译中间文件，最终只保留 `.tex` 和 `.pdf`

## 输出规则

目标输出目录最终只应包含：

- `<chosen-name>.tex`
- `<chosen-name>.pdf`

不应保留 `.aux`、`.log`、`.bbl`、`.blg`、`.out`、`.xdv`、`.fls`、`.fdb_latexmk`、报告文件或临时脚本。

## 安装

把整个 `latex-bilingual-translate` 文件夹复制到 Codex skills 目录：

```text
C:\Users\<你的用户名>\.codex\skills\latex-bilingual-translate
```

目录结构应类似：

```text
latex-bilingual-translate
├── SKILL.md
├── README.md
└── scripts
    └── build_and_clean.ps1
```

## 调用方式

在 Codex 新对话中可以这样说：

```text
使用 latex-bilingual-translate skill，把 E:\path\paper.tex 翻译成中英对照版本，输出到 E:\path\translate，只保留 tex 和 pdf。
```

也可以直接描述任务，例如：

```text
请把这篇英文 LaTeX 论文生成中英对照 PDF，保留公式、引用、图表和参考文献。
```

只要任务符合 skill 描述，Codex 会自动使用该 skill。

## 编译脚本

skill 内置脚本：

```powershell
powershell -ExecutionPolicy Bypass -File <skill-dir>\scripts\build_and_clean.ps1 -TexPath <output-dir>\<chosen-name>.tex
```

脚本会运行 `latexmk -xelatex`，必要时处理 BibTeX，并清理同名辅助文件。

## 注意事项

- 推荐本机安装 TeX Live 或 MiKTeX，并确保 `latexmk`、`xelatex`、`bibtex` 在命令行可用。
- 图片和 `.bib` 文件通常通过相对路径引用原工程文件，不会被复制到输出目录，除非你明确要求复制。
- 该 skill 只负责翻译与生成中英对照审阅版，不会主动润色或改写论文的科学表述。
