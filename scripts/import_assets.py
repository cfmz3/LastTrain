# scripts/import_assets.py

"""
Helper script to validate assets_manifest.json and prepare import descriptors for Godot.
Not required to run inside Godot. Simple sanity checks and prints.
"""
import json
import os

MANIFEST = "meta/assets_manifest.json"

if __name__ == "__main__":
    with open(MANIFEST, "r", encoding="utf-8") as f:
        data = json.load(f)
    assets = data.get("assets", [])
    for a in assets:
        path = a.get("path")
        print(f"Asset: {path}")
        if not os.path.splitext(path)[1] in ['.glb', '.gltf']:
            print("  -> Warning: expected .glb/.gltf file")
        print(f"  Type: {a.get('type')}, budget: {a.get('poly_budget_mobile')}")
