Pipeline steps for artists and technical artists (high->game)

1) Sculpt & high detail (ZBrush/Blender) - export highpoly for baking.
2) Retopo to target poly budgets (see meta/assets_manifest.json). Create LODs.
3) UV unwrap: keep texel density consistent. Face maps for characters: 2048, body 1024.
4) Bake: normal, AO, curvature, thickness if needed.
5) Texture: Substance Painter / Quixel for PBR albedo, roughness, metallic, normal. Export PNG originals.
6) Optimization: atlas small props, create GPU compressed textures (ASTC / ETC2) as part of build.
7) Export .glb with embedded materials and optional skin/animations.
8) Import into Godot: use scripts/import_assets.py to validate manifest and place files into res://models/ and res://textures/.
