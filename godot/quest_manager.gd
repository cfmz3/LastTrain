extends Node

# Simple QuestManager for LastTrain. Tracks boolean flags used by Yarn dialogs.
# Stores state in memory and provides an API for NPCs and scripts.

var state := {
    "help_erich": false,
    "turn_in_erich": false,
    "killed_erich": false,
    "help_josef": false
}

func set_flag(name: String, value) -> void:
    if state.has(name):
        state[name] = value
    else:
        push_error("Unknown flag: %s" % name)

func get_flag(name: String) -> Variant:
    if state.has(name):
        return state[name]
    push_error("Unknown flag: %s" % name)
    return null

func toggle_flag(name: String) -> void:
    if state.has(name):
        state[name] = not state[name]

func save_state(path: String = "user://game_state.save") -> void:
    var file = FileAccess.open(path, FileAccess.WRITE)
    if file:
        file.store_string(to_json(state))
        file.close()

func load_state(path: String = "user://game_state.save") -> void:
    if not FileAccess.file_exists(path):
        return
    var file = FileAccess.open(path, FileAccess.READ)
    if file:
        var data = parse_json(file.get_as_text())
        if typeof(data) == TYPE_DICTIONARY:
            state = data
        file.close()
