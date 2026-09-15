# Weld Test Console — handoff

A welder qualification test system for CWIs. An inspector sells weld coupons to outside
companies, witnesses the tests, and issues signed WQTRs. This app collects the welder's
data from their own phone, files it under the inspector's account, and drafts the record
so the inspector only has to verify, stamp, and print.

Built for more than one inspector from the start: each inspection company is its own
tenant, and the plan is to offer it to other CWIs.

**Current state:** working app, hosted on GitHub Pages, data in Supabase. Multi-tenant
with sign-in. Welder submissions land automatically.

---

## 1. Run it

Live: `https://mckayhales.github.io/weld-test-console/`

Locally, any static server in the repo folder works:

```
python -m http.server 8765
```

No build step. `index.html` is the whole app; `manifest.webmanifest` and the two PNGs
make it installable ("Add to Home Screen"). The only dependency is `supabase-js`, loaded
from jsDelivr at the top of the script.

The Supabase project URL and publishable key sit at the top of the script. They are
public by design (they ship to every browser); the row-level security in the database is
what protects the data, not the key.

---

## 2. Who uses which half

| | Inspector | Welder |
|---|---|---|
| Entry point | opens the app, signs in | taps a link the inspector texted (`?t=<ticket>`) |
| Sees | console: records, companies, WPS library, settings | a 5-step intake form with the WPS card on top, nothing else |
| Produces | the printed WQTR | a record in the inspector's Test records |

The welder never installs anything, never sees the console, never makes an account. The
ticket id in the link is the only credential they have, and it's a 12-character random
token.

---

## 3. Architecture

Deliberately plain. No framework, no bundler, no router library. A single mutable state
object, a map of view functions that return HTML strings, and one delegated event handler.

```
S = {
  screen, stack, step, w, r, recId, coId, wpsId, draft, preview,
  wps,        // WPS snapshot shown on the welder's intake
  ticket,     // the ticket row just created (inspector side)
  ticketId    // the ticket being filled out (welder side)
}
AUTH = { user, org, profile }    // set after sign-in; CFG is built from org + profile
```

### Views

`VIEWS[name]()` returns `{ body, bar }`. Console screens:

```
home  newticket  ticketlink  records  companies  company  editco
wpslist  wpsedit  inspect  settings  exported  importer
```

Auth and welder screens:

```
login  onboard  loading  intake  sent  closed
```

### Data flow

Views read synchronously from a localStorage cache (`db.get`), namespaced by org id.
Writes go through `putRow(table, obj)` / `delRow(table, id)`: cache first (so the screen
updates immediately), then an upsert/delete to Supabase. `loadAll()` refetches all three
tables and is called on sign-in, on the Refresh button, and whenever the app comes back
to the foreground on a console screen — that's how new welder submissions appear.

Last write wins. There's no conflict resolution; with one inspector per org that's fine.

### Events

One delegated `click` listener on `document`, dispatching on data attributes
(`data-go`, `data-act`, `data-pick`+`data-group`, `data-rec`/`data-co`/`data-wps`,
`data-res`+`data-val`, `data-result`). Field input via `onField`, wired to **both**
`input` and `change` — see §7.

---

## 4. Database

Schema is in `supabase/schema.sql`. Six tables:

```
orgs        the tenant — one inspection company (name, city, code edition)
profiles    user → org, plus the inspector's name and cert line
companies   (org_id, id) → data jsonb       the client companies
wps         (org_id, id) → data jsonb       the WPS library
records     (org_id, id) → data jsonb       { w, r, status, updated }
tickets     id → org_id, data, wps, org_info, status, submission
```

The three data tables store the front-end object as jsonb, keyed by the short id the app
already generates. Adding a field to a form is a front-end-only change.

Row-level security: every signed-in query is filtered by `my_org()`. The `anon` role has
no table access at all. Welders go through two `security definer` functions:

- `get_ticket(tid)` — returns the prefill, the WPS snapshot, and the shop header
- `submit_ticket(tid, payload)` — inserts a record with status `Awaiting test`, marks the
  ticket submitted, and refuses a second submission

`create_org(...)` runs once on first sign-in and makes the org + profile together.

---

## 5. Sign-in

Email OTP. The inspector types their email, gets a 6-digit code, types it. No password.
The code path (rather than only a magic link) matters because a link opens in the phone's
browser, not in the home-screen app — the session would land in the wrong place. The
magic link still works as a fallback for desktop.

For the code to appear in the email, the Supabase Magic Link template must include
`{{ .Token }}`. The Site URL and redirect list must include the hosted URL.

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
The inspector's stamp is on the output and his certification is on the line — a lookup
table in a web app must never be what that rests on.

If you extend this (ASME IX, D1.5, D1.6, F-number groupings, diameter ranges), keep that
property. Add code logic as *suggestions with an explicit verify gate*, not as answers.

### The WPS card

A WPS in the library carries the procedure variables (filler, diameter, gas, flow, amps,
volts, polarity, preheat) alongside the qualification ones. When a ticket names a WPS,
the welder's intake shows the card at the top of the "What are you welding?" step, and
`prefillFromWps` pre-picks the tiles that exactly match — process, filler, diameter, gas,
flow, base metal. Anything without an exact tile match stays blank for the welder to
pick; the card still shows it. The ticket stores a snapshot of the WPS at creation, so a
later edit to the library doesn't change what a welder already saw.

### Who enters what

The welder is only asked things the inspector can't already know: position, thickness,
base metal, filler, diameter, gas, flow. Amps, volts, polarity and preheat are procedure
variables — read off the machine by the inspector while witnessing, on the record screen.

Everything on the welder's side after the name field is tap-only.

---

## 7. Gotchas, all learned the hard way

**iOS fires only `change` on `<select>`, never `input`.** Handled by wiring `onField` to
both events and de-duplicating. Don't collapse them back into one.

**`render()` scrolls to top unless you pass `{keepScroll:true}`.** Right for navigation,
wrong for tapping a tile. This was a real bug once.

**Tile groups.** Tile rows that could collide pass a group id (`tpos`, `tproc`, `wproc`).

**`esc()` turns `"` into `&quot;`.** Diameter values are strings like `.045"`, so string
matching against `innerHTML` needs `.replace(/&quot;/g,'"')` first.

**Sticky bottom bar vs. the iOS keyboard.** Forms that end in a text field have an inline
submit button in the body as well.

**Silent returns.** Failed validation must show a message, never just return.

**The sign-in check races your own test code.** If you drive the app from the console
during development, `getSession()` resolving will render the login screen over whatever
you set up. Set `S.screen` and call `render()` again.

---

## 8. Known limits

- **One inspector per org.** The schema supports more (profiles → org), but there's no
  invite flow yet. Adding a coworker to the *same* company means inserting their profile
  row by hand. Separate companies just sign up separately.
- **No welder continuity or expiration tracking** (D1.1 six-month continuity, requal).
- **WPS records don't print.**
- **No photos.**
- **Print is browser print-to-PDF.** No archiving of the rendered output.
- **Offline is read-only-ish.** The cache lets the console open without signal, and
  writes go to the cache, but a write made offline is not queued for later — it's lost
  on reload. Fine for now; a retry queue is the fix if it bites.

---

## 9. Where it was going next

1. **Continuity and expiration tracking** per welder — the feature another CWI would pay for.
2. **Invite a coworker** to the same org.
3. **Printable WPS** from the library.
4. **Trim the option lists** to what the shops actually stock.
5. **Multi-process tickets** for combo qualifications.
6. **Custom domain** for the hosted app.

---

## 10. Design

Shop-floor instrument, not SaaS. Dark steel panels, arc blue for selection, safety yellow
for attention and verification gates, oxide red for fails. Large tap targets sized for
gloved hands. The intake is framed as a torn job ticket because that matches what a
welder is handed when they buy a coupon. The WPS card is a deeper blue panel so it reads
as "given to you," not "pick from this."

The printed record deliberately looks nothing like the app: black on white, hairline
boxed grid, section bars, signature block, dashed stamp box. It should read as a
certificate, because that's what gets handed to a client.

```
--ink    #16212B    --panel  #1E2B36    --panel2 #263644
--line   #3A4C5C    --paper  #E9ECEE    --muted   #93A5B3
--arc    #7FB8FF    --gold   #D8A527    --slag    #C0533A    --ok #57A773
```
