# Prop example: sci-fi jetpack

Both prompts are the examples from the notes inside the workflow. The default workflow loads the character example, so paste these in yourself.
The jetpack prompts come from the workflow notes, not from a saved test run.

## Step 1: Text to Image (Qwen-Image 2.1)

Use the same settings as the character: 1024×1024, 25 steps, cfg 1, euler / simple, `refine_prompt` off.

```
A chunky stylized sci-fi jetpack, hero prop for a 3D game. Two large cylindrical thrusters with scorched exhaust nozzles at the bottom, a rounded central fuel tank with an orange hazard stripe, riveted brushed-metal panels, a small pressure gauge and two toggle switches on top, thick padded brown leather shoulder straps attached to the back plate. Front view of the thruster side, orthographic, eye-level, centered, object fills 85% of the frame, nothing cropped. Soft, even studio lighting, no harsh shadows, no reflections. Stylized 3D game asset render, clean readable shapes, high-detail textures. No character, no hands, no smoke, no flames, no floating parts, no text. Plain white background.
```

## Step 2: Turnaround sheet (Qwen-Image 2.1 Edit)

Use the same settings as the character: custom size on, 4096×1024.

For props, **tell the model what the back looks like**, otherwise it invents one. Replace the thruster and back-plate lines with whatever defines your prop's front and back.

```
Turn the object in <image1> into an orthographic 3D modeling reference sheet: a single horizontal row of four equal-width panels, evenly spaced. From left to right: 1) front view, identical to <image1>. 2) left side view, an exact 90° profile, thrusters facing the left edge of the image, front and back seen edge-on, showing the object's full depth. 3) back view, exactly 180°: the padded back plate with both shoulder straps, thrusters hidden behind it. 4) right side view, an exact 90° profile, thrusters facing the right edge of the image, front and back seen edge-on. The camera orbits a completely static object at the same height: the object stays upright and never turns toward the camera. Identical shapes, colors, materials and scale in all views, each object centered in its panel, bottoms on the same baseline, no overlap between views. Flat, even lighting, solid black background, no text, no labels.
```
