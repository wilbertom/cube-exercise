package main

import "core:fmt"
import "vendor:raylib"


main :: proc() {
	title: cstring = "Cube Exercise"

	fmt.printf("%s is starting", title)

	raylib.InitWindow(800, 450, title)

	raylib.SetTargetFPS(60)
	raylib.HideCursor()

	camera := raylib.Camera3D {
		position   = {10, 10, 10},
		target     = {0, 0, 0},
		up         = {0, 1, 0},
		fovy       = 45,
		projection = raylib.CameraProjection.PERSPECTIVE,
	}

	cube := raylib.LoadModel("models/cube.obj")

	for !raylib.WindowShouldClose() {
		{ 	// Update
			raylib.UpdateCamera(&camera, raylib.CameraMode.FIRST_PERSON)
		}

		{ 	// Draw
			raylib.BeginDrawing()
			raylib.ClearBackground(raylib.WHITE)

			raylib.BeginMode3D(camera)
			{
				raylib.DrawModel(cube, {0, 0, 0}, 1, raylib.BLACK)
			}
			raylib.EndMode3D()

			raylib.EndDrawing()
		}
	}

	{ 	// De-Init
		raylib.UnloadModel(cube)
		raylib.CloseWindow()
	}
}
