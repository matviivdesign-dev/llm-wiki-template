# How it is built, in plain words

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
