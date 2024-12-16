#!/bin/bash

# Строки для добавления в /etc/apt/sources.list
NEW_SOURCES=(
"deb http://dl.astralinux.ru/astra/frozen/1.7_x86-64/1.7.6/uu/2/repository-main/ 1.7_x86-64 main contrib non-free"
"deb http://dl.astralinux.ru/astra/frozen/1.7_x86-64/1.7.6/uu/2/repository-update/ 1.7_x86-64 main contrib non-free"
"deb http://dl.astralinux.ru/astra/frozen/1.7_x86-64/1.7.6/uu/2/repository-base/ 1.7_x86-64 main contrib non-free"
)

# Путь к файлу /etc/apt/sources.list
SOURCE_LIST="/etc/apt/sources.list"

# Проверка наличия root-доступа
if [[ $EUID -ne 0 ]]; then
    echo "Этот скрипт необходимо запускать с правами root."
    exit 1
fi

# Добавление строк в файл, если их там ещё нет
for SOURCE in "${NEW_SOURCES[@]}"; do
    if ! grep -Fxq "$SOURCE" "$SOURCE_LIST"; then
        echo "Добавляю строку: $SOURCE"
        echo "$SOURCE" >> "$SOURCE_LIST"
    else
        echo "Строка уже существует: $SOURCE"
    fi
done

echo "Завершено."
