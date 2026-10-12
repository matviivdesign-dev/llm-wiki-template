#!/usr/bin/env bash
# Разове налаштування нової wiki з шаблону. Запускати з кореня репозиторію: ./init.sh
# Ставить сьогоднішню дату у стартові файли, за бажанням додає блок у ~/.claude/CLAUDE.md,
# прибирає себе й комітить.
set -euo pipefail

cd "$(dirname "$0")"
TODAY=$(date +%F)
WIKI_PATH=$(pwd)

for f in wiki/me.md wiki/index.md wiki/log.md; do
  sed -i '' "s/YYYY-MM-DD/$TODAY/g" "$f"
done
echo "Дата $TODAY проставлена у wiki/me.md, wiki/index.md, wiki/log.md."

GLOBAL="$HOME/.claude/CLAUDE.md"
read -r -p "Назва wiki для глобальних інструкцій Claude Code (порожньо — не додавати): " NAME
if [ -n "$NAME" ]; then
  mkdir -p "$(dirname "$GLOBAL")"
  if grep -q "$WIKI_PATH" "$GLOBAL" 2>/dev/null; then
    echo "У $GLOBAL уже є запис із цим шляхом, пропускаю."
  else
    cat >> "$GLOBAL" <<BLOCK

## Wiki: $NAME

База знань: $WIKI_PATH

- Правила ведення — у CLAUDE.md тієї папки; прочитай їх перед роботою з wiki.
- «запиши у $NAME», «глянь у $NAME» — означає працювати з тими файлами за її правилами.
BLOCK
    echo "Блок додано у $GLOBAL."
  fi
fi

git rm -q init.sh
git add -A
git commit -q -m "init: wiki set up on $TODAY"
echo "Готово. Відкрий папку в Obsidian (attachment folder: raw/assets/), поклади перше джерело у raw/ і скажи Claude «ingest»."
