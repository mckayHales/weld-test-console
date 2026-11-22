# WQTR Requirements Checklist: AWS D1.1/D1.1M:2025

**Status:** Step 2, WQTRs. Usable now. Section 8 lists the remaining minor gaps.

**Built from these uploaded pages**
- Scan 2: pp. 128–129, 137–141, 160–162, 165–168, 296–299, 313 and 317–318
- Scan 3: pp. 132–134, 182–189, 226–228 and 342–346
- Scans 4–6: pp. 208, 215, 219, 246–247, 259, 300, 320 and 337–338

**Conventions**
- Everything under "CODE" comes from those pages and is paraphrased, with its clause, table or figure number.
- Anything marked **BP** is a best-practice suggestion, not a code requirement.
- **[VERIFY]** marks a reading that is uncertain because of the photo or the print.
- **[GAP]** marks a requirement that depends on a page not yet uploaded.
- McKay's handwritten corrections in the book are noted as his. They are not treated as code text.

---

## 1. Required WQTR content

### CODE

| # | Item | Requirement | Ref |
|---|---|---|---|
| 1.1 | Record identity | The record is the Welding Performance Qualification Record (WPQR). It serves as **the Contractor's certification of qualification**. | 6.20 |
| 1.2 | Essential variables | The WPQR must list all applicable essential variables of Table 6.13. Section 2 below covers them. | 6.20, Table 6.13 |
| 1.3 | Responsible party | The manufacturer or Contractor is responsible for qualifying its welders, operators and tack welders. This holds even when an independent testing agency does the testing. | 6.2.2.2 |
| 1.4 | WPS followed | Welding personnel must follow a WPS that applies to the performance test. | 6.17 |
| 1.5 | Records kept | The manufacturer or Contractor keeps the test records and makes them available to those authorized to examine them. | 6.3.3 |
| 1.6 | Inspector's records | The Inspector keeps a record of the qualifications of all welders, welding operators and tack welders. | 8.5.5 |
| 1.7 | Code edition | New qualifications must use the current edition unless the contract specifies an earlier one. Properly met earlier-edition qualifications (D1.1, D1.0, D2.0) remain valid. | 6.3.1 |
| 1.8 | Earlier or other qualifications | Properly documented previous performance qualifications are acceptable with the Engineer's approval. Qualification to other standards is the Engineer's call. | 6.2.2.1 |
| 1.9 | Personnel type | The record must say whether this is a welder, welding operator or tack welder. Different essential variables and ranges apply to each. | 6.2, Table 6.13 |
| 1.10 | Forms | Annex J forms are suggested, not required. | 6.20 |

### BP
- Record the following on the WQTR:
  - the WPS number
  - the test date
  - the coupon or joint detail and figure number
  - the base metal spec
  - the filler classification and diameter
  - the shielding gas
  - the testing agency
  - the test lab report number
  - the CWI name and number
  - the Contractor's certifying signature
- Most of these are not essential variables under Table 6.13. They make the record traceable.
- When an outside company's welder tests with McKay's inspection company, that company is "the Contractor" under 1.1 and 1.3. The CWI stamp verifies the test. The Contractor still certifies the qualification.

---

## 2. Essential variables: changes that require requalification (Table 6.13, 6.21)

W = welder, WO = welding operator, TW = tack welder.

| # | Change | W | WO | TW |
|---|---|---|---|---|
| 1 | To a process not qualified. **GMAW-S counts as a separate process.** | X | X | X |
| 2 | To a SMAW electrode with a **higher F-number** than qualified (Table 6.14) | X | — | X |
| 3 | To a position not qualified | X | X | X |
| 4 | To a diameter (Table 10.12) or thickness not qualified | X | X | — **[VERIFY]** |
| 5 | To a vertical progression not qualified (uphill or downhill) | X | — | — |
| 6 | Omission of backing on single-sided welds | X | X | — |
| 7 | To multiple electrodes. The reverse change does not require requalification. ESW/EGW excepted. | — | X | — |

- **[VERIFY]** The photo of the tack welder column is skewed. Rows 1–3 read X, and rows 4–7 appear shaded. Confirm against the book.
- Footnote a: a welder qualified for SAW, GMAW, FCAW or GTAW is also considered a qualified welding operator in the same process, subject to the welder's limits.

**Table 6.14, Electrode Classification Groups (F-numbers)**
- F4: EXX15, EXX16, EXX18, EXX48, EXX15-X, EXX16-X, EXX18-X
- F3: EXX10, EXX11, EXX10-X, EXX11-X
- F2: EXX12, EXX13, EXX14, EXX13-X
- F1: EXX20, EXX24, EXX27, EXX28, EXX20-X, EXX27-X

**Derived rule** (from row 2): a SMAW test qualifies the tested F-number and every lower F-number. For example, a test with F4 qualifies F4 through F1.

**What Table 6.13 does NOT list as a welder essential variable:**
- base metal
- filler classification, other than SMAW F-number
- shielding gas
- filler diameter

These can be recorded on the WQTR. They should not be printed as qualification limits.

---

## 3. Qualified ranges

### 3a. Weld types qualified (6.17.5, 6.19)

| Test | Qualifies |
|---|---|
| CJP groove, nontubular | CJP groove, PJP groove, fillet, plug, slot, tack |
| PJP groove, nontubular | PJP groove, fillet, plug, slot, tack |
| Fillet, nontubular | fillet, plug, slot, tack |
| Plug/slot (Fig. 6.19) | plug, slot, tack |
| Tack welder only (fillet break test) | Tack welds on all joint types **except** CJP groove welded from one side without backing, in the process and position tested. Fully qualified welders must make those excluded tack welds. (6.17.5.5) |
| Tubular CJP groove | Also qualifies all tubular PJP groove (10.19) |
| Longseam welds, or plate welds parallel to the tube centerline | Need no tubular qualification. Qualify these under Clause 6. (10.17) |

### 3b. Backing (6.22, Table 6.13 row 6)
- A test **without backing** qualifies production joints with or without backing or backgouging.
- A test **with steel backing** also qualifies joints that are backgouged and welded from the second side.
- It does not qualify single-sided joints without backing. That is row 6.

### 3c. Positions: plate tests (Table 6.11, 6.17.1.1)

| Plate test | Plate CJP | Plate PJP | Plate fillet |
|---|---|---|---|
| 1G | F | F | F, H |
| 2G | F, H | F, H | F, H |
| 3G | F, H, V | F, H, V | F, H, V |
| 4G | F, OH | F, OH | F, H, OH |
| 3G + 4G | All | All | All |
| 1F | — | — | F |
| 2F | — | — | F, H |
| 3F | — | — | F, H, V |
| 4F | — | — | F, H, OH |
| 3F + 4F | — | — | All |
| Plug | Plug, slot and tack welding, only in the positions tested | | |

**Pipe and box-tube work from a plate groove test**
- **Pipe butt joints:** CJP and PJP use the same position pattern as plate. CJP and PJP pipe butt joints are qualified **only for pipe ≥ 24 in [600 mm] diameter with backing, backgouging or both** (footnote b).
- **Pipe T-, Y- and K-connections:** CJP is **not qualified**. PJP and fillet follow the plate pattern. PJP is not qualified for groove angles below 30° (footnote e).
- **Box tube butt joints:** CJP and PJP follow the plate pattern. Box CJP butt is not qualified for single-sided joints without backing, or two-sided joints without backgouging (footnote f).
- **Box T-, Y- and K-connections:** CJP is not qualified.

**Plate fillet tests**
- They qualify fillet welds on plate, pipe and box. The position pattern is F / F,H / F,H,V / F,H,OH / All.

### 3d. Positions: pipe and box tube tests (Table 10.8, 10.16.1)

**Rows that read clearly**

| Test | Plate CJP / PJP / fillet | Pipe butt CJP / PJP | Pipe TYK CJP | Pipe TYK PJP / fillet |
|---|---|---|---|---|
| 1G rotated | F / F / F,H (fn h) | F / F | — | F / F,H |
| 2G | F,H across | F,H | — | F,H |
| 5G | F,V,OH across | F,V,OH | — | F,V,OH |
| 6G | All | All | — **[VERIFY]** | All (PJP fn i) |
| 2G + 5G | All | All | All, fn j: **WPS only, does not qualify welders** | All |
| 6GR, pipe, box, or pipe and box | All (plate CJP fn i **[VERIFY]**) | All (CJP fn k) | All | All |
| 1F rot / 2F / 2F rot / 4F / 5F | Fillet only: F / F,H / F,H / F,H,OH / All | | | |

**Footnotes that matter for welders**
- **fn b:** Production butt joints without backing or backgouging must be qualified on the Fig. 10.17(A) detail. Joints with backing or backgouging may use either 10.17(A) or 10.17(B).
- **fn c:** A box-tube test (Fig. 10.19 or 10.20) also qualifies pipe ≥ 24 in.
- **fn d:** Not qualified for dihedral angles under 30° (see 10.14.4.2 and 10.18.1).
- **fn e:** 6GR requires pipe or box tubing.
- **fn f:** A Fig. 10.19 box test needs its corner macros, either from the coupon corners or from a separate Fig. 10.21 joint.
- **fn g:** A groove test also qualifies plug and slot welds in the positions tested.
- **fn h:** 1G rotated qualifies WPSs for flat only.
- **fn k [VERIFY]:** This footnote reads as "Not qualified for joints welded in 2G, 5G and 6G from one side without backing, or welded from two sides without backgouging." It is attached to the CJP butt cells of the 6GR rows. That meaning is surprising for a 6GR test. Confirm the superscript placement in the book.

**Print problems in Table 10.8 (McKay's handwritten corrections)**
- The pipe butt-joint first column header is printed "PJP^b,c". McKay corrected it to CJP.
- He also edited the box T-, Y- and K-connection PJP and fillet cells in the 2G row: he struck "V, OH" and wrote "F, H".
- These look like misprints. Treat both as **[VERIFY]** until they are confirmed by an AWS erratum or interpretation.

### 3e. Thickness: plate tests (Table 6.12, 6.17.2)

| Test | Plate T | Specimens (VT per 6.10.1 on all) | Thickness qualified | Skewed-T dihedral |
|---|---|---|---|---|
| Groove (Fig. 6.21) | 3/8 in [10 mm] | 1 face + 1 root. fn b: a side bend may replace each. | 1/8 in [3] to 2T | 30° to unlimited |
| Groove | 3/8 < T < 1 in | 2 side | 1/8 in to 2T | 30° to unlimited |
| Groove | ≥ 1 in [25] | 2 side | 1/8 in to unlimited | 30° to unlimited |
| Plug (Fig. 6.19) | 3/8 in | 2 macroetch | 1/8 in to unlimited | — |
| Fillet Option 1 (Fig. 6.23) | 1/2 in [12] | 1 macro + 1 fillet break | 1/8 in to unlimited | 60° to 135° |
| Fillet Option 2 (Fig. 6.24) | 3/8 in | 2 root bend | 1/8 in to unlimited | 60° to 135° |
| Fillet Option 3 (Fig. 6.25), any diameter pipe | ≥ 1/8 in | 1 macro | 1/8 in to unlimited | 30° to unlimited |
| Fillet acute heel (Fig. 6.26) | 3/8 in | 3 macro | 1/8 in to unlimited | min tested to ≤30° |
| ESW/EGW groove (Fig. 6.22) | < 1-1/2 in | 2 side | 1/8 in to T | — |
| ESW/EGW groove (Fig. 6.22) | 1-1/2 in [38] | 2 side | 1/8 in to unlimited | — |

**Footnotes**
- **fn a:** RT may replace the bend tests. It cites "6.17.1.1". The RT substitution clause is actually 6.18.1.1. See cross-reference issue 4 in section 7.
- **fn c:** The test also qualifies any fillet or PJP groove, plug or slot weld on any thickness of plate, pipe or tubing.
- **fn d:** Unlimited for groove welds in skewed joints.
- **[VERIFY]** The superscripts on the "2T" cells look like "c,d", but the photo is not sharp enough to be sure.
- **[VERIFY]** The ESW/EGW rows show "Footnote c" in the VT column, which doesn't fit footnote c's wording.

**Other thickness rules**
- **Tack welders:** qualified for ≥ 1/8 in (6.17.2.2). On tubulars: ≥ 1/8 in and all diameters, but not CJP butt joints or T-, Y- and K-connections welded from one side (10.16.2).
- **Requalification after a lapse:** a 3/8 in test may be used to qualify any thickness ≥ 1/8 in (6.25.1.3).
- **Corner and T-joint groove qualification:** test a butt joint with the same groove configuration. The groove depth need not exceed 1 in (6.17.4).

### 3f. Thickness and diameter: tubular tests (Table 10.12, 10.16.1)

**CJP groove butt joints**

| Test pipe/box size | Test t | 1G/2G specimens | 5G/6G/6GR specimens | Size qualified | Thickness qualified |
|---|---|---|---|---|---|
| ≤ 4 in | ≥ 1/8 in | 1 face, 1 root (fn e) | 2 face, 2 root (fn e) | 3/4 in to 4 in pipe; unlimited box | 1/8 to 3/4 in |
| > 4 in | ≤ 3/8 in | same | same | fn f to unlimited | 1/8 to 3/4 in |
| > 4 in | > 3/8 in | 2 side | 4 side | fn f to unlimited | 1/8 in to unlimited |

**CJP T-, Y- and K-connections**

| Test | t | Specimens | Size qualified (min / max) | Thickness min | Dihedral |
|---|---|---|---|---|---|
| Pipe, Fig. 10.19, > 4 in OD | ≥ 1/2 in | 4 side | pipe 4 / unlimited | 3/16 in | 30°+ |
| Pipe, Fig. 10.20, ≤ 4 in OD | ≥ 3/16 in | fn h (2 root + 2 face) | pipe 3/4 / 4 | 1/8 in | 30°+ |
| Box, Fig. 10.19, > 4 in | ≥ 1/2 in | 4 side + 4 macro (fn i) | pipe 24, box 4 / unlimited | 3/16 in | 30°+ |
| Box, Fig. 10.20, ≤ 4 in | ≥ 3/16 in | fn h + 4 macro | **[VERIFY]** see below; box 3/4 / unlimited | 1/8 in | 30°+ |

- **[VERIFY] Box Fig. 10.20 row:** as printed, pipe min = 24 in [610] and pipe max = 4 in [100]. The minimum is larger than the maximum. McKay hand-swapped these to 4 / 24 in both the inch and mm tables. This is likely an erratum. Don't encode either reading in Weld Sync until it is confirmed.
- Box-groove corner macros are sized to match the pipe-groove test.

**Fillet welds**

| Test | t | Specimens | Size qualified | Thickness | Dihedral |
|---|---|---|---|---|---|
| 5G groove | ≥ 1/8 in | 2 root + 2 face (fn e) | fn f to unlimited | 1/8 in to unlimited (fn c) | 30°+ |
| Fillet Option 1 (Fig. 6.23, fn j) | ≥ 1/2 in | 1 fillet break + 1 macro | 24 in to unlimited | 1/8 in to unlimited | 60°+ |
| Fillet Option 2 (Fig. 6.24, fn j) | 3/8 in | 2 root bend | 24 in to unlimited | 1/8 in to unlimited | 60°+ |
| Fillet Option 3 (Fig. 6.25) | ≥ 1/8 in | 1 macro | D (test diameter) to unlimited | 1/8 in to unlimited | 30°+ |

**Footnotes**
- **fn b:** All welds are visually inspected (6.23.1).
- **fn c:** The test also qualifies any fillet or PJP weld size on any thickness.
- **fn d:** RT may replace the bends (6.18.1.1).
- **fn e:** For t ≤ 3/8 in, a side bend may replace each face and root bend.
- **fn f:** The minimum pipe size qualified is the larger of 1/2 the test diameter or 4 in.
- **fn g:** For dihedral angles under 30°, see 10.18.1. The 6GR test is still not required.
- **fn i:** The macro is taken at the corners per Fig. 10.21.
- **fn j:** Two plates are required, one welded in 3F and one in 4F.
- **[VERIFY]** Footnote a reads "See Table 10.11 for appropriate groove details" in the mm table. The inch table has a handwritten change. Table 10.11 is a WPS fillet table, so the intended reference is unclear.

**Tubular test joints by joint type (10.18)**
- With backing or backgouging: Fig. 10.17(A) with backgouging, or 10.17(B) with backing.
- Without backing: 10.17(A).
- Box tubing with backing: 10.17(B), in pipe of any diameter, plate, or box.
- T-, Y- and K-connections without backing in pipe: Fig. 10.19 for > 4 in, Fig. 10.20 for ≤ 4 in.
- Box T-, Y- and K-connections: 10.19 plus a 10.21 corner macro, or 10.19 with macros from the 10.21 locations.
- Dihedral angle < 30°: add the 10.14.4.2 test to the 6GR test (10.18.1).

**Tubular positions (Figs. 10.12 and 10.13)**
- 1G rotated: ±15°, filler deposited at or near the top
- 2G: vertical tube, ±15°
- 5G: horizontal fixed, ±15°
- 6G: 45° ± 5° fixed
- 6GR: 45° ± 5° with a restriction ring
- Fillet: 1F rotated at 45°, 2F fixed, 2FR rotated, 4F fixed, 5F fixed

---

## 4. Test coupons (figure dimensions)

All dimensions are minimums unless stated otherwise.

### 4a. Groove plate (Fig. 6.21; 6.22.1)

| | Welder, with backing | Welder, without backing | Operator, with backing | Operator, without backing |
|---|---|---|---|---|
| Groove angle α | 45° | 60° | 20° | 60° |
| Root opening R | 1/4 in [6] | 3/16 in [5] | 5/8 in [16] | 3/16 in [5] |
| Coupon length L | 7 in [180] for root and face bends; 5 in [130] for side bends | same | 15 in [380] | 15 in [380] |
| Coupon width W | As required by test equipment | | 12 in [300] | 12 in [300] |

- Note 1: α and R are **maximums** unless a prequalified joint detail is used. All other dimensions are minimums. Prequalified details are in Fig. 5.1; see `wps-prequalified-checklist.md`.
- Bend specimens are taken next to the coupon centerline, with discard at each end. For the specimen offsets see the figure: about 1 in for a welder and about 2 in for an operator.
- **[VERIFY]** the specimen offsets: the dimension callouts are small in the scan.
- Other requirements (6.22.1):
  - single-sided joint detail
  - no tack welds in the test area if the coupon will be RT'd
  - steel backing 1/4 to 3/8 in thick, at least 3 in wide (not removed for RT) or 1 in wide (removed for RT)
- Rolling direction is recommended, not required.

### 4b. Other plate coupons

| Fig. | Coupon | Key dimensions and notes |
|---|---|---|
| 6.19 | Plug/slot | 3/8 in plate, 3/4 in hole, backing ≥ 3/8 in. L1 = 2 in (welder) or 3 in (operator); L2 = 3 in (welder) or 5 in (operator). Macroetch both interior faces. |
| 6.20 | Tack welder rupture | Force applied to the stem until the tack weld ruptures |
| 6.22 | ESW/EGW operator butt | Total length ≥ 17 in [430]. Plate width 4T with 6 in min each side. Two side bends, 4 in each side of centerline. Root opening per WPS; T per 6.22.2. |
| 6.23 | Fillet Option 1 | 1/2 in min plates, 4 in min stem and base. Single-pass 1/4 in min fillet. **Stop and restart near the center.** L = 8 in [200] (welder) or 15 in [380] (operator). One 6 in min break specimen, plus a macro from either end. |
| 6.24 | Fillet Option 2 | 3/8 in plates. Single-pass fillets no larger than 3/8 in; the portion between the fillets may be welded in any position. Backing ≥ 3/8 × 2 in (3/8 × 3 in if RT), in intimate contact. Weld reinforcement and backing removed flush (7.23.3.1: ≤ 1/32 in reduction, ≤ 1/32 in remaining). Thermal cutting is allowed if ≥ 1/8 in is left for machining or grinding. Two root bends, 1-1/2 in wide; edge radius ≤ 1/8 in. L = 7 in [175] (welder) or 15 in [380] (operator). |
| 6.25 | Fillet Option 3 | Pipe on plate. Single-pass 5/16 in fillet, with the start and stop shown. Macro one face of the cut. The pipe wall must be thick enough to prevent melt-through. |
| 6.26 | Fillet acute heel | 3/8 in min plates, 5 in min, 1 in discarded at each end. Three macroetch specimens. Initial backup-weld passes are discounted until the groove width W is enough for a sound weld. |
| 6.27 | Tack welder specimen | 1/2 in T, 4 in × 4 in. Tack weld about 2 in long (6.18.2: ≤ 1/4 in size). |

### 4c. Tubular coupons

| Fig. | Coupon | Key dimensions and notes |
|---|---|---|
| 10.17(A) | Butt joint without backing | Root opening ≤ 1/8 in and root face ≤ 1/8 in. α = production groove angle (60° recommended). |
| 10.17(B) | Butt joint with backing | Root opening = production joint root opening. α = production groove angle (60° recommended). |
| 10.18 | Acute angle heel (10.14.4.2) | 8 in min length, 1 in discarded each end. 5/8 in and 1 in min plates. Set at 15° or the minimum angle to be qualified. t_w per Table 10.7. |
| 10.19 | T-, Y- and K-connection test, OD > 4 in, without backing | 37-1/2° bevel, 0–1/16 in root face, wall ≥ 1/2 in, restriction ring, 6 in min lengths |
| 10.20 | T-, Y- and K-connection test, OD ≤ 4 in, without backing | Same layout, wall ≥ 3/16 in |
| 10.21 | Box corner macro | Four corner macro locations. When used to supplement a pipe test, the box thickness and D must match the 10.19 or 10.20 test. |
| 10.22 | Specimen locations | **1G/2G:** wall ≤ 3/8 in, 1 face + 1 root; wall > 3/8 in, 2 side. **5G/6G/6GR:** wall ≤ 3/8 in, 2 face + 2 root; wall > 3/8 in, 4 side. Box: root or side and face or side at the locations shown. Note a: for a 3/8 in wall, a side bend may replace each face and root bend. |

---

## 5. Testing and acceptance criteria

| # | Test | Requirement | Ref |
|---|---|---|---|
| 5.1 | **Visual: groove welds (coupon)** | <ul><li>No cracks of any size.</li><li>All craters filled to the full cross section.</li><li>**Reinforcement ≤ 1/8 in [3]**, and complete fusion.</li><li>Profile per Fig. 7.4: reinforcement R ≤ R_max is acceptable and R > R_max is unacceptable. An underfilled groove is unacceptable. For welder coupons, R_max is the 1/8 in set by 6.10.1.1(3); Table 7.9 Schedule A gives the same 1/8 in for t ≤ 1 in.</li><li>Undercut ≤ 1/32 in [1].</li><li>CJP root: no cracks, incomplete fusion or inadequate penetration.</li><li>CJP from one side without backing: root concavity ≤ 1/16 in [2] (provided the total weld thickness ≥ base metal), and melt-through ≤ 1/8 in [3].</li></ul> | 6.23.1 → 6.10.1.1, Fig. 7.4(A), Table 7.9 |
| 5.2 | **Visual: fillet welds (coupon)** | <ul><li>No cracks.</li><li>Craters filled.</li><li>Legs ≥ the required size.</li><li>Profile per Fig. 7.4, with convexity per Table 7.9 Schedule C: 1/16 in for W ≤ 5/16 in; 1/8 in for 5/16 < W < 1 in; 3/16 in for W ≥ 1 in.</li><li>Undercut ≤ 1/32 in.</li></ul> | 6.10.1.2, Fig. 7.4, Tables 7.8/7.9 |
| 5.3 | Bend specimens, preparation | Transverse face and root bends per Fig. 6.8; side bends per Fig. 6.9. | 6.10.3.1 [GAP: pp. 171–172] |
| 5.4 | Bend test method | <ul><li>Bend in a jig per Figs. 6.11–6.13, or substantially equal, without exceeding the maximum bend radius.</li><li>Face specimens: weld face toward the gap. Root specimens and fillet-soundness specimens: root toward the gap. Side specimens: the side with the greater discontinuity toward the gap.</li><li>Bend to a U shape, with the weld and HAZ fully within the bent portion.</li><li>Wraparound jig: clamp one end and roll 180°.</li></ul> | 6.10.3.1 [GAP: pp. 174–176] |
| 5.5 | **Bend acceptance** | Examine the convex surface. Reject if it shows: <ul><li>any discontinuity > 1/8 in [3] in any direction</li><li>a sum > 3/8 in [10] for discontinuities > 1/32 in and ≤ 1/8 in</li><li>a corner crack > 1/4 in [6], or > 1/8 in if the crack comes from slag or another fusion-type discontinuity</li></ul> A corner crack > 1/4 in with **no** slag or fusion cause: disregard the specimen and test a replacement from the same weldment. | 6.23.5 → 6.10.3.3 |
| 5.6 | Longitudinal bends | May be used instead of transverse bends when the material combinations differ markedly in bending properties. | 6.10.3.2 |
| 5.7 | RT in lieu of bends | Allowed for plate or pipe, **except GMAW-S**. | 6.18.1.1 |
| 5.8 | RT technique | <ul><li>Reinforcement need not be ground unless it would obscure defects.</li><li>If the backing is removed, grind the root flush per 7.23.3.1 (≤ 1/32 in reduction, ≤ 1/32 in remaining).</li><li>Procedure per Clause 8 Part E, and Clause 10 Part F for tubulars.</li><li>Exclude 1-1/4 in at each end for welders, 3 in for operators.</li><li>Tubulars: 5G/6G/6GR coupons from top centerline to bottom centerline on either side; pipe under 4 in, 100% RT (10.21.2).</li></ul> | 6.23.3, 6.23.3.1, 10.21.2 |
| 5.9 | **RT acceptance (welder/operator)** | 8.12.2 applies **except 8.12.2.2**. In practice this means the **cyclically loaded, tension** criteria (8.12.2.1, Fig. 8.2) plus 8.12.2.3. **Fig. 8.2** is a chart of weld size S against the maximum discontinuity size B and minimum clearance C. Project S across to the B line to get the maximum size, then project down from B to C for clearance. B runs from 1/16 in at the smallest sizes to **1/2 in max**; the limits for 1-1/2 in S apply to all larger welds. Reject for: <ul><li>any crack</li><li>discontinuities over the Fig. 8.2 B for the weld size</li><li>discontinuities closer than the Fig. 8.2 C</li><li>at intersections or free edges: Fig. 8.2 Cases I–IV</li><li>rounded clusters over the maximum single size, or within 3× clearance</li><li>a sum of discontinuities < 3/32 in exceeding the lesser of 2S/3 or 3/8 in per linear inch</li><li>in-line discontinuities summing > S in 6S</li><li>discontinuities < 1/16 in summing > 3/8 in in any linear inch</li></ul> | 6.23.3.2, 8.12.2.1, 8.12.2.3, Fig. 8.2 [GAP: legend; Cases I–IV] |
| 5.10 | RT definitions | Elongated: length > 3× width. Rounded: length ≤ 3× width; may be irregular or have tails. | 8.12 |
| 5.11 | Operator alternative | RT of the first 15 in [380] of a production groove weld. Thickness range per Table 6.12. | 6.18.1.1 |
| 5.12 | Macroetch (welder) | <ul><li>Fillet: fusion to the root but not necessarily beyond; leg ≥ the specified size.</li><li>Plug: no cracks; thorough fusion to the backing and hole sides; visible slag ≤ 1/4 in total.</li></ul> | 6.23.2.2 |
| 5.13 | **Fillet weld break** | <ul><li>**Before breaking:** visually examine the full length. The weld must be reasonably uniform; free of overlap and cracks; undercut not beyond 8.9 / Table 8.1; no surface porosity.</li><li>**Break:** at least one start/stop must fall in the specimen; load with the root in tension.</li><li>**Pass if** the specimen bends flat, **or** the fracture shows complete fusion to the root, no inclusion or porosity > 3/32 in, and a sum ≤ 3/8 in in 6 in.</li></ul> **Undercut in Table 8.1 row 7:** <ul><li>**Statically loaded, material < 1 in:** ≤ 1/32 in deep. Exceptions: welds ≥ 12 in may have up to 1/16 in for an accumulated 2 in in any 12 in. For welds < 12 in, see the **[VERIFY]** note in 5a.</li><li>**Statically loaded, material ≥ 1 in:** ≤ 1/16 in.</li><li>**Cyclically loaded:** 0.01 in where transverse to computed tension in primary members; 1/32 in otherwise.</li></ul> | 6.23.4, 6.23.4.1, 8.9, Table 8.1(7) |
| 5.14 | Tack welder | <ul><li>Make a ≤ 1/4 in tack about 2 in long (Fig. 6.27) and rupture it (Fig. 6.20).</li><li>Visual: uniform; no overlap or cracks; undercut ≤ 1/32 in; no surface porosity.</li><li>Fracture: fusion to the root, no incomplete fusion, no inclusion or porosity > 3/32 in.</li></ul> | 6.18.2, 6.24 |
| 5.15 | Tack welder positions | One test plate in each position to be tack welded | 6.17.1.2 |
| 5.16 | Tubular box T-, Y- and K-connection macros | Four corner macros. Acceptance per Clause 6 and 10.14.4.1(2): <ul><li>no cracks in the backup weld</li><li>complete fusion</li><li>weld size per detail</li><li>undercut per Table 10.14 row (7)(B): 0.01 in transverse to tension in primary members, 1/32 in otherwise</li><li>porosity ≥ 1/32 in accumulating ≤ 1/4 in</li><li>slag ≤ 1/4 in</li></ul> | 10.21.1, Table 10.14 |
| 5.17 | Tubular RT | Pipe ≥ 4 in: at least half the perimeter, including all positions welded. See 5.8 for the rest. | 10.21.2 |
| 5.18 | Positions | Classify F/H/V/OH by the axis and face-rotation ranges in Fig. 6.1 (groove) and Fig. 6.2 (fillet). Test assemblies: Figs. 6.3, 6.4, 10.12 and 10.13. | 6.3.4, 10.11.1 |
| 5.19 | Inspector marking | The inspector identifies accepted parts or joints by mark or recording method. Die stamping cyclically loaded members needs the Engineer's approval. | 8.5.4 |

### 5a. Undercut on the fillet break test: which limit applies

- 6.23.4.1 sends the pre-break visual to 8.9 and Table 8.1. Table 8.1 is split into statically and cyclically loaded **connections**. A test coupon is neither, so the uploaded pages don't say which column governs a coupon.
- **[VERIFY]** Within the statically loaded row, (7)(A)(1)(b) is printed as limiting the accumulated length of undercut **deeper than 1/16 in** to 0.16 × the weld length. That conflicts with the 1/16 in maximum in (a). McKay has marked this line. Whether it should read "deeper than 1/32 in" is unconfirmed, and it bears on the static option below.
- **BP:** use **1/32 in** for coupon fillets. It matches 6.10.1.2(5) (coupon fillet visual), 6.24.1 (tack welder) and the general cyclic limit. This is the inspector's call.

### 5b. Not for welders
- 6.10.5 (two additional specimens after a failed specimen) is the **WPS/PQR** retest rule. Welder retests follow 6.25 (section 6 below).
- Reduced-section tension tests (6.10.3.4–5) are also WPS-only. Table 6.12 lists no tension tests for welders.

### 5c. Inspector duties that touch WPQRs (Clause 8 Part A)
- The inspector verifies that production welding is by welders qualified per Clause 6 or 10, and that any required retest was passed before welding resumes (8.4.1).
- If work quality appears deficient, the inspector may require a simple test (e.g., a fillet break) or full requalification (8.4.2).

---

## 6. Period of effectiveness and retest

**Period of effectiveness**
- A welder or operator qualification stays in effect **indefinitely** unless either of these happens:
  - they have not welded with that process for more than 6 months, or
  - there is a specific reason to question their ability.
- Tack welders: indefinite in the qualified positions and process, unless there is a specific reason to question them.
- Refs: 6.2.3.1, 6.2.3.2.

**Retest after a failure (6.25.1)**
- Immediate retest: two welds of each type and position failed, and every specimen must pass.
- Or a complete retest after documented further training or practice.

**Requalification after a lapse (6.25.1.3)**
- A requalification test is required. A 3/8 in test may be used to qualify ≥ 1/8 in.

**Failed requalification retest (6.25.1.4)**
- No immediate retest is allowed. A retest is permitted only after training or practice.

**Tack welder retest (6.25.2)**
- One retest is allowed without training. After that, a complete retest following training or practice.

**BP**
- Show "last date welded with this process" or a 6-month continuity log, not an "expiration date". The code sets no fixed expiry.

---

## 7. Apparent cross-reference errors in the printed code

These are issues on the uploaded pages, several already marked by McKay. Before relying on any of them, check AWS errata or submit a technical inquiry (Annex T).

1. **6.17.3** cites 6.16.1 and 6.16.2. Positions and thicknesses are actually in 6.17.1 and 6.17.2 (McKay's correction).
2. **6.18.1.1** cites "bend tests described in 6.17.1(2)". There is no such item; it most likely means 6.18.1(2).
3. **6.22** cites Table 6.12 for positions. Positions are in Table 6.11 (McKay's correction).
4. **Table 6.12 fn a** cites 6.17.1.1 for RT substitution. The RT substitution clause is 6.18.1.1, and Table 10.12 fn d cites that correctly.
5. **10.16.1**, second paragraph, cites Table 10.8 for specimens, thickness and diameter. That content is in Table 10.12 (McKay's correction).
6. **Table 10.8** pipe butt column header is printed "PJP^b,c" where "CJP" is expected (McKay's correction).
7. **Table 10.12**, box Fig. 10.20 row: the pipe size minimum (24 in [610]) is larger than the maximum (4 in [100]) (McKay's swap).
8. **Table 10.8**, box T-, Y- and K-connection 2G row: cells hand-edited by McKay.
9. **Table 6.11 fn d** cites 6.22 and 10.19 for dihedral-angle restrictions. Neither clause covers dihedral angles. 10.14.4.2 and 10.18.1 do.
10. **6.18.1.2** says to prepare bend specimens per "Figures 6.9 or 6.10". Fig. 6.10 is the reduced-section *tension* specimen. Per 6.10.3.1 and the Table 6.12 headings, face and root bends are Fig. 6.8 and side bends are Fig. 6.9. This most likely should read 6.8 or 6.9.
11. **Table 8.1 (7)(A)(1)(b):** "undercut depth greater than 1/16 in" conflicts with the 1/16 in cap in (a). McKay has marked this line.
12. **Fig. 8.2 note 3** says "See Legend on page 253", but p. 253 is Table 8.8 (UT equipment).
13. **7.23** cites "Tables 8.1 or 10.15", and **7.23.1** cites "8.1, and 10.16". The tubular visual table is 10.14.
14. **Tables 5.1–5.4 exceptions** cite "5.6.2" for weathering steel. The correct clause is 5.6.3 (McKay's correction).

---

## 8. Remaining gaps (minor)

1. The legend for Figs. 8.1–8.3, plus the Cases I–IV pages. Only needed if you RT welder coupons.
2. **pp. 171–172 and 174–176:** bend specimen and jig figures. These affect lab practice, not WQTR content.
3. **Annex J:** the WQTR form, informative.

No base-metal table is needed for WQTRs, because base metal is not a welder essential variable under Table 6.13.
