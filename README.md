# LastTrain — Mobile-first game toolkit

This repository contains the initial project layout, asset generation prompts, Godot example scene and scripts, and metadata for the game "Последний рейс" (Last Train).

Goal: mobile-first (Android) development with high‑quality textures and optimized meshes. All assets are prepared with mobile budgets and LODs in mind.

Branches:
- feature/initial-setup — initial content (this branch).

What is in this branch:
- docs/design-doc.md — full design document (game concept, acts, characters, quests, endings)
- prompts/ — prompts for 3D/models/textures/animations/sounds (JSON)
- meta/assets_manifest.json — asset list with budgets and required textures
- meta/conventions.json — naming conventions and tags
- godot/Player.tscn — example Player scene (Godot 4.3 text .tscn)
- godot/player.gd — player controller script (supports keyboard + mobile touch via actions)
- scripts/import_assets.py — helper to validate/import assets manifest
- checklist/import_checklist.md — checklist before importing assets into Godot
- README.md — this file
- LICENSE.md — MIT by default

How to proceed locally (short):
1. Clone and checkout `feature/initial-setup`.
2. Open Godot 4.3, create/import project, add InputMap actions (see godot/README in folder) or load provided project settings.
3. Place generated .glb and textures according to `meta/conventions.json` paths and run the example scene `godot/Player.tscn`.

If you want I can open a Pull Request from feature/initial-setup into the default branch after you review the files.
