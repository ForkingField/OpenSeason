#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "missing argument language"
  exit 1
elif [ -f "$1" ]; then
  langfile="$1"
elif [ -f "openseason-qt_${1}.ts" ]; then
  langfile="openseason-qt_${1}.ts"
else
  echo "unexpected argument: $1"
  exit 1
fi

context=(
  ../
  ../../core/
  ../../util/
  -tr-function-alias
  QT_TRANSLATE_NOOP+=TRANSLATE,QT_TRANSLATE_NOOP+=TRANSLATE_SV,QT_TRANSLATE_NOOP+=TRANSLATE_STR,QT_TRANSLATE_NOOP+=TRANSLATE_FS,QT_TRANSLATE_N_NOOP3+=TRANSLATE_FMT,QT_TRANSLATE_NOOP+=TRANSLATE_NOOP,translate+=TRANSLATE_PLURAL_STR,translate+=TRANSLATE_PLURAL_SSTR,translate+=TRANSLATE_PLURAL_FS
  -no-obsolete
)

if [[ "$langfile" == "openseason-qt_en.ts" ]]; then
  echo "English"
  context+=(-pluralonly)
fi

/usr/lib/qt6/bin/lupdate "${context[@]}" -ts "$langfile"

echo linguist6 "$langfile"
