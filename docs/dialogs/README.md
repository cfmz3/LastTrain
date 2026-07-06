# Диалоги (русские) — инструкция

Формат: Yarn Spinner (node-based). Файлы в `docs/dialogs/ru/*.yarn`.

Используемые переменные (пример):
- $help_erich (bool)
- $turn_in_erich (bool)
- $killed_erich (bool)
- $help_josef (bool)

В узлах используются команды Yarn: `<<set $var = true>>`, `<<if>> ... <<else>> <<endif>>` для ветвлений.

Каждый узел — отдельная сцена/диалоговая точка. Имена узлов соответствуют логике актов: Cabin, Wagon_Investigate, Erich_Encounter, Act2_Helper_Start, Act2_Informer_Start, Tunnel_Climax, Border_Final.
