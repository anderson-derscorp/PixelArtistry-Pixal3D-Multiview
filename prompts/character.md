# Character example: young female space mechanic

Both prompts are the ones loaded in the workflow by default.

## Step 1: Text to Image (Qwen-Image 2.1)

Settings: 1024×1024, 25 steps, cfg 1, euler / simple, `refine_prompt` off, seed `447606998181262`.

```
A young female space mechanic, stylized hero-shooter proportions, slightly larger head and hands, confident expression. Worn brown leather bomber jacket with scuffed brushed-metal shoulder pads and an orange mission patch, grey cargo pants with padded knee guards, chunky magnetic boots, a tool belt with a holstered wrench and small pouches, welding goggles pushed up on her forehead, short tied-back auburn hair with loose strands, grease smudge on one cheek. Standing in a T-pose, arms stretched straight out to the sides at shoulder height, palms facing down, fingers together, legs shoulder-width apart, feet pointing forward. Full body from head to toe, front view, orthographic, eye-level, centered, character fills 90% of the frame height, nothing cropped. Soft, even studio lighting, no harsh shadows, no reflections. Stylized 3D game character render, clean readable shapes, high-detail textures. No hand-held props, no text, no ground shadow. Plain white background.
```

## Step 2: Turnaround sheet (Qwen-Image 2.1 Edit)

Settings: custom size on, 4096×1024, 25 steps, cfg 1, euler / simple, `refine_prompt` off, seed `939810832464276`.
The front view from Step 1 is wired into `<image1>`.

```
Turn the character in <image1> into an orthographic 3D modeling reference sheet: a single horizontal row of four equal-width panels, evenly spaced. From left to right: 1) front view. 2) left side view, an exact 90° profile, snout pointing to the left edge of the image, only one eye visible, the near arm pointing straight at the camera and strongly foreshortened, the far arm hidden behind the body. 3) back view, exactly 180°. 4) right side view, an exact 90° profile, snout pointing to the right edge of the image, only one eye visible, near arm foreshortened toward the camera, far arm hidden. The camera orbits a completely static character: same T-pose and same head direction in every view, the character never turns toward the camera. Identical outfit, colors, proportions and scale in all views, each character centered in its panel, feet on the same baseline, no overlap between views. Flat, even lighting, solid black background, no text, no labels.
```

Notes:

- "snout" is the wording the workflow ships with. For a human character, "face pointing to the left/right edge of the image" is a reasonable alternative.
- Any prompt change gives a different result with the same seed. If the sheet comes out with five views or a bad side view, re-roll the seed.
