# LLM Wiki — шаблон

Порожня персональна wiki за патерном [LLM Wiki](llm-wiki.md): ти приносиш джерела у `raw/` і ставиш питання,
Claude Code пише й підтримує всі сторінки у `wiki/`. Правила роботи — у [CLAUDE.md](CLAUDE.md).

Тут немає коду, бази чи сервера. Це папка markdown-файлів, git і інструкція для Claude Code.
Репозиторій тримай **приватним**: особиста wiki містить здоров'я, фінанси, людей.

## Що всередині

```
raw/          джерела: journal, articles, books, podcasts, notes, projects, assets — імутабельні (raw/README.md)
wiki/         сторінки, які пише Claude: me.md (хаб), areas, projects, people, themes, decisions, journal
wiki/index.md каталог сторінок, по рядку на сторінку
wiki/log.md   append-only журнал ingest / capture / query / lint
templates/    скелети сторінок за типами, з frontmatter
examples/     вигадані зразки сторінок; видаляються після першого ingest
CLAUDE.md     схема і правила для Claude Code
llm-wiki.md   опис патерну
init.sh       разове налаштування: дата, блок у ~/.claude/CLAUDE.md, самовидалення
```

## Розгорнути з нуля

1. Створи репозиторій з цього шаблону (кнопка **Use this template** на GitHub) або:

   ```bash
   gh repo create <org>/<назва>-wiki --private --template matviivdesign-dev/llm-wiki-template --clone
   cd <назва>-wiki
   ```

2. Запусти `./init.sh`. Він проставить дату у стартових файлах, за бажанням додасть блок у `~/.claude/CLAUDE.md`
   (щоб «запиши у wiki» працювало з будь-якої папки), видалить себе й закомітить.

3. Поправ `CLAUDE.md` під тему, якщо потрібно: розділи `wiki/`, правила змісту, мова. Для особистої wiki
   шаблон підходить без змін.

4. Відкрий папку в Obsidian як vault. У Settings → Files and links постав attachment folder `raw/assets/`.
   Файли `.obsidian/workspace*.json` вже у `.gitignore`.

5. Запусти `claude` у папці wiki, поклади перший файл у `raw/` (правила назв — `raw/README.md`) і скажи «ingest».
   Після першого ingest Claude видалить `examples/`.

## Щоденна робота

- **Ingest** — «ingest raw/articles/xxx.md»: Claude читає, обговорює тези, пише сторінку за скелетом,
  оновлює дотичні сторінки, `decisions/`, `themes/`, `me.md`, індекс, лог.
- **Capture** — сказав щось цінне у чаті: Claude спершу записує це у `raw/notes/`, потім робить ingest.
- **Query** — будь-яке питання: індекс → сторінки → відповідь з лінками; цінні синтези зберігаються як сторінки.
- **Lint** — «lint wiki», і Claude сам пропонує його кожен десятий ingest: orphan-сторінки, TBD старші за 30 днів,
  незаінжестовані raw-файли, теми без сторінки, протиріччя.
- Зміни йдуть у гілку `ingest/<контекст>`; push і PR тільки за твоєю командою.

## Коли сторінок стане багато

`index.md` працює приблизно до сотні сторінок. Далі підключи [qmd](https://github.com/tobi/qmd), локальний пошук
по markdown:

```bash
npm i -g @tobilu/qmd        # або за інструкцією в репозиторії qmd
qmd collection add wiki ./wiki --description "моя wiki"
qmd embed
qmd search "запит"
```

Правило для індексу лишається: один рядок не довше 160 символів, деталі на сторінці.

## Опційно

- Obsidian Web Clipper — кліпати статті одразу у `raw/articles/`.
- Dataview у Obsidian — таблиці по frontmatter: «усі проекти зі `status: active`», «сторінки з `updated` старшим
  за місяць».
- Marp — слайди зі сторінок wiki.
