extends Node3D

# Basic NPC script. Attach to NPC root node. Provides interact() and interact_hint().

@export var npc_name: String = "NPC"
@export var talk_node: NodePath

func interact(player):
    # Called when player interacts (RayCast hit and object has interact)
    # Default behavior: print and call quest manager if available
    print("%s interacted by %s" % [npc_name, player.name])
    if talk_node and has_node(talk_node):
        var t = get_node(talk_node)
        if t and t.has_method("start_dialog"):
            t.start_dialog(npc_name)

func interact_hint(show: bool) -> void:
    # Called to show UI hint (e.g., "E - Talk") when player aims at NPC
    if show:
        # In real project, emit signal to UI manager
        print("Hint: press Interact to talk to %s" % npc_name)
