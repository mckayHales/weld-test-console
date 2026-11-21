"""Weld Sync app icon. Drawn at 4096 px and shrunk with Lanczos so every
edge is smooth. Full-bleed square: iOS and Android round the corners
themselves. Everything that matters sits inside the middle 80% so the
Android "maskable" circle crop doesn't cut it."""
import sys, math
from PIL import Image, ImageDraw, ImageFilter

out_dir = sys.argv[1]
N = 4096
S = N / 1024.0          # design units are a 1024 canvas
def P(*xy): return [v * S for v in xy]

def gradient(w, h, top, bot):
    g = Image.new("RGB", (1, h))
    for y in range(h):
        t = y / (h - 1)
        g.putpixel((0, y), tuple(int(top[i] + (bot[i] - top[i]) * t) for i in range(3)))
    return g.resize((w, h))

INK_TOP, INK_BOT = (34, 50, 64), (14, 21, 28)
STEEL, STEEL_HI, STEEL_LO = (74, 94, 112), (112, 136, 158), (46, 61, 74)
GOLD, GOLD_HI, GOLD_LO = (226, 172, 44), (250, 212, 110), (176, 126, 24)
ARC = (127, 184, 255)

img = gradient(N, N, INK_TOP, INK_BOT).convert("RGBA")

# --- arc glow, soft, behind everything above the plates ---
glow = Image.new("RGBA", (N, N), (0, 0, 0, 0))
gd = ImageDraw.Draw(glow)
cx, cy = 512 * S, 500 * S
for r, a in [(330, 40), (230, 70), (150, 110), (90, 170)]:
    gd.ellipse([cx - r * S, cy - r * S, cx + r * S, cy + r * S], fill=ARC + (a,))
glow = glow.filter(ImageFilter.GaussianBlur(70 * S))
img = Image.alpha_composite(img, glow)

d = ImageDraw.Draw(img)

# --- the joint, in section: two beveled plates on a backing bar ---
top, bot = 610, 770          # plate surface and underside
gap = 40                     # half root opening
bevel = 150                  # half groove width at the surface
# left plate
d.polygon(P(150, top, 512 - bevel, top, 512 - gap, bot, 150, bot), fill=STEEL)
d.polygon(P(150, top, 512 - bevel, top, 512 - bevel + 8, top + 22, 150, top + 22), fill=STEEL_HI)
# right plate
d.polygon(P(512 + bevel, top, 874, top, 874, bot, 512 + gap, bot), fill=STEEL)
d.polygon(P(512 + bevel - 8, top + 22, 874, top + 22, 874, top, 512 + bevel, top), fill=STEEL_HI)
# backing bar
d.rectangle(P(512 - 150, bot, 512 + 150, bot + 64), fill=STEEL_LO)

# --- the weld: fills the V, crowns over the top ---
d.polygon(P(512 - bevel - 6, top, 512 + bevel + 6, top, 512 + gap, bot + 6, 512 - gap, bot + 6), fill=GOLD)
d.chord(P(512 - bevel - 14, top - 62, 512 + bevel + 14, top + 58), 180, 360, fill=GOLD)
# ripples on the cap
d.arc(P(512 - bevel + 10, top - 46, 512 + bevel - 10, top + 30), 205, 335, fill=GOLD_HI, width=int(9 * S))
# shadow line where the cap meets the plates
d.line(P(512 - bevel - 14, top + 1, 512 + bevel + 14, top + 1), fill=GOLD_LO, width=int(6 * S))

# --- the electrode and the arc ---
d.rounded_rectangle(P(512 - 24, 170, 512 + 24, 466), radius=16 * S, fill=(205, 226, 255))
d.polygon(P(512 - 24, 456, 512 + 24, 456, 512, 494), fill=(205, 226, 255))
rays = Image.new("RGBA", (N, N), (0, 0, 0, 0))
rd = ImageDraw.Draw(rays)
for ang, ln, w in [(-162, 210, 14), (-18, 210, 14), (-140, 150, 10), (-40, 150, 10), (180, 230, 12), (0, 230, 12), (160, 120, 9), (20, 120, 9)]:
    a = math.radians(ang)
    rd.line([cx, cy, cx + math.cos(a) * ln * S, cy + math.sin(a) * ln * S], fill=(225, 238, 255, 235), width=int(w * S))
rays = rays.filter(ImageFilter.GaussianBlur(2 * S))
img = Image.alpha_composite(img, rays)
d = ImageDraw.Draw(img)
r = 40
d.ellipse(P(512 - r, 500 - r, 512 + r, 500 + r), fill=(255, 255, 255))

master = img.convert("RGB")
for size, name in [(1024, "icon-1024.png"), (512, "icon-512.png"), (192, "icon-192.png"), (180, "apple-touch-icon.png"), (32, "favicon-32.png")]:
    master.resize((size, size), Image.LANCZOS).save(f"{out_dir}/{name}", optimize=True)
print("ok")
