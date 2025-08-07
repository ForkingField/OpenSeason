set LUPDATE=..\..\dep\msvc\qt\6.1.0\msvc2019_64\bin\lupdate.exe ./ ../core/ ../frontend-common/ -tr-function-alias translate+=TranslateString -tr-function-alias translate+=TranslateStdString -tr-function-alias QT_TRANSLATE_NOOP+=TRANSLATABLE

%LUPDATE% -ts translations\openseason-qt_de.ts
%LUPDATE% -ts translations\openseason-qt_es.ts
%LUPDATE% -ts translations\openseason-qt_fr.ts
%LUPDATE% -ts translations\openseason-qt_he.ts
%LUPDATE% -ts translations\openseason-qt_it.ts
%LUPDATE% -ts translations\openseason-qt_ja.ts
%LUPDATE% -ts translations\openseason-qt_nl.ts
%LUPDATE% -ts translations\openseason-qt_pl.ts
%LUPDATE% -ts translations\openseason-qt_pt-br.ts
%LUPDATE% -ts translations\openseason-qt_pt-pt.ts
%LUPDATE% -ts translations\openseason-qt_ru.ts
%LUPDATE% -ts translations\openseason-qt_tr.ts
%LUPDATE% -ts translations\openseason-qt_zh-cn.ts
pause
