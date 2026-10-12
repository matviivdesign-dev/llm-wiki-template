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

## How it is built, in plain words

Think of it as a small library with one librarian. You bring books, the librarian reads them and writes the
catalog cards, the summaries and the cross-references. You only read the cards and ask the librarian questions.

**`raw/` is the shelf of originals.** Everything you bring goes here, unchanged: an article you clipped, a journal
entry, a meeting transcript, a session log. Files are never edited or deleted, because the wiki pages point back
to them as evidence. You put files here (or Claude does it for you when you say "save this"). Claude only reads.

**`wiki/` is the catalog the librarian writes.** Every file here is written by Claude from what is in `raw/`.
You never edit these by hand; if you want something changed, say it in chat, otherwise Claude will overwrite it.

- `me.md` is the front desk: who you are right now, what you are busy with, links to everything else. Claude
  rereads it before any work and updates it after every ingest.
- `areas/` are the long-running parts of life that never "finish": health, work, money, relationships. One page each.
- `projects/` are things with an end. Each project page says: goal, where it is now, next step. A big project
  gets its own folder with a log of what happened session by session.
- `people/` are the people in your sources: who they are, how you know them, what you talked about.
- `themes/` are patterns Claude notices across several sources: "this keeps happening to you". This is where
  the wiki becomes more than a summary.
- `decisions/` are decisions you made: what, when, why, and what you expected. Later you can check whether
  it went that way.
- `journal/` is a monthly or quarterly summary written by Claude, not a copy of your daily entries.
- `answers/` keeps the good answers Claude gave you (overviews, comparisons), so the next time you ask the
  same thing it reads one page instead of ten.
- `waiting.md` is the one list of everything that waits for your decision, with the date it came up.
- `questions.md` holds ten questions you actually ask. Claude checks regularly that the wiki can answer
  each of them from one or two pages.
- `index.md` is the table of contents: one line per page. `log.md` is the diary of what Claude did and when.

**`CLAUDE.md` is the librarian's instruction manual.** It says where things go, what a page looks like, what
to do when a new source arrives, what to check during a cleanup, and that nothing is pushed to GitHub without
your word. If you want the wiki to behave differently, you change this file.

**`templates/` are blank forms.** One per page type, with the header fields already in place. Claude starts
every new page from the matching form, so all pages look alike.

**`examples/` are filled-in sample forms.** Fictional pages that show what a good page looks like. They exist
only to teach; Claude deletes the folder after your first real source is in.

**qmd is the search.** It reads every file in `raw/` and `wiki/` and lets Claude find things by meaning, not
just by exact words. `.mcp.json` is the one-line config that plugs it into Claude Code. The index lives in
your home folder, not in the repo.

**git is the memory of changes.** Every change Claude makes is a commit on a side branch. You see what changed,
you can undo it, and nothing goes to GitHub until you say so.

**Obsidian is the reading room.** It shows the pages, the links between them and the graph. It is optional:
the files are plain markdown and open anywhere.

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
