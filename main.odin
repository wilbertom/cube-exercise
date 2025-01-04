package main

import "core:c"
import "core:fmt"
import "vendor:raylib"

main :: proc() {
	title: cstring = "Cube Exercise"

	fmt.printf("%s is starting", title)

	raylib.InitWindow(800, 450, title)

	raylib.SetTargetFPS(60)

	fovy: f32 = 45

	positionX: f32 = 10
	positionY: f32 = 10
	positionZ: f32 = 10

	camera := raylib.Camera3D {
		target     = {0, 0, 0},
		up         = {0, 1, 0},
		projection = raylib.CameraProjection.PERSPECTIVE,
	}

	cube := raylib.LoadModel("models/cube.obj")

	for !raylib.WindowShouldClose() {
		{ 	// Update
			camera.fovy = fovy
			camera.position = {positionX, positionY, positionZ}
			raylib.UpdateCamera(&camera, raylib.CameraMode.FIRST_PERSON)
		}

		{ 	// Draw
			raylib.BeginDrawing()
			raylib.ClearBackground(raylib.WHITE)

			raylib.GuiSlider(
				raylib.Rectangle{x = 40, y = 10, width = 200, height = 20},
				"fovy less",
				"more",
				&fovy,
				45,
				90,
			)

			raylib.GuiSlider(
				raylib.Rectangle{x = 40, y = 40, width = 200, height = 20},
				"x less",
				"more",
				&positionX,
				0,
				100,
			)
			raylib.GuiSlider(
				raylib.Rectangle{x = 40, y = 70, width = 200, height = 20},
				"y less",
				"more",
				&positionY,
				0,
				100,
			)
			raylib.GuiSlider(
				raylib.Rectangle{x = 40, y = 100, width = 200, height = 20},
				"z less",
				"more",
				&positionZ,
				0,
				100,
			)

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
