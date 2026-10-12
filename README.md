# LLM Wiki — шаблон

Порожня персональна wiki за патерном [LLM Wiki](llm-wiki.md): ти приносиш джерела у `raw/` і ставиш питання,
Claude Code пише й підтримує всі сторінки у `wiki/`. Правила роботи — у [CLAUDE.md](CLAUDE.md).

Тут немає коду, бази чи сервера. Це папка markdown-файлів, git і інструкція для Claude Code.

## Що всередині

```
raw/        джерела: journal, articles, books, podcasts, notes, projects, assets — імутабельні
wiki/       сторінки, які пише Claude: me.md (хаб), areas, projects, people, themes, decisions, journal
wiki/index.md   каталог сторінок, по рядку на сторінку
wiki/log.md     append-only журнал ingest / query / lint
CLAUDE.md   схема і правила для Claude Code
llm-wiki.md опис патерну
```

## Розгорнути з нуля

1. Створи репозиторій з цього шаблону (кнопка **Use this template** на GitHub) або:

   ```bash
   gh repo create <org>/<назва>-wiki --private --template matviivdesign-dev/llm-wiki-template --clone
   cd <назва>-wiki
   ```

2. Поправ `CLAUDE.md` під тему, якщо потрібно: розділи `wiki/`, правила змісту, мова.
   Для особистої wiki шаблон підходить без змін.

3. У `wiki/log.md` заміни `YYYY-MM-DD` у першому записі на сьогоднішню дату.

4. Відкрий папку в Obsidian як vault. У Settings → Files and links постав attachment folder `raw/assets/`.
   Файли `.obsidian/workspace*.json` вже у `.gitignore`.

5. Додай у глобальні інструкції Claude Code `~/.claude/CLAUDE.md` блок, щоб із будь-якої папки можна було
   сказати «запиши у wiki»:

   ```markdown
   ## Персональна wiki

   Моя база знань: /шлях/до/<назва>-wiki

   - Правила ведення — у CLAUDE.md тієї папки; прочитай їх перед роботою з wiki.
   - «запиши у wiki», «глянь у wiki» — означає працювати з тими файлами за її правилами.
   ```

6. Запусти `claude` у папці wiki, поклади перший файл у `raw/` і скажи «ingest». Далі все підтримує Claude.

## Щоденна робота

- **Ingest** — «ingest raw/articles/xxx.md»: Claude читає, обговорює тези, пише сторінку, оновлює дотичні, індекс, лог.
- **Query** — будь-яке питання: Claude іде індекс → сторінки → відповідь з лінками; цінні синтези зберігає як сторінки.
- **Lint** — «lint wiki»: протиріччя, застаріле, orphan-сторінки, теми без своєї сторінки.
- Зміни йдуть у гілку `ingest/<контекст>`; push і PR тільки за твоєю командою.

## Опційно

- [qmd](https://github.com/tobi/qmd) — локальний пошук по markdown, коли сторінок стане сотні. До того вистачає `index.md`.
- Obsidian Web Clipper — кліпати статті одразу у `raw/articles/`.
- Dataview, Marp — таблиці й слайди зі сторінок у Obsidian.
