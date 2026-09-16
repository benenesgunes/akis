#!/bin/bash

read -p "Post title: " title

echo ""
echo "Select author:"
echo "1) enes"
echo "2) onur"
echo "3) proje ekibi"
echo ""

read -p "Author: " author_choice

case $author_choice in
    1)
        author="enes"
        ;;
    2)
        author="onur"
        ;;
    3)
        author="proje ekibi"
        ;;
    *)
        echo "Invalid author selection."
        exit 1
        ;;
esac

slug=$(echo "$title" | tr '[:upper:]' '[:lower:]' | \
  sed 's/[çÇ]/c/g; s/[ğĞ]/g/g; s/[ıİ]/i/g; s/[öÖ]/o/g; s/[şŞ]/s/g; s/[üÜ]/u/g' | \
  sed 's/[^a-z0-9 ]//g' | \
  tr ' ' '-' | \
  sed 's/-*$//')

file="content/posts/$slug.md"

if [ -f "$file" ]; then
    echo "Error: A post with this title already exists."
    exit 1
fi

cat > "$file" <<EOF
---
title: "$title"
date: $(date '+%Y-%m-%dT%H:%M:%S%z')
author: "$author"
draft: false
---

EOF

echo ""
echo "Created: $file"
echo "Author: $author"