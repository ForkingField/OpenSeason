@echo off

FOR /F "tokens=* USEBACKQ" %%g IN (`git describe --dirty`) do (SET "TAG=%%g")

powershell -Command "(gc ..\openseason-qt\openseason-qt.rc) -replace '1,0,0,1', '"%TAG:~0,1%","%TAG:~2,1%","%TAG:~4,4%",0' | Out-File -encoding ASCII ..\openseason-qt\openseason-qt.rc"
powershell -Command "(gc ..\openseason-qt\openseason-qt.rc) -replace '1.0.0.1', '"%TAG:~0,1%"."%TAG:~2,1%"."%TAG:~4,4%"' | Out-File -encoding ASCII ..\openseason-qt\openseason-qt.rc"
