# Weld Sync — handoff

A welder qualification test system for CWIs. An inspector (the org — McKay's own inspection
company, not the welder's employer) sells weld coupons to outside companies, witnesses the
tests, and issues signed WPQRs under the inspection company's letterhead. This app collects the welder's
data from their own phone, files it under the inspector's account, and drafts the record
so the inspector only has to verify, stamp, and print.

Built for more than one inspector from the start: each inspection company is its own
tenant, and the plan is to offer it to other CWIs.

**Current state:** working app, hosted on GitHub Pages as a plain static page. No server,
no accounts. Everything the inspector has lives on their phone. Tickets go out as links
and the welder's answers come back as links. The printed WPQR and WPS are laid out like
Yeti Welding's paper forms.

It was on Supabase (sign-in, row-level security, welder submissions written straight to
the DB) from Sept to Nov 2026, and went back to links on purpose. That version is in git
history at `c50ff41` if it's ever wanted again.

---

## 1. Run it

Live: `https://mckayhales.github.io/weld-test-console/`

Locally, any static server in the repo folder works:

```
python -m http.server 8765
```

No build step. `index.html` is the whole app; `manifest.webmanifest` and the two PNGs
make it installable ("Add to Home Screen"). The only dependencies are `jspdf` and
`jspdf-autotable` from jsDelivr, fetched in the background at boot and used only to build
the PDFs.

It still has to be *hosted* (GitHub Pages) — that's what makes it installable and gives
the links somewhere to open. Hosting is just serving the one file; nothing is stored there.

---

## 2. Who uses which half

| | Inspector | Welder |
|---|---|---|
| Entry point | opens the app from the home screen | taps a link the inspector texted (`#new=…`) |
| Sees | console: records, inspection reports, companies, procedures (WPS + PQR), settings | a 5-step intake form with the WPS card on top, nothing else |
| Produces | WPQR, WPS, PQR and inspection-report PDFs | a link they text back (`#t=…`) |

The welder never installs anything, never sees the console, never makes an account.

### The two links

Both carry their data after the `#`, which browsers never send to the server.

```
ticket.html#k=<ticket>   Weld Ticket, inspector → welder. Deflated JSON:
                         { id, data: prefill, wps: WPS snapshot, org: shop header,
                           pk: the inspector's public key }
done.html#f=<sealed>     Finished Ticket, welder → inspector. { tid, w } deflated and
                         sealed to pk: a one-time ECDH P-256 key on the welder's phone,
                         AES-GCM. Bytes: 65 ephemeral public key | 12 IV | ciphertext.
```

`ticket.html` and `done.html` are one-line pages with Open Graph tags ("Weld Ticket",
"Finished Ticket", the app icon) that `location.replace()` into the app with the hash.
Messages reads those tags, so a link **sent on its own** shows as a card with that title
instead of a wall of characters — which is why Send / Text it put only the URL in the
message. Android SMS (green bubbles) has no cards and shows the URL.

Deflate is `CompressionStream("deflate-raw")`, with pako from jsDelivr on phones without
it (iOS before 16.4). A ticket runs ~1.3 KB with a WPS, a finished ticket ~650 bytes.

The inspector's key pair is made on first run (`myKeys()`) and kept in `wq.local.keys`, a
ring so older pairs still open old tickets. **Backups carry the ring**; a new phone that
imports one opens tickets sealed to the old phone. A finished ticket no key in the ring
opens says so instead of filing anything. The record id is `"t" + tid`, so the same link
opened twice opens one record. The older open kinds (`#new=`, `#t=`) still work.

What this protects: someone who sees the Finished Ticket can't read the welder's name,
company or answers. The Weld Ticket is only deflated, not secret — it holds nothing the
welder isn't shown, and the welder has to be able to open it. Anyone holding a Weld Ticket
could send back a made-up Finished Ticket; the inspector witnesses the test anyway. The
domain (github.io) still shows; a custom domain is the fix for that.

The welder's phone remembers a sent ticket (`wq.sent.<tid>`), so reopening the Weld
Ticket shows "Your test ticket" with the WPS and the Finished Ticket again.

**The iPhone catch.** A link tapped in Messages opens in Safari, not the home-screen app,
and iOS gives the two separate storage. So `#t=` opened somewhere with no setup shows the
`landed` screen: "Copy the link, open Weld Sync, Test records → Paste it." In the app,
"Paste it" uses `navigator.clipboard.readText()` (one tap on iOS's Paste bubble), with a
textarea fallback. Where the records *are* (a desktop browser, an Android PWA that captures
its links), it files the record straight away.

---

## 3. Architecture

Deliberately plain. No framework, no bundler, no router library. A single mutable state
object, a map of view functions that return HTML strings, and one delegated event handler.

```
S = {
  screen, stack, step, w, r, recId, coId, wpsId, draft, preview,
  wps,        // WPS snapshot shown on the welder's intake
  ticket,     // the ticket just created, before it goes in the link (inspector side)
  ticketId,   // the ticket being filled out (welder side)
  welder,     // true when this visit came from a #new= link
  landed,     // a #t= link opened where there are no records
  pdf         // { doc, url, name, title, note, pages } behind the pdfview screen
}
CFG = { shop, city, address, phone, logo, inspector, cert, code }   // wq.local.cfg
```

### Views

`VIEWS[name]()` returns `{ body, bar }`. Console screens:

```
home  newticket  ticketlink  records  inspect
inspections  inspedit                      job-site visual inspection reports
companies  company  editco
wpslist  wpsedit  wpsview                  WPSs and PQRs together ("Procedures"); a PQR is a
                                           wps row with kind:"PQR"
pdfview  settings  exported  importer
```

First-run and welder screens:

```
onboard  intake  sent  myticket  closed  landed
```

### Data flow

Views read synchronously from localStorage (`db.get`, keys `wq.local.*`). Writes go
through `putRow(table, obj)` / `delRow(table, id)`; `getRow(table, id)` reads one. Settings
are `wq.local.cfg`; first run (no shop name) shows `onboard`.

**Deleting** goes through `removeRow(table, id)`: it deletes, then shows a toast with
Undo for six seconds that puts the row back where it was. No "are you sure" dialogs.
Every list row (records, companies, WPS/PQR, inspection reports) is wrapped by
`swipe(table, id, rowHtml)`; drag left past halfway to delete, or a short drag to show
the Delete button, as in Messages. The gesture code is the `SWIPE` block above
`refreshBar()`; `touch-action: pan-y` on the row keeps vertical scrolling native, and a
capture-phase click listener swallows the click that ends a drag.

**Navigation.** `go(screen, opts)` pushes a frame holding every field in `FRAME`
(screen, ids, step, `draft`, `viewWps`, `pdf`), and `back()` restores it, so a half-filled
form survives a detour (New ticket → Add company → back). Each screen that edits a copy
keeps it in `S.draft`: Settings edits a copy of `CFG` and only Save commits it.

**The record screen saves as you go.** Every field change calls `autosave()` (400 ms
debounce), and `go()` / `back()` call `flushSave()`. `upsertRecord()` merges into the
stored row, so flags the screen doesn't own (`archived`, `_demo`) survive a save.

`carryOver()` runs once: if there's no `wq.local.cfg` but the old signed-in version left a
cache (`wq.profile.<user>` and `wq.<org id>.<table>`), it copies that in, so the phone
keeps what it had.

### Events

One delegated `click` listener on `document`, dispatching on data attributes
(`data-go`, `data-act`, `data-pick`+`data-group`, `data-rec`/`data-co`/`data-wps`,
`data-res`+`data-val`, `data-result`). Field input via `onField`, wired to **both**
`input` and `change` — see §6.

---

## 4. Backups

There is no other copy of the data. Settings → Export everything → **Save backup file**
writes `WeldSync-backup-<date>.json` through the share sheet (Files, Mail); the same data
can be copied as base64 text. Import takes the file or the text (`readBackup()` accepts
either) and merges it in (same id → the backup's copy wins). On a fresh phone, the
first-run screen has "Restore from a backup instead", which also brings the letterhead
settings.

---

## 5. Domain rules, and the line that matters

### The PDFs

Four documents — WPQR, WPS, PQR, inspection report — are **built in the app with jsPDF**,
not printed through the browser.
The browser route was tried first: iOS lays a print page out at its own width, so the
sheet spilled off the right edge and onto a second page, and there was no way to see
what the phone would do from a desktop. With jsPDF every box goes at a fixed spot on a
letter page (612 × 792 pt, 30 pt margins), so it is one page on anything, and the result
is a file. `showPdf()` opens it on the `pdfview` screen (an iframe, with a Save / Share
button); `deliverPdf()` hands it to the share sheet on a phone (Files, Messages,
AirPrint), opens it in a tab on a desktop, or downloads it. Settings has "Preview a WPQR"
and "Preview a WPS" that build the sample documents so the layout can be checked without
a real record.

Every letterhead is `letterhead(d, title, brand)`: a logo top-left if there is one, the
name in the brand color, address · phone, the document title.

**Whose letterhead.** The org's (the inspection company) by default. A client who wants
records in their own binder under their own name gets branding on their company row
(`letterhead:"company"`, `lhName`, `lhAddress`, `lhPhone`, `lhColor`, `logo` — the
"Their letterhead" card on the company screen). A record follows the company's setting
unless `w.letterhead` overrides it. A client's name prints in the color picked on its company row, else the main color of its logo (`logoColor()`: the commonest saturated color, ignoring white, black and grey; read when the logo is added, and once at boot for older logos into `lhLogoColor`), else black. A saved `lhColor` equal to the old red default counts as not picked (the select under Company on the record screen); a WPS
or PQR prints on the letterhead of the company it belongs to (`p.companyId`, "Whose
procedure" in the editor), or the org's for library procedures. `recordBrand(w)` and
`wpsBrand(p)` resolve it. Whichever letterhead is on top, the certification block names
the org and the inspector as the tester and the org's inspector signs "Authorized by" —
that is the third party on the record, and it is the point. A ticket snapshots the WPS's
brand (`t.wps.brand`) so the welder's copy matches.

`wpqrPdf(draft)` is the **Welder Performance Qualification Record**, drawn to the
shop's own WPQR (Matt's spreadsheet form) **rule for rule**. Every x and y in `WQ` and in
`wpqrPdf` was measured off that PDF with PyMuPDF: 6.56 pt Helvetica body, 10.6 pt rows,
text sitting 1.6 pt above the bottom rule the way a spreadsheet prints, grey fills where
his are. It does not use autoTable; `ruled(d, {cols, y, rows})` draws one table at fixed
column rules, with `{gap:1}` cells for the white space between the actual and qualified
halves, and shrinks then wraps a cell that is too long (the row grows). `formHead()` is
his letterhead: grey bar, 94 pt logo box left, name/address/phone centered at x 326.5.
Values print his way through `pv()`: "-" for nothing, `3/8"` as "3/8 in", ranges as
"1/8 in - 3/4 in"; dates as 7/2/2025. With no record number typed, `recNo()` writes it as
he does ("Mckay Hales WPQR 3G FCAW"), and the same goes on the File Number line. Only
the test-results table grows (one row per specimen set; a set with mixed results prints
each specimen); a short remark goes in the Remarks column, a long one gets its own row.
Where his sheet disagrees with the code, the code wins: filler spec by classification
(E71T-1C is A5.20, not A5.1), groups in Roman numerals as D1.1:2025 Table 5.6 prints them (`metalGroup()`: A36 is
Group II over 3/4"),
thickness ranges from `suggest()`. Preview on an unverified record carries a DRAFT
watermark; Save stays disabled until the verify gate is ticked. WPQR and WQTR are two
names for the same document; the paper says WPQR, so the app does too.

To re-check the layout against the reference: render both with PyMuPDF and compare span
origins (`page.get_text("dict")`) — every label should land within a point of his.

`wpsPdf(p)` is the WPS the same way: header strip, base metals beside the thickness
table, joint details beside the sketch and the prequalified designation, a Procedure bar,
process / electrical / gas down the left, filler / technique / preheat down the right.
The sketch is **drawn from the WPS fields** by `drawJoint()` — groove type, angle, root
opening, root face, backing and joint type set the shape; α, R, f and T are labelled as
on the paper — not scanned from the code book (AWS's figures are copyrighted, and the
drawing follows the numbers anyway). Butt joints show two plates in line; T, corner, lap
and edge joints show a base plate and a member; fillets show the legs. `pqrPdf(p)`
is the PQR: the procedure as run, per-pass readings, test results. `inspectionPdf(i)` is
the Report of Visual Inspection, drawn rule for rule to Matt's own report (measured the
same way as the WPQR; geometry in `IR`): grey bars top and bottom, report number and date
in the corner box, the job block as label-and-rule pairs, then three yes/no questions with
checkboxes (`meetsVisual`, `workmanship`, `rework` — "Yes" / "Not Necessary"), the re-work
line (`reworkNote`), remarks on the dotted lines (`notes`, one per line, printed "- …";
five fit, more close the lines up, past eleven they continue on page 2), standards, and
the signature / CWI number / date row. Reports from before the questions keep their
`items` and print them as remarks.

Clause 8 fields on the report: report date and inspection date (`inspDate`, "Inspected:"
in the job block), role (Contractor's 8.1.2 / Verification 8.1.3, "Role:"), loading
(Static / Cyclic / Tubular — `visualTable()` picks Table 8.1's column or Table 10.14; the
code's own 7.23 misprints 10.15), drawings (8.1.6), base metal, WPS used (8.3.3), welders
with their WPQR (8.4.1), welds not on the drawings with the Engineer's approval reference
(8.5.1). Those print as the first remarks (`autoRemarks()`); members and joints with
specified and measured size (8.5.1, 8.5.3, 8.5.4) print as a table on the last page.
`inspChecks()` warns on future dates, a client name that is a saved company's words in
another order, missing loading, and A514/A517/HPS 100W (48 h, Table 8.1 (5)); welds off
the drawings with no approval reference block Save until kept. Standards default to the
edition and the contract documents only (8.7).

**Previewing.** `pdfview` no longer shows the PDF in an iframe — iOS draws an iframe'd
PDF at full size and clips it. `drawPdfPages()` renders each page with pdf.js
(jsDelivr, fetched the first time a preview opens) onto canvases the width of the
screen, so the whole page shows; Whole page / Zoom / Zoom more widen them and the box
scrolls both ways, and pinch zoom works on top. No signal → falls back to the iframe.
Every document is US letter portrait.

**Printing.** The preview's **Print** button (`printPdf()`) prints the PDF itself. A web
page printed on an iPhone gets the site address and page numbers stamped at the bottom,
and its margins push a letter page onto a second sheet; iOS gives a page no way to turn
that off. So on a phone (`isPhone()`) Print opens the share sheet with the PDF file and a
toast says to tap Print there — that prints the document clean, one sheet a page. On a
computer the PDF goes into a hidden iframe and the browser's PDF printer prints it. If
neither is possible, `printImages()` draws each page at 200 dpi and prints the images
through `window.print()` (`#printpages`, `@media print`), sized to fit inside the
printer's margins. Save / Share → Print stays the manual fallback. A record outside its WPS and not settled previews — and so prints — as DRAFT.

**Which code a record is qualified to** is per record (`w.code`, defaulting to the org's
edition; `recCode(w)`). Only D1.1 has lookup tables: for D1.3 / D1.4 `suggest()` returns
blank ranges and the record screen says to fill them from the book — never a D1.1 number
on a D1.3 form. Adding a code means adding its tables next to `POS_MAP` and teaching
`suggest()` and `clauseRefs()` about it.

`grid()` wraps autoTable with the house style (hairline borders, no fills, bold label
column). Side-by-side tables are two `grid()` calls at the same `y` with different `x`
and `w`; continue from the larger of the two returned bottoms.

The acceptance-criteria column takes its clause numbers from `CLAUSES`, keyed by code
edition. D1.1:2025 is checked against McKay's book: visual 6.10.1 (6.23.1), bends
6.10.3.3 (6.23.5), specimens 6.10.3.1 with Fig. 6.8 (face/root) or Fig. 6.9 (side), RT in
lieu of bends 8.12.2 except 8.12.2.2 (6.23.3.2; never for GMAW-S, 6.18.1.1). 2020 keeps
the numbers read off the shop's records. Any other edition prints "Clause 6" — never
"Clause 6, Part C" for criteria that live in 6.10 (Part B).

Positions and thickness ranges are computed in `suggest(w)` against **AWS D1.1:2025**
(Tables 6.11–6.14 for plate, 10.8 and 10.12 for pipe). The code references live in
`docs/d1.1-2025/` — read `CLAUDE.md` and that folder's README before changing any of it.

```
POS_MAP  groove-plate  1G→F  2G→F,H  3G→F,H,V  4G→F,OH  3G+4G→all
         groove-pipe   1G→F  2G→F,H  5G→F,V,OH  6G→all  2G+5G→all
         fillet        1F→F  2F→F,H  3F→F,H,V  4F→F,H,OH  3F+4F→all

thickness  plate (6.12)  min 1/8" (or T if thinner); max T >= 1" ? unlimited : 2T
           pipe (10.12)  1/8" to 3/4"; unlimited on OD > 4" with wall > 3/8"
diameter   plate groove  24" OD and up, with backing or backgouging only (6.11 fn b)
           pipe (10.12)  OD <= 4": 3/4" to 4"; else max(OD/2, 4") and up (fn f)

bend set   plate  T <= 3/8"  → 1 root + 1 face     (BEND_SETS.rf)
                  T >  3/8"  → 2 side              (s2)
           pipe   1G/2G: 1 root + 1 face, 2 side over 3/8" wall
                  5G/6G: 2 root + 2 face (rf2), 4 side over 3/8" wall (s4)
```

**Not welder variables.** Table 6.13 lists no base metal, filler classification (other
than the SMAW F-number, Table 6.14), gas or filler diameter. Those print as tested, with
"Any - not a welder variable (Table 6.13)" or "As tested - not a limit" in the qualified
column. The process qualified is FCAW for FCAW-G or -S; GMAW-S is its own process.

**Header and signatures.** "Qualified To" is "AWS D1.1/D1.1M:2025, Clause 6" (Clauses 6
and 10 on pipe) — welders qualify to the clause, not a joint. The joint (designation,
angle, root from the WPS) is the "Test Joint" row. The test number (`r.labNo`, 2026-001
and on, `nextLabNo()`) is given the first time a final WPQR is saved and prints under
Certification. The WPQR is the Contractor's certification (6.20, 6.2.2.2): left block
"Certified by — <company> (Contractor)" with the signer's name and title (`r.certName`,
`r.certTitle`), right block "Test witnessed and verified by" with the inspector and date.

**What blocks Save WPQR** (`recordChecks()`): no test thickness, no pipe OD on pipe, RT on
GMAW-S. Fig. 6.21 (welder coupon α 45° / R 1/4" with backing, 60° / 3/16" without, unless
a prequalified Fig. 5.1 detail) is a warning only.

**3G + 4G on two records.** `combinedWith(w,id)` finds the same welder (name + company),
same process family, with the other plate of the pair passed (3G/4G, 3F/4F, 2G/5G pipe).
Each record keeps its own ranges; a "Combined with 4G" row under Test Results says the two
together qualify all positions (Table 6.11 / 10.8).

**Continuity, not expiry** (6.2.3.1). Home → **Welders**: one row per welder and process
family with the last date they welded with it (latest test, or a date logged on `r.cont`
of their latest qualified record) and the date it lapses, six months on. No expiry
prints on any document.

The bend set is a default (`bendDefault(w)`), shown on the record screen as a select;
the inspector's choice (`r.bendSet`) is what the result rows and the printed record use.
Older records with no `bendSet` are read back from which results were filled in
(`bendSet(r, w)`). It used to be "T ≥ 3/8 → four side bends" for everything, which put
four side bends on a 3/8" plate — the shop's own 3/8" record is root + face.

On pipe the coupon thickness is the wall: the intake asks "Wall thickness" and the OD,
and `tVal()` falls back to the old `pipeWall` field for records from before. A vertical
position (`isVertical()`: 3G, 5G, 6G, 3F and the combos) requires uphill or downhill
from the welder unless the WPS fixes it; it prints on the Progression row.

**This is the important part of the whole project.** These are drafts, never authority.
Every computed range renders as an editable field, and the Print button stays disabled
until the inspector ticks a checkbox confirming he verified them against his code book.
The "Qualified range — draft" card on the record screen has one row per range on the
printed WPQR, in the same order: joints, base metal, groove and fillet thickness,
diameter, process, backing, filler (F-number group for SMAW), groove and fillet positions.
The lookups behind them — `POS_MAP`, `FILLET_FROM_GROOVE`, `METAL_GROUP`, `FILLER_SPEC`,
`F_NUMBER` — sit next to `suggest()`.
The inspector's stamp is on the output and his certification is on the line — a lookup
table in a web app must never be what that rests on.

If you extend this (ASME IX, D1.5, D1.6, F-number groupings, diameter ranges), keep that
property. Add code logic as *suggestions with an explicit verify gate*, not as answers.

### The WPS card, and PQRs

A WPS in the library carries every field on the shop's paper WPS form: header (number,
rev, date, contact, prequalified or PQR + CVN), joint details with the prequalified joint
designation (`jointDesig`, e.g. `B-U2a-GF` — it prints on the WPQR's "Qualified To"
line), backgouging, base and welded-to metals, filler with spec and manufacturer (picking
a classification fills in its AWS spec; a typed one gets it by pattern), gas with nozzle
and contact-tip-to-work, electrical with power source and max heat input, supplemental
filler, preheat/interpass/PWHT, and technique with peening.

A **PQR** is the same editor with `kind:"PQR"`: start one from a WPS ("Qualify this procedure" on the WPS view —
`pqrFromWps` copies the procedure over as run) or from scratch, then add the welder, the
date, per-pass readings, and test results. A WPS "qualified by PQR" picks the PQR from
the list. Both live under Procedures. Diameter and flow may be ranges (`.045" to 1/16"`, `30–40`);
`prefillFromWps` only pre-picks a value that matches a tile exactly, so a range leaves
the welder to pick the one on the machine. When a ticket names a WPS,
the welder's intake shows the card at the top of the "What are you welding?" step, and
`prefillFromWps` pre-picks the tiles that exactly match — process, filler, diameter, gas,
flow, base metal. Anything without an exact tile match stays blank for the welder to
pick; the card still shows it. The ticket stores a snapshot of the WPS at creation, so a
later edit to the library doesn't change what a welder already saw.

### Recognizing a company and a returning welder

A welder types their employer; their phone has no client list (it would be every
client's name in every link). When the link comes back, `recognize(w)` matches the typed
name against Companies (`matchCompany()`: case, punctuation and LLC/Inc ignored; an exact
match, or one name starting the other when only one company fits) and files the record
under it, and fills the welder's stamp and division from their latest earlier test with
that company. The toast says what it matched.

### Entering a test by hand

When no link went out, **Enter a test by hand** (home screen, and the bar on Test
records) opens a blank record with the **Test coupon** card open: date, WPS, weld type,
plate/pipe, process, position (and transfer / progression when they apply), base metal,
thickness, OD, backing, filler, diameter, gas, flow — selects, not tiles, since this is
the inspector's screen. Picking a WPS runs `prefillFromWps()` on the record. `coupled()`
clears what depended on a changed field (new process → filler and gas cleared), the
same as the welder's tiles. On a record that came from a welder the card starts closed
as a one-line summary, and Edit opens it, so the inspector can fix a welder's mistake.

### More than one plate on a ticket

3G and 4G on the same day is the usual pair, and each plate gets its own WPQR. The
welder's position tiles are multi-select (`w.positions`, kept sorted; `w.position` is the
first, so single-position code keeps working); the combined tiles ("3G+4G" — both plates
on one record, qualifying all positions) stand alone (`togglePos()`). The inspector can
lock one or several positions on New ticket. Progression is asked if any plate is
vertical (`anyVertical()`), and the draft ranges show per plate (`posRanges()`).

When the Finished Ticket comes in, `takeReturn()` files one record per plate: ids
`t<tid>-3G`, `t<tid>-4G`, the same `w` but each with its own `position`, linked by
`w.group`; each has its own results, verify gate and WPQR (the record number differs by
position). A record in a group shows **Same test, other plate** with a link to the rest.
On a hand-entered record, **+ Another plate, same test** saves this one and opens a new
record with the same welder, coupon and WPS, in the same group, position blank.

`openRecord()` goes through `go()`'s options so the screen being left is saved and framed
before `S.w` changes, and `back()` onto a record screen reloads that record from storage
— together they make record → other plate → Back land on the right record.

### A test record against its WPS

`wpsDiffs(w, p)` compares a record with the WPS it names: wire speed, typed amps (amps
worked out from wire speed follow the wire speed and aren't judged), volts, gas flow
against the WPS ranges — a single value on a prequalified WPS gets its Table 5.5
tolerance, a range is taken as written — and process, filler, diameter (a WPS range like
`.045" to 1/16"` counts), gas, polarity, transfer, base metal, thickness (`thickRange`),
position (the letters a test position needs, `POS_NEEDS`, against the WPS's positions),
progression and backing. `wpsDiffCard()` sits under the Test coupon card only when there
are differences and outlines the boxes that are off. Each one can be corrected as a typo
(the nearest allowed value, rounded inward), the record can switch to a WPS that covers
it as it stands (`wpsThatFit()`), or the inspector keeps it as tested — `r.wpsAck` stores
the signature of what was kept, so any new difference opens the warning again. **Save
WPQR refuses** while a difference is neither fixed nor kept.

### A client's own WPS

A WPS with `companyId` belongs to that client and prints on their letterhead (`wpsBrand()`
→ `companyBrand()`: logo, name in their color, address, phone; their name in the
Company Name box). The client's company screen lists **Their procedures** with
**Give them a WPS from your library** (`wpscopy` picker) and **Start a blank one**; the
WPS editor has **Copy for a company** (`wpscopyto`). Both make a copy with
`wpsCopyFor(p, c)`: same procedure, new id, `companyId` set, contact from the company,
starter flag and the starter's note dropped — the library WPS stays untouched. WPS
pickers label each one with its owner (`wpsPick()`) and list the client's own first
(`wpsFor(coId)`). A new inspection report can fill client, contact and phone from a
company (`#inspco`).

### The Clause 5 check on a prequalified WPS

From D1.1:2025 Clause 5 (McKay's photos; the checklist is
`docs/d1.1-2025/wps-prequalified-checklist.md`):
5.2.1 says the Table 5.5 variables shall be on the written WPS and, where they have
limits, within them. `wpsChecks(p)` runs on WPSs with basis "Prequalified" under a D1.1
edition and returns findings; `wpsCheckCard()` shows them at the top of the editor only
when there are any, and Procedures marks such a WPS **Check**.

```
Table 5.5 tolerances   amps ±10% (22) · volts ±15% (23) · WFS ±10% (24) · travel ±25% (25)
                        — SAW/FCAW/GMAW only. A range lo–hi fits when (hi−lo)/2 ≤ t × mid.
                        gas flow (26) +50% / −25% about one value → hi ≤ 2 × lo.
must be stated         Table 5.5 items 1–21: process, positions, preheat, filler, diameter,
                        current/polarity, travel, weld type, PWHT; amps/volts/WFS on wire;
                        transfer on GMAW; gas and flow on GMAW/FCAW-G; groove, angle, root.
5.3                    base metal in Table 5.6 (the app only knows the few in METAL_GROUP,
                        so anything else is "check it's there").
5.8.1.1                vertical progression upward, except undercut repair and tubulars.
5.4.1.2 / 5.4.1.3      one-sided CJP needs steel backing, or backgouge and backweld.
Fig. 5.1 (FIG51)       B-U2a (SMAW), B-U2a-GF, B-L2a-S, B-U2-S rows and the square grooves.
                        R as detailed +1/16" −0, α +10° −0°; positions; T1 limits.
5.6.4                  FCAW-G gas = the classification gas: a C wire on mixed gas needs -M
                        or dual -C/-M (gasDesig). GMAW gas per Table 5.10.
Table 5.7              FCAW -2, -3, -10, -13, -14, -GS out; -11 only to 1/2".
Tables 5.1 / 5.3 / 5.4 electrode diameter limits by position and thickness.
5.5.1, 5.5.4           GMAW-S isn't prequalified; GMAW/FCAW on CV.
Table 5.11 / 5.7.1     preheat category (A or B — the only ones photographed) and the minimum
                        for the thickest part; interpass must be stated.
```

Findings have a kind: **rule** (breaks Clause 5), **missing** (Table 5.5 says state it),
**info** (look in the book — never blocks). On a prequalified WPS a tapped tile that would
add a rule finding is **refused**: the toast says why, with **Use it anyway** (`wpsGuard`).
A typed value is kept, and the toast offers **Undo** (`wpsSnap`, taken on focus). Save
refuses while any rule or missing finding stands, with **Save it anyway**; such a WPS
prints marked DRAFT.

A range finding offers **Make it …**: the widest range Table 5.5 allows about the same
middle, rounded inward (`tolFix()`). 5.4.1.5 lets SMAW groove details (B-U2a, all
positions) be used for GMAW/FCAW, so the dual-shield starter's "All" positions stand —
B-U2a-GF itself is F, V, OH only, and a WPS that names it in All is told to call it B-U2a.
PQR-qualified WPSs are judged against their PQR (Clause 6), not this.

### Starter procedures

`starterWps()`: WPS-SMAW-38 (E7018 1/8", DCEP, CC) and WPS-FCAW-38 (E71T-1C .045",
75/25, DCEP, CV; 170–200 A, 22–25 V, 270–330 ipm, 6–9 ipm travel — inside Table 5.5), both 3/8" A36 plate, single V, 45°, 1/4" root, steel backing, B-U2a,
uphill. `addStarters()` puts them in the library once (flag `wq.local.starters`) on first
run (flag "2"; `fixStarters()` brings a stored first-version starter's too-wide ranges in
line, touching only values nobody changed); deleted ones stay deleted, and Procedures offers to put them back. They carry
`starter:true` and a note to check them against the shop's own WPS — starting points,
not qualified procedures.

### Wire feed speed → amps

On CV the welder sets wire feed speed; amps follow it. For GMAW / FCAW-G / FCAW-S the
record screen asks **Wire feed speed (ipm)** and fills **Amps** from `AMP_CHART`: [ipm, amps]
points per process and wire diameter, read off typical carbon-steel wire charts at normal
stickout, interpolated straight-line and rounded to 5 A (`ampsFromWfs()`). It is marked
"≈ from wire speed" with a note that brand, stickout and gas move it 10–20%. Typing amps
takes over (`w.ampsAuto=false`); clearing the box hands it back to the chart. A wire size
with no chart says to type the amps from the machine. Stick and TIG keep a plain Amps box.

### Who enters what

The welder is only asked things the inspector can't already know: position, thickness,
base metal, filler, diameter, gas, flow. Amps, volts, polarity and preheat are procedure
variables — read off the machine by the inspector while witnessing, on the record screen.

Everything on the welder's side after the name field is tap-only.

### Invoices

Home → **Invoices** (also on each company's screen). Table `invoices`, in backups like
the rest. An invoice: `no` (`YYYY-NNN`, next after the year's highest), `date`, `terms`
(Due on receipt / Net 15/30/45; `dueDate()` is computed, never stored), `status`
(Unpaid / Paid + `paidDate`), bill-to (`coId`, `billName`, `billContact`, `billEmail`,
`billPhone`, `billAddress` via address prefix `ba`), `project` (job/PO), `lines`
(`{svc, desc, qty, rate, recId?}`), `taxRate` (%), `notes`.

- Picking a company runs `fillBillTo()`: contact, email, phone, and the company's mailing
  address (`billAddress`, new on the company form with `email`), else its letterhead address.
  Saving an invoice fills a company's missing email/address/contact from it.
- `SERVICES` are the tap-to-add lines. Each starts at `CFG.rate_<svc>`; saving an invoice
  stores each line's rate back as that service's rate (Settings → Invoices shows them).
- "Their tests not billed yet": finished records for the company on no other invoice
  (`unbilledRecs()`, keyed by `recId` on lines). `recLine()` writes the welder, position,
  process, date and result into the line and picks the service from the result.
- `invoicePdf()` is its own layout (not a form copy): shop letterhead from Settings
  (logo, name, address, phone, `CFG.email`), INVOICE block, bill-to, lines (autotable,
  rows never split), totals, PAID box when paid, `CFG.payTo` as "How to pay", note, footer.
- Preview and email saves first. The preview gets an **Email it** button (`emailPdf()`):
  on a phone the share sheet with the PDF plus subject/body (`invEmail()`), and the client's
  address is copied to paste in To — iOS can't give Mail a recipient and an attachment at
  once. On a computer the PDF downloads and a `mailto:` opens.

---

## 6. Gotchas, all learned the hard way

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

**Phone and address fields format themselves.** Every `type="tel"` input runs
`reformat(t, e, fmtPhone)` on input: 801-555-0142, a leading 1 dropped, extra digits as
" x123"; the caret goes back after the same number of digits, and backspacing over a dash
deletes the digit before it (otherwise the dash comes straight back). Phones stored
before this print through `prPhone()`, which only reshapes a value that is clearly a
number. Addresses are street / city / state / ZIP fields (`addrFields(prefix, label)`),
kept on the draft under a prefix (`a` settings, `lha` a client's letterhead, `ja` an
inspection's job site); `addrCompose()` writes the one-line forms the PDFs print
("1680 W 1600 S, Springville, UT 84663") into the old fields (`ADDR` says which), and
`parseAddress()` splits an older one-line address into parts the first time a form
opens. ZIP formats as 84663 or 84663-1234.

**iOS date inputs have a built-in minimum width.** In a two-up `.row` the Date box pushed
into the field beside it on the WPS editor. Fixed with `min-width:0` on row children and
`-webkit-appearance:none` on `input[type=date]`; Chrome never showed it.

**Phones hold on to an old copy.** GitHub Pages sends `Cache-Control: max-age=600`, and
an iPhone home-screen app can keep its copy past that. `checkForUpdate()` runs 1.5 s after
boot and whenever the app returns to the front: it fetches the page with
`cache:"no-store"`, reads `VERSION` out of it, and if it is newer (`verNum()` orders
"2026-11-21.11" after ".9") shows a toast with **Update** that stays up; Update refetches
with `cache:"reload"` and navigates to `?u=<time>` (stripped from the address at boot). It
never runs on a welder's ticket. **Bump `VERSION` on every push** — it is what the check
compares.

**Shell heredocs eat backslashes** on this machine (Git Bash). Edit scripts that carry
`\n` or `\'` must be written to a file, not piped in.

**Testing on one machine.** Inspector and welder share localStorage when you open both
links in the same browser. Welder mode overrides `CFG` in memory only and never saves it.

---

## 7. Known limits

- **One phone per inspector.** Nothing syncs. A coworker with their own company just
  installs it on their own phone; their data never touches yours.
- **Backups are manual.** Lose the phone without an export and the records are gone.
- **Continuity is what you log.** The app knows the test dates and the dates you tap
  "Welded today" on the Welders screen; it can't know what the welder did elsewhere.
- **No photos.** The WPQR has the photo box; nothing fills it.
- **Only D1.1 ranges are drafted.** D1.3 / D1.4 records print blank ranges.
- **Inspection reports have no photos and no per-item sketches.**
- **No archiving of the PDF.** It goes to the share sheet and that's the copy.
- **The welder has to text the link back.** Until they do, the inspector has nothing.

---

## 8. Where it was going next

1. **Continuity reminders** — the Welders screen exists (6.2.3.1); a nudge before a lapse is next.
2. **Trim the option lists** to what the shops actually stock.
3. **Multi-process tickets** for combo qualifications.
4. **Custom domain** for the hosted app.
5. **A designed form as the PDF template.** The plan: the inspector lays the WPQR / WPS
   out in Sheets, exports a blank PDF, and the app fills values into that PDF at
   measured coordinates (pdf-lib) instead of redrawing the form — pixel-exact to the
   design, with the logo box and letterhead lines left blank for each org to fill from
   Settings.

---

## 9. Design

**The app icon** is drawn by `tools/make_icon.py` (Pillow): a single-V joint in section
with a gold bead and an arc-blue spark on the dark steel gradient, drawn at 4096 px and
shrunk with Lanczos to `icon-512.png`, `icon-192.png`, `apple-touch-icon.png` (180, what
iOS uses for the home screen) and `favicon-32.png`. Full-bleed square, no rounded corners
baked in (iOS and Android round them), everything inside the middle 80% for Android's
maskable crop. Run `python tools/make_icon.py .` from the repo root to redraw.
iOS never refreshes the icon of an app already on the home screen.


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
