# LLM Wiki Template

An empty personal knowledge base that Claude Code maintains for you.

You drop sources into `raw/` (articles, journal entries, notes, meeting transcripts) and ask questions.
Claude reads the sources, writes the pages in `wiki/`, links them together and keeps everything tidy.
You never write wiki pages yourself. The idea is described in [llm-wiki.md](llm-wiki.md).

There is no code, database or server here. It is a folder of markdown files, git, and two tools:
**Claude Code** (writes) and **qmd** (searches). Read it in Obsidian.

## Setup in 5 minutes

You need: [Claude Code](https://claude.com/claude-code), Node.js 20+, git. Obsidian is optional.

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

   It stamps today's date into the starter pages, installs qmd search and indexes the folder, offers to add
   the wiki to your global Claude Code instructions, then deletes itself and commits.

3. **Open the folder in Obsidian** as a vault. In Settings → Files and links, set the attachment folder to `raw/assets/`.

4. **Add your first source** to `raw/`. Name it `YYYY-MM-DD-what-it-is.md`. See [raw/README.md](raw/README.md).

5. **Run `claude` in the folder and say "ingest".** Claude will ask permission for the qmd search server, agree.
   It reads the source, discusses the key points with you, writes the pages and removes the `examples/` folder.

## Daily use

| You say | Claude does |
|---|---|
| "ingest raw/articles/….md" | reads it, writes a page, updates related pages, the hub, the index, the log and the search index |
| something worth keeping, in chat | saves your words to `raw/notes/` first, then ingests them (Capture) |
| any question | searches with qmd, reads the pages, answers with links; saves overviews and comparisons as pages |
| "lint" | finds contradictions, stale claims, pages without links, sources without pages. Offers it every tenth ingest |

Claude commits to an `ingest/<topic>` branch. Push and pull requests happen only when you ask.

## What is in the folder

```
raw/        your sources. Claude only reads them, never changes them
wiki/       pages written by Claude
  me.md       hub: who you are now, links to everything
  waiting.md  everything waiting for your decision, with dates
  questions.md 10 questions used to check that the wiki answers fast
  answers/    saved answers: overviews, comparisons, synthesis
  areas/      areas of life (health, work, money…)
  projects/   projects with an end
  people/     people
  themes/     patterns that repeat across several sources
  decisions/  decisions: what, when, why, what you expect
  journal/    monthly and quarterly synthesis
  index.md    catalog of all pages, one line each
  log.md      what was done and when
templates/  page skeletons per type
examples/   fictional sample pages, removed after the first ingest
CLAUDE.md   rules for Claude: structure, page header, operations, git
.mcp.json   connects qmd search to Claude Code
init.sh     one-time setup
```

## Search

Search is built in: [qmd](https://github.com/tobi/qmd) indexes `wiki/` and `raw/` and runs as an MCP server for
Claude Code (`.mcp.json`). Claude searches with it on every question and refreshes the index after every ingest.
You can search from the terminal too:

```bash
qmd query "what did I agree with Olena"
qmd search "garden-app"          # keywords only, no model
```

The index lives in `~/.cache/qmd/`, outside the repo. The first run downloads models for semantic search
(a few minutes, a few hundred MB).

## Language

The rules in `CLAUDE.md`, the page templates and the examples are written in Ukrainian. Claude follows them
regardless of the language you talk to it in. To switch, ask Claude to translate `CLAUDE.md` and `templates/`
in your first session.

## Adapting it

The template is set up for a personal wiki. For research, a book or a team, open `CLAUDE.md` and change the
`wiki/` sections and the content rules. Everything else, `raw/`, the index, the log, search and the git flow,
works for any topic.
