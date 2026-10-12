#!/usr/bin/env bash
# Разове налаштування нової wiki з шаблону. Запускати з кореня репозиторію: ./init.sh
# Що робить: ставить сьогоднішню дату у стартові файли, ставить і налаштовує пошук qmd,
# за бажанням додає блок у ~/.claude/CLAUDE.md, прибирає себе й комітить.
set -euo pipefail

cd "$(dirname "$0")"
TODAY=$(date +%F)
WIKI_PATH=$(pwd)
DEFAULT_NAME=$(basename "$WIKI_PATH")

read -r -p "Коротка назва wiki [$DEFAULT_NAME]: " NAME
NAME=${NAME:-$DEFAULT_NAME}

# 1. Дата у стартових файлах
for f in wiki/me.md wiki/index.md wiki/log.md wiki/waiting.md wiki/questions.md; do
  perl -pi -e "s/YYYY-MM-DD/${TODAY}/g" "$f"
done
echo "✓ Дата $TODAY у стартових сторінках wiki/"

# 2. Пошук qmd: встановити, якщо нема; додати колекцію; описати; побудувати індекс
if ! command -v qmd >/dev/null 2>&1; then
  echo "Ставлю qmd (npm install -g @tobilu/qmd)…"
  npm install -g @tobilu/qmd
fi
if qmd collection list 2>/dev/null | grep -qE "^\s*${NAME} \("; then
  echo "✓ Колекція qmd ${NAME} уже є"
else
  qmd collection add "$WIKI_PATH" --name "$NAME" --mask "**/*.md"
  echo "✓ Колекція qmd ${NAME} → ${WIKI_PATH}"
fi
qmd context add "qmd://${NAME}" "Персональна wiki ${NAME}: wiki/ — сторінки, які пише Claude; raw/ — джерела" >/dev/null 2>&1 || true
qmd context add "qmd://${NAME}/wiki" "Сторінки wiki: хаб me.md, areas, projects, people, themes, decisions, journal" >/dev/null 2>&1 || true
qmd context add "qmd://${NAME}/raw" "Сирі джерела: щоденник, статті, книжки, подкасти, нотатки, проекти" >/dev/null 2>&1 || true
# collection add уже проіндексував файли; лишилось порахувати вектори саме для цієї колекції
qmd embed -c "${NAME}" >/dev/null
echo "✓ Індекс qmd побудовано (перший раз qmd качає моделі, це може зайняти кілька хвилин)"

# 3. Блок у глобальних інструкціях Claude Code
GLOBAL="$HOME/.claude/CLAUDE.md"
read -r -p "Додати блок про цю wiki у $GLOBAL? [y/N]: " ANSWER
if [[ "$ANSWER" =~ ^[Yy]$ ]]; then
  mkdir -p "$(dirname "$GLOBAL")"
  if grep -qF "$WIKI_PATH" "$GLOBAL" 2>/dev/null; then
    echo "✓ У $GLOBAL уже є запис із цим шляхом"
  else
    cat >> "$GLOBAL" <<BLOCK

## Wiki: ${NAME}

База знань: $WIKI_PATH

- Правила ведення — у CLAUDE.md тієї папки; прочитай їх перед роботою з wiki.
- «запиши у ${NAME}», «глянь у ${NAME}» — означає працювати з тими файлами за її правилами.
- Пошук по wiki — через qmd (колекція ${NAME}): MCP-інструменти qmd або \`qmd query\`.
BLOCK
    echo "✓ Блок додано у $GLOBAL"
  fi
fi

# 4. Прибрати себе й закомітити
git rm -q init.sh
git add -A
git commit -q -m "init: wiki ${NAME} set up on ${TODAY}"
echo
echo "Готово."
echo "Далі: відкрий папку в Obsidian (attachment folder: raw/assets/),"
echo "запусти claude тут, поклади перше джерело у raw/ і скажи «ingest»."
echo "Claude Code при першому запуску спитає дозвіл на MCP-сервер qmd з .mcp.json — погодься."
