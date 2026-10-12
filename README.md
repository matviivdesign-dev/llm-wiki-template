# LLM Wiki Template

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Template](https://img.shields.io/badge/GitHub-Use%20this%20template-2ea44f)](https://github.com/matviivdesign-dev/llm-wiki-template/generate)
[![Version](https://img.shields.io/badge/version-0.1.0-lightgrey)](CHANGELOG.md)

An empty personal knowledge base that Claude Code maintains for you.

You drop sources into `raw/` (articles, journal entries, notes, transcripts) and ask questions. Claude reads the
sources, writes the pages in `wiki/`, links them together and keeps everything tidy. You never write wiki pages
yourself.

There is no code, database or server. It is a folder of markdown files, git, and two tools: **Claude Code**
(writes) and **qmd** (searches). Read it in Obsidian or any markdown editor.

## Requirements

- [Claude Code](https://claude.com/claude-code) with an active subscription or API key
- Node.js 20 or newer (for qmd)
- git, and the [GitHub CLI](https://cli.github.com/) if you create the repo from the terminal
- macOS or Linux. `init.sh` was tested on macOS 26; it uses only `bash`, `perl`, `npm` and `git`, so Linux
  should work. Windows: use WSL.
- Optional: [Obsidian](https://obsidian.md) to read the wiki

## Setup in 5 minutes

1. **Create your repo from this template.** Click **Use this template** on GitHub, or:

   ```bash
   gh repo create my-wiki --private --template matviivdesign-dev/llm-wiki-template --clone
   cd my-wiki
   ```

   Keep it private. It will hold your health, money and people.

2. **Run the setup script:**

   ```bash
   ./init.sh
   ```

   It stamps today's date into the starter pages, installs qmd and indexes the folder, offers to add the wiki
   to your global Claude Code instructions, then deletes itself and commits.

3. **Open the folder in Obsidian** as a vault. In Settings → Files and links, set the attachment folder to `raw/assets/`.

4. **Add your first source** to `raw/`, named `YYYY-MM-DD-what-it-is.md`. See [raw/README.md](raw/README.md).

5. **Run `claude` in the folder and say "ingest".** Claude will ask permission for the qmd search server; agree.
   It reads the source, discusses the key points with you, writes the pages and removes the `examples/` folder.

## Daily use

| You say | Claude does |
|---|---|
| "ingest raw/articles/….md" | reads it, writes a page, updates related pages, the hub, the index, the log and the search index |
| something worth keeping, in chat | saves your words to `raw/notes/` first, then ingests them |
| any question | searches with qmd, reads the pages, answers with links; saves overviews and comparisons as pages |
| "lint" | finds contradictions, stale claims, pages without links, sources without pages; offered every tenth ingest |

Claude commits to an `ingest/<topic>` branch. Push and pull requests happen only when you ask.

## What a page looks like

Every page starts with a YAML header and one paragraph saying what it is and where it comes from.
From [`examples/decision-garden-app-local-only.md`](examples/decision-garden-app-local-only.md):

```markdown
---
type: decision
title: garden-app без сервера
created: 2026-02-01
status: active
sources:
  - raw/projects/2026-02-01-garden-app-session.md
---

Рішення у [[project-garden-app]] 2026-02-01: дані тільки на телефоні, без акаунтів і бекенду.

## Що вирішено
## Чому
## Що очікується
## Як пішло
```

## Layout

```
raw/        your sources; Claude only reads them         (raw/README.md)
wiki/       pages written by Claude: me.md, waiting.md, questions.md, index.md, log.md,
            areas/ projects/ people/ themes/ decisions/ journal/ answers/
templates/  page skeletons per type
examples/   fictional sample pages, removed after the first ingest
docs/       ARCHITECTURE.md, every part explained in plain words
CLAUDE.md   rules for Claude: structure, page header, operations, git
.mcp.json   connects qmd search to Claude Code
init.sh     one-time setup, deletes itself
```

The long version of what each part does and why: [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md).

## Search

[qmd](https://github.com/tobi/qmd) indexes `wiki/` and `raw/` and runs as an MCP server for Claude Code
(`.mcp.json`). Claude searches with it on every question and refreshes the index after every ingest.
From the terminal:

```bash
qmd query "what did I agree with Olena"
qmd search "garden-app"          # keywords only, no model
```

The index lives in `~/.cache/qmd/`, outside the repo. The first run downloads models for semantic search
(a few minutes, a few hundred MB).

## Troubleshooting

- **`qmd update` stops with "Update command failed"** — another qmd collection on your machine has an
  update command (for example `git pull`) that fails, and `qmd update` aborts before reaching this wiki.
  Fix that collection (`qmd collection update-cmd <name> ''`) or re-index this one:
  `qmd collection remove <name> && qmd collection add . --name <name> --mask "**/*.md" && qmd embed -c <name>`.
- **Claude does not see the search tools** — the MCP server from `.mcp.json` needs your approval on the
  first run in this folder. Run `claude mcp list` to check it is connected.
- **Semantic search is weak in your language** — qmd's default embedding model is English-optimised. Set
  `QMD_EMBED_MODEL=hf:Qwen/Qwen3-Embedding-0.6B-GGUF/Qwen3-Embedding-0.6B-Q8_0.gguf` and run `qmd embed -f`.
- **A page was overwritten** — you edited a wiki page by hand and Claude rewrote it. Only `raw/` is yours;
  ask for changes to `wiki/` in chat.
- **Two Claude sessions edit the wiki at once** — each works in its own `ingest/*` branch; merge them like any
  branches.

## Language

`CLAUDE.md`, the page templates and the examples are written in Ukrainian. Claude follows them regardless of
the language you talk to it in. To switch, ask Claude to translate `CLAUDE.md` and `templates/` in your first
session.

## Adapting it

The template is set up for a personal wiki. For research, a book or a team, open `CLAUDE.md` and change the
`wiki/` sections and the content rules. Everything else works for any topic.

## Contributing

Issues and pull requests are welcome. Keep changes small and explain what problem they solve. Changes to
`CLAUDE.md` should come with a sentence on how they alter Claude's behaviour.

## Credits

- The idea and the text of [`llm-wiki.md`](llm-wiki.md) are Andrej Karpathy's
  [LLM Wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) (2026). This repository is
  one concrete implementation of it.
- Search by [qmd](https://github.com/tobi/qmd), Tobi Lütke, MIT.
- Built and maintained with [Claude Code](https://claude.com/claude-code).

## License

[MIT](LICENSE)
