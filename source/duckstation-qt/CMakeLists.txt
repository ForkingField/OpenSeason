find_package(Qt6 6.7.2 COMPONENTS Core Gui Widgets LinguistTools REQUIRED)

include(CopyBaseTranslations)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)

set(SRCS
  aboutdialog.cpp
  aboutdialog.h
  aboutdialog.ui
  achievementlogindialog.cpp
  achievementlogindialog.h
  achievementlogindialog.ui
  achievementsettingswidget.cpp
  achievementsettingswidget.h
  achievementsettingswidget.ui
  advancedsettingswidget.cpp
  advancedsettingswidget.h
  advancedsettingswidget.ui
  audioexpansionsettingsdialog.ui
  audiosettingswidget.cpp
  audiosettingswidget.h
  audiosettingswidget.ui
  audiostretchsettingsdialog.ui
  biossettingswidget.cpp
  biossettingswidget.h
  biossettingswidget.ui
  cheatcodeeditordialog.cpp
  cheatcodeeditordialog.h
  cheatcodeeditordialog.ui
  cheatmanagerwindow.cpp
  cheatmanagerwindow.h
  cheatmanagerwindow.ui
  collapsiblewidget.cpp
  collapsiblewidget.h
  colorpickerbutton.cpp
  colorpickerbutton.h
  consolesettingswidget.cpp
  consolesettingswidget.h
  consolesettingswidget.ui
  controllerbindingwidget_analog_controller.ui
  controllerbindingwidget_analog_joystick.ui
  controllerbindingwidget_digital_controller.ui
  controllerbindingwidget_guncon.ui
  controllerbindingwidget_justifier.ui
  controllerbindingwidget_mouse.ui
  controllerbindingwidget_negcon.ui
  controllerbindingwidget_negconrumble.ui
  controllerbindingwidgets.cpp
  controllerbindingwidgets.h
  controllerbindingwidget.ui
  controllerglobalsettingswidget.cpp
  controllerglobalsettingswidget.h
  controllerglobalsettingswidget.ui
  controllerledsettingsdialog.ui
  controllermacroeditwidget.ui
  controllermacrowidget.ui
  controllersettingswindow.cpp
  controllersettingswindow.h
  controllersettingswindow.ui
  controllersettingwidgetbinder.h
  coverdownloaddialog.cpp
  coverdownloaddialog.h
  coverdownloaddialog.ui
  debuggeraddbreakpointdialog.ui
  debuggermodels.cpp
  debuggermodels.h
  debuggerwindow.cpp
  debuggerwindow.h
  debuggerwindow.ui
  displaywidget.cpp
  displaywidget.h
  emptygamelistwidget.ui
  emulationsettingswidget.cpp
  emulationsettingswidget.h
  emulationsettingswidget.ui
  foldersettingswidget.cpp
  foldersettingswidget.h
  foldersettingswidget.ui
  gamelistmodel.cpp
  gamelistmodel.h
  gamelistrefreshthread.cpp
  gamelistrefreshthread.h
  gamelistsettingswidget.cpp
  gamelistsettingswidget.h
  gamelistsettingswidget.ui
  gamelistwidget.cpp
  gamelistwidget.h
  gamelistwidget.ui
  gamesummarywidget.cpp
  gamesummarywidget.h
  gamesummarywidget.ui
  graphicssettingswidget.cpp
  graphicssettingswidget.h
  graphicssettingswidget.ui
  hotkeysettingswidget.cpp
  hotkeysettingswidget.h
  inputbindingdialog.cpp
  inputbindingdialog.h
  inputbindingdialog.ui
  inputbindingwidgets.cpp
  inputbindingwidgets.h
  interfacesettingswidget.cpp
  interfacesettingswidget.h
  interfacesettingswidget.ui
  logwindow.cpp
  logwindow.h
  mainwindow.cpp
  mainwindow.h
  mainwindow.ui
  memorycardeditorwindow.cpp
  memorycardeditorwindow.h
  memorycardeditorwindow.ui
  memorycardsettingswidget.cpp
  memorycardsettingswidget.h
  memoryscannerwindow.cpp
  memoryscannerwindow.h
  memoryscannerwindow.ui
  memoryviewwidget.cpp
  memoryviewwidget.h
  postprocessingsettingswidget.cpp
  postprocessingsettingswidget.h
  postprocessingchainconfigwidget.ui
  qthost.cpp
  qthost.h
  qtkeycodes.cpp
  qtprogresscallback.cpp
  qtprogresscallback.h
  qtthemes.cpp
  qttranslations.cpp
  qtutils.cpp
  qtutils.h
  resource.h
  selectdiscdialog.cpp
  selectdiscdialog.h
  selectdiscdialog.ui
  settingswindow.cpp
  settingswindow.h
  settingswindow.ui
  settingwidgetbinder.h
  setupwizarddialog.cpp
  setupwizarddialog.h
  setupwizarddialog.ui
)

set(TS_FILES
  translations/duckstation-qt_de.ts
  translations/duckstation-qt_en.ts
  translations/duckstation-qt_es.ts
  translations/duckstation-qt_es-ES.ts
  translations/duckstation-qt_fr.ts
  translations/duckstation-qt_he.ts
  translations/duckstation-qt_id.ts
  translations/duckstation-qt_it.ts
  translations/duckstation-qt_ja.ts
  translations/duckstation-qt_ko.ts
  translations/duckstation-qt_nl.ts
  translations/duckstation-qt_pl.ts
  translations/duckstation-qt_pt-BR.ts
  translations/duckstation-qt_pt-PT.ts
  translations/duckstation-qt_ru.ts
  translations/duckstation-qt_tr.ts
  translations/duckstation-qt_zh-CN.ts
)

add_executable(duckstation-qt ${SRCS} ${QM_FILES})
target_precompile_headers(duckstation-qt PRIVATE "pch.h")
target_include_directories(duckstation-qt PRIVATE "${Qt6Gui_PRIVATE_INCLUDE_DIRS}" "${CMAKE_CURRENT_SOURCE_DIR}"  "${CMAKE_SOURCE_DIR}/third_party/include")
target_link_libraries(duckstation-qt PRIVATE core common imgui minizip scmversion Qt6::Core Qt6::Gui Qt6::Widgets)

install(TARGETS duckstation-qt RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}")

set(RCC_FILE "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/resources/duckstation-qt.rcc")
qt_add_binary_resources(duckstation-qt-rcc resources/duckstation-qt.qrc
  DESTINATION ${RCC_FILE}
  OPTIONS -no-compress
)
add_dependencies(duckstation-qt duckstation-qt-rcc)
install(FILES ${RCC_FILE} DESTINATION "${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}")

qt_add_lrelease(duckstation-qt TS_FILES ${TS_FILES} QM_FILES_OUTPUT_VARIABLE QM_FILES)
install(FILES ${QM_FILES} DESTINATION ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}/translations)
