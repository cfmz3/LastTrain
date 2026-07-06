"""
Simple import/validation tool for LastTrain asset manifest.
Usage: python3 scripts/import_assets.py --check

This script validates meta/assets_manifest.json, ensures files exist in the repo layout (useful for CI), and can run placeholder conversion steps (texture compression, LOD generation).

Note: Actual binary conversions (ASTC/ETC2) require external tools (texconv, astcenc, etc.). This script only orchestrates and emits commands to run externally.
"""

import os
import json
import argparse

REPO_ROOT = os.path.dirname(os.path.dirname(__file__))
MANIFEST = os.path.join(REPO_ROOT, 'meta', 'assets_manifest.json')


def load_manifest(path):
    with open(path, 'r', encoding='utf-8') as f:
        return json.load(f)


def check_files(manifest):
    missing = []
    for a in manifest.get('assets', []):
        p = os.path.join(REPO_ROOT, a['path'])
        if not os.path.exists(p):
            missing.append(a['path'])
    return missing


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--check', action='store_true', help='Check manifest files exist')
    parser.add_argument('--plan', action='store_true', help='Print conversion plan (no external tools)')
    args = parser.parse_args()

    manifest = load_manifest(MANIFEST)

    if args.check:
        missing = check_files(manifest)
        if missing:
            print('Missing files (place in repository or update manifest):')
            for m in missing:
                print(' -', m)
            return 1
        else:
            print('All manifest files present.')
            return 0

    if args.plan:
        print('Conversion / import plan:')
        for a in manifest.get('assets', []):
            print('\nAsset:', a['path'])
            print(' - Role:', a.get('role'))
            print(' - Type:', a.get('type'))
            print(' - Suggested LODs:', a.get('lods', []))
            print(' - Texture maps:', a.get('textures', []))
            print('Commands:')
            print('  # Convert PNGs to ASTC (example, requires astcenc)')
            print("  # astcenc -c 4x4 <in.png> <out.astc> -medium_quality")
            print('  # Generate LODs (offline tool, Blender decimate / Simplygon)')
        return 0

    parser.print_help()

if __name__ == '__main__':
    raise SystemExit(main())
