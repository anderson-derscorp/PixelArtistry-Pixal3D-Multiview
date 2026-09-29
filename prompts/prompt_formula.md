# Step 1 prompt formula: a 3D-ready subject

Every slot exists because of what Pixal3D does with the image later.

**[Subject] + [Proportions] + [Outfit & materials] + [Pose] + [Camera & framing] + [Lighting] + [Style] + [Clean-up] + [Background]**

| Slot | What to write | Why |
|---|---|---|
| Subject | ONE character or ONE object | Two subjects end up as one fused mesh. |
| Proportions | Name them, e.g. "stylized hero-shooter proportions" | Keeps the views consistent with each other. |
| Outfit & materials | Big readable shapes plus material names (leather, brushed metal) | Better textures. Gear attached to the body is fine (tool belt, goggles). Hand-held or floating props are not. |
| Pose | **T-pose**, arms straight out at shoulder height | Separated limbs mean no arms fused into the torso. Rig-friendly. |
| Camera & framing | Full body, front view, orthographic, eye-level, centered, fills ~90% of the frame height, nothing cropped | The front view is the anchor for the other three views. |
| Lighting | Soft, even, no harsh shadows, no reflections | Whatever light is in the image gets baked into the texture. |
| Style | "Stylized 3D game character render" | Gives cleaner shapes than illustration styles. |
| Clean-up | No props, no text, no ground shadow. For props: no smoke, no flames, no floating parts | Anything extra shows up in the mesh. |
| Background | Plain white | Background removal happens in Step 3. |

Rule of thumb: if it would be hard to 3D-print, it's hard for Pixal3D too (thin, floating, transparent, overlapping parts).

## Settings used in the workflow

- 1:1, 1 MP is enough (4 MP gives you a native 2K image if you want more texture detail)
- cfg 1, 25 steps, euler / simple (the official defaults)
- `refine_prompt` **off**: the enhancer rewrites your prompt

## Examples

- [Character: space mechanic](character.md)
- [Prop: jetpack](prop_jetpack.md)
