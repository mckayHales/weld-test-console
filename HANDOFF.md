# Weld Test Console — handoff

A welder qualification test system for a steel fab shop. One CWI (McKay, Yeti Welding,
Springville UT) sells weld coupons to outside companies, witnesses the tests, and issues
signed WQTRs. Today that paperwork is done by hand. This app collects the welder's data
from their own phone and drafts the record so he only has to verify, stamp, and print.

**Current state:** working prototype, single HTML file, ~1000 lines. Not yet hosted.
All the flows below are implemented and tested.

---

## 1. Run it

```
open weld-test-console.html
```

No build step, no dependencies, no server. Everything is inline in one file — CSS, JS,
and two base64 PNG app icons. Open it in a browser and it works.

To actually use it, it has to live at a real URL (Netlify Drop, Cloudflare Pages, GitHub
Pages, or the Yeti Welding site). Link generation is disabled when it isn't hosted —
see §5.

---

## 2. Who uses which half

| | Inspector (McKay) | Welder |
|---|---|---|
| Entry point | opens the app | taps a link McKay texted |
| Sees | console: records, companies, WPS library, settings | a 5-step intake form, nothing else |
| Produces | the printed WQTR | a link containing their answers |

The welder never installs anything and never sees the console. The console is the default
screen; the intake only renders when the URL carries a `#new=` fragment (or when McKay
opens "Welder's view" to preview it).

---

## 3. Architecture

Deliberately plain. No framework, no bundler, no router library. A single mutable state
object, a map of view functions that return HTML strings, and one delegated event handler.

```
S = {
  screen,          // which VIEWS key is rendering
  stack: [],       // nav history for back()
  step,            // 0-4, welder intake only
  w: {...},        // the weld test data (blankW())
  r: {...},        // the inspection results (blankR())
  recId, coId, wpsId,
  draft: {},       // scratch object for forms (ticket, company, WPS)
  preview          // true when McKay is previewing the welder's side
}
```

### Views

`VIEWS[name]()` returns `{ body, bar }` — body goes into `#app`, bar into the fixed
bottom action bar. 15 of them:

```
home  newticket  ticketlink  records  companies  company  editco
wpslist  wpsedit  intake  sent  inspect  settings  exported  importer
```

### Navigation

`go(screen, opts)` pushes onto `S.stack`; `back()` pops. Both call `render()`.

### Rendering

`render(opts)` rebuilds the whole screen from the state object. Pass
`{keepScroll: true}` for in-place updates (tapping a tile, flipping a bend to Pass) — it
restores scroll position and refocuses the field you were typing in. Without it the
render scrolls to top, which is right for navigation and wrong for everything else.
**This was a real bug once. Don't regress it.**

### Events

One delegated `click` listener on `document`, dispatching on data attributes:

- `data-go` — navigate to a screen
- `data-act` — an action (35 of them; `grep 'a=="'` for the list)
- `data-pick` + `data-group` — tile selection
- `data-rec` / `data-co` / `data-wps` — open a record, company, or WPS
- `data-res` + `data-val` — Pass/Fail on a test result row
- `data-result` — overall Qualified / Not qualified

Field input is handled by `onField(e)`, wired to **both** `input` and `change` — see §7.

- `data-k` → writes to `S.w`
- `data-r` → writes to `S.r`
- `data-d` → writes to `S.draft`
- `data-c` → writes to `CFG`

---

## 4. Data model

`localStorage`, four keys, all prefixed `wq.`:

```
wq.cfg        { shop, city, inspector, cert, code }
wq.companies  [ { id, name, contact, phone, notes, _demo? } ]
wq.wps        [ { id, no, rev, basis, pqr, process, base, filler,
                  thickRange, positions, notes, _demo? } ]
wq.records    [ { id, w, r, updated, status, _demo? } ]
```

`raw.get/set` wraps localStorage in try/catch and falls back to an in-memory object, so
the app still runs in sandboxed iframes where localStorage throws. Data doesn't survive
reload there — expected, not a bug.

`_demo: true` marks seeded sample data. `seedDemo()` loads three welders (one awaiting
test, one qualified, one failed on a root bend), two companies, two WPSs.
`clearDemo()` removes only tagged items and leaves real data alone.

**No backend.** Records live in one browser. Settings → Export dumps everything to a
base64 blob for backup; Import replaces from one.

---

## 5. The link protocol

Data moves between phones inside URL fragments. Two directions:

```
#new=<base64>   inspector → welder   ticket prefill
                { companyId, company, name, wpsId, wps, position, process }

#t=<base64>     welder → inspector   the filled-out intake
                the whole S.w object
```

`enc()` / `dec()` are unicode-safe base64 with URL-safe substitutions (`+/=` → `-_` and
stripped padding). A full submission is ~500-700 chars, fine for SMS.

`hosted()` returns false when `location.origin` isn't http(s) — a sandboxed iframe, or a
`file://` open. In that case the UI stops offering links it can't build and shows the
bare fragment as a copyable code instead, with an explanation. The paste box accepts a
full link, a bare `#t=...` fragment, or a raw base64 string, so the round trip can be
tested without hosting.

Boot order in the IIFE at the bottom: `#new=` → welder intake; `#t=` → load and save a
record, open the inspect screen; neither → console home.

---

## 6. Domain rules, and the line that matters

Positions and thickness ranges are computed in `suggest(w)` against **AWS D1.1:2025**
(Clause 6, Part C — welder qualification).

```
POS_MAP  groove-plate  1G→F  2G→F,H  3G→F,V  4G→F,OH  3G+4G→all
         groove-pipe   1G→F  2G→F,H  5G→F,V,OH  6G→all  2G+5G→all
         fillet        1F→F  2F→F,H  3F→F,H,V  4F→F,H,OH  3F+4F→all

thickness  min = 1/8" (or T if thinner)
           max = T >= 1" ? unlimited : 2T

bend type  T >= 3/8" → four side bends
           T <  3/8" → root + face
```

**This is the important part of the whole project.** These are drafts, never authority.
Every computed range renders as an editable field, and the Print button stays disabled
until the inspector ticks a checkbox confirming he verified them against his code book.
McKay's stamp is on the output and his certification is on the line — a lookup table in
a web app must never be what that rests on.

If you extend this (ASME IX, D1.5, D1.6, F-number groupings, diameter ranges), keep that
property. Add code logic as *suggestions with an explicit verify gate*, not as answers.
Anything uncertain should render as a blank field with a "verify" note rather than a
confident wrong value. Diameter ranges are already handled this way and should stay
that way until someone confirms the table.

### Who enters what

Deliberate split. The welder is only asked things the inspector can't already know:
position, thickness, base metal, filler classification, filler diameter, gas, flow rate.
Amps, volts, polarity and preheat are **procedure** variables, not welder qualification
variables — they live on the WPS and get read off the machine by the inspector while he
witnesses. They're on the record screen, not the intake. Travel speed was removed
entirely; nobody measures ipm on a test coupon.

Everything on the welder's side after the name field is tap-only. Diameter lists swap by
process (rod sizes for SMAW, wire sizes for GMAW/FCAW, filler rod for GTAW) and the label
changes with them. Getting a welder to type on a phone in a shop is how these forms die.

---

## 7. Gotchas, all learned the hard way

**iOS fires only `change` on `<select>`, never `input`.** This killed every dropdown in
the app on a real phone while working fine on desktop. Handled by wiring `onField` to
both events and de-duplicating: the `input` listener skips selects and checkboxes, the
`change` listener handles only those. Don't collapse them back into one.

**Sandboxed previews have no origin.** `location.origin` comes back `"null"`, so
naive link building produces `null/#new=...` which phones don't linkify. Guard with
`hosted()`.

**Tile groups.** Two tile rows on the ticket screen each have a blank "Welder picks"
option. Without `data-group` they're indistinguishable and taps land on the wrong field.
Every tile row that could collide passes a group id (`tpos`, `tproc`, `wproc`).

**`esc()` turns `"` into `&quot;`.** Fine in rendered HTML, but it means string matching
against `innerHTML` in tests needs `.replace(/&quot;/g,'"')` first. Diameter values are
strings like `.045"` and `3/32"`, so this comes up constantly.

**Sticky bottom bar vs. the iOS keyboard.** The keyboard covers it. Forms that end in a
text field have an inline submit button in the body as well. Do this for any new form.

**Silent returns.** Early versions did `if(!d.name) return;` on save, which looks exactly
like a dead button. Failed validation now shows a message.

---

## 8. Testing

There's no test framework, but the app is drivable headlessly. The harness stubs enough
DOM to capture the real delegated listeners, parse buttons out of rendered HTML, and fire
synthetic clicks and field events — including iOS-style `change`-only selects.

Pattern that works:

```js
// extract the <script> body, eval it with stubs for
// document / window / location / btoa / atob / URL / Blob,
// then fire events through the captured listeners
```

Worth covering when you change things: the full ticket → intake → encode → paste →
results → print round trip, the bend-row switch at 3/8", the pipe path (5G/6G auto-
selecting pipe mode), `keepScroll` behaviour, and both hosted and sandboxed link modes.

---

## 9. Known limits

- **One browser.** No sync, no multi-device, no server. Clearing site data loses
  everything not exported. The printed WQTR is the real record; this is a drafting tool.
- **No auth.** Anyone with the URL can open the console. Fine for one person on their
  own phone, not fine the day a second person uses it.
- **Submissions are hand-carried.** The welder has to actually send the link back. If
  they don't, nothing arrives.
- **No welder continuity or expiration tracking** (D1.1 six-month continuity, requal).
  This was the most obvious next feature and is not started.
- **WPS records store data but don't print.** No WPS output document yet.
- **No photos.** No coupon or macro photos attached to a record.
- **Print is browser print-to-PDF.** Works, but no PDF generation, no archiving of the
  rendered output.

---

## 10. Where it was going next

Roughly in the order it came up:

1. **Backend so submissions land automatically.** Google Apps Script against a Sheet is
   the cheap version — the welder's form POSTs, the console polls or fetches on open.
   Keeps the "no accounts" property. Also gives an offsite copy of the records, which
   fixes the single-browser problem.
2. **Continuity and expiration tracking** per welder, with a flag when someone's
   qualification is going stale.
3. **Printable WPS** from the library.
4. **Trim the option lists to what the shop actually stocks** — the filler
   classifications, diameters and base metals are reasonable guesses for a Utah
   structural shop, not confirmed against the rack.
5. **Multi-process tickets** for combo qualifications.

---

## 11. Design

Shop-floor instrument, not SaaS. Dark steel panels, arc blue for selection, safety yellow
for attention and verification gates, oxide red for fails. Large tap targets sized for
gloved hands. The intake is framed as a torn job ticket (perforated divider) because that
matches what a welder is handed when they buy a coupon.

The printed record deliberately looks nothing like the app: black on white, hairline
boxed grid, section bars, signature block, dashed stamp box. It should read as a
certificate, because that's what gets handed to a client.

```
--ink    #16212B    --panel  #1E2B36    --panel2 #263644
--line   #3A4C5C    --paper  #E9ECEE    --muted   #93A5B3
--arc    #7FB8FF    --gold   #D8A527    --slag    #C0533A    --ok #57A773
```

Keep it one file if you can. It's the reason this thing can be emailed, hosted anywhere,
and opened from a phone in a shop with no network.
