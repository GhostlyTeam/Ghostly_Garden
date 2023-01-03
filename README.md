# Ghostly_Garden
Visual Computing - UA - 2022/2023

Ghostly Team:
Tiago Rebelo nº 111896
Nuno Neto nº 114957
Pedro Costa nº 111708


## Synopsis:
You are trapped inside a garden at night. You must find the 3 pieces in order to escape with the teleporter, before getting caught by the ghostly forms of your ancestors.

## Gameplay loop:
You have a health bar that quickly goes down when a ghost is near you. You must quickly find where the ghost is and point a flashlight in order to save yourself. You win the game if you find all the 3 pieces of the teleporter without dying.

## Start the game

Open Project in Godot and Press `Play`

## Controls

`W A S D` - Move Forward, Backward, Left and Right

`Mouse` - Control Camera

`Space` - Jump 

`F` - Toogle Flashlight 

`Esc` - Trap/Untrap Mouse Cursor

## Synopsis
You are trapped inside a garden at night. You must find the 3 pieces in order to escape with the teleporter, before getting caught by the ghostly forms of your ancestors.

## Gameplay loop:
You have a health bar that quickly goes down when a ghost is near you. You must quickly find where the ghost is and point a flashlight in order to save yourself. You win the game if you find all the 3 pieces of the teleporter without dying.

## World pipeline conversion

The `blender` directory contains the original blend file with all textures under `textures`sub-folder. `Garden.blend` is configured to load textures from `textures`.  

The directory `world`contains the `.glb`file that contains the converted world and all the materials with textures

To export the world in Blender:

1. Export `File -> Export -> glTF 2.0 (.glb/.gltf)`

1. Make sure Format is `glTF Binary (.glb)`

1. Chose the `world` folder in this git repository

1. Click in `Export glTF 2.0`

## Add collisions to godot through blender pipeline

To add collisions to blender simply add the suffix `-col` to the selected meshes in blender. Godot automatically adds an appropriate collision shape to the mesh: https://docs.godotengine.org/en/latest/tutorials/assets_pipeline/importing_scenes.html#create-collisions-col-convcol-colonly-convcolonly

To batch rename in blender: https://docs.blender.org/manual/en/latest/files/blend/rename.html#batch-rename

## Checklist - Visual Computing Components
- [x] Basic GamePlay Loop
- [x] Ghost Shader - Vertex Shader
- [x] Ghost Shader - Fragment Shader
- [] World Assets (outsourced)
- [x] Different textures and materials
- [x] Camera Movement with Rotation
- [] Camera Shaking (near Ghost)
- [] Lightning Object - Goraud
- [] Lightning Object - Phong
- [] Lightning Object - Blin
- [x] Lightning Object - Flat
- [] Bump-maps with movement (lake)
- [x] Shadows in assets
- [] Piece Material - Very specular (Gold)
- [] Piece Material - Transparent and emissive (Ruby)
- [] Piece Material - Opaque object (Diffuse)
- [x] Translation, Rotation and Scale in Ghosts
- [] BONUS: Pixelized Filter
- [] BONUS: Game Sounds
