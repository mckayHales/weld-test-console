# Document Review: Weld West, Nov 2026 (rev 2: WPS checked against Clause 5)

**Documents reviewed**
- WPS FCAW-38 Rev 0 (11/18/2026)
- WPQR "Quinn Morley 3G FCAW" (Std. Test No. 1)
- WPQR "Quinn Morley 4G FCAW" (Std. Test No. 2)
- Visual Inspection Report 2026-002, Ellison Barn

**Checked against:** the uploaded D1.1:2025 pages, using the checklists in this folder.

**Status key**
- **OK:** meets the uploaded code pages.
- **Missing:** required information is absent.
- **Incorrect:** conflicts with the code or with the document itself.
- **Verify:** can't be confirmed from the uploaded pages, or needs the inspector's call.

The inspector of record makes the final call on every item.

---

## A/B. WPQRs: Quinn Morley 3G and 4G

| Field | Document says | Code requires | Ref | Status |
|---|---|---|---|---|
| Certification | Signed by the CWI under "Authorized by". Contractor (Weld West) line unsigned. | The WPQR is the **Contractor's** certification | 6.20, 6.2.2.2 | **Missing** |
| Qualified To | "AWS D1.1 B-U2a" | Welders qualify to Clause 6 of the edition. B-U2a is a WPS joint. | 6.3.1, 6.17 | **Incorrect** |
| Test coupon | 3/8 in A36, single-V with backing, per WPS at 60° / 1/4 in | Fig. 6.21, welder with backing: α ≤ 45°, R ≤ 1/4 in, unless a prequalified detail is used. 60° / 1/4 in is not one (Fig. 5.1). | Fig. 6.21 note 1 | **Verify** the actual bevel |
| 3G positions | Groove F, H, V; fillet F, H, V | Table 6.11 | | OK |
| 4G positions | Groove F, OH; fillet F, H, OH | Table 6.11 | | OK |
| 3G + 4G | Not stated | Together they qualify **all** positions | Table 6.11 | **Missing** |
| Groove on pipe | "24 in Min" | ≥ 24 in with backing or backgouging only | Table 6.11 fn b | OK. Tie the condition to the cell. |
| Thickness, 3G | 1/8–3/4 in | 3/8 in test → 1/8 to 2T | Table 6.12 | OK |
| Thickness, 4G | "-" | Must be derived from the test thickness | Table 6.12 | **Missing** |
| Fillet thickness | 1/8 in min, unlimited | A groove test qualifies any fillet size and thickness | Table 6.12 fn c | OK |
| Weld types | Groove, fillet, plug, slot, PJP T-, Y- and K-connections | CJP qualifies CJP, PJP, fillet, plug, slot, tack | 6.17.5 | OK. Add tack. |
| Backing | With / "with, or with backgouge" | | 6.22 | OK |
| Progression | Vertical up | Essential variable | Table 6.13(5) | OK |
| Filler range "E7xT-xx", gas "75/25" | Printed as ranges | Not welder essential variables (only the SMAW F-number) | Table 6.13 | **Verify**: they read as limits |
| Tests | Visual, 1 root, 1 face | 3/8 in: visual plus 1 face and 1 root | Table 6.12 | OK |
| Criteria cited | "Clause 6, Part C" | 6.23.1 → 6.10.1; 6.23.5 → 6.10.3.3 | | **Verify** |

## C. WPS FCAW-38 Rev 0 (claimed prequalified, B-U2a)

**Bottom line:** as written, this WPS is **not prequalified**. Three items break it: the groove angle, the shielding gas against the electrode classification, and the "All" positions.

| Field | WPS says | Code requires | Ref | Status |
|---|---|---|---|---|
| Joint designation | B-U2a | For FCAW it is **B-U2a-GF** | Fig. 5.1 p. 87 | **Incorrect** |
| Groove angle / root opening | 60° / 1/4 in, steel backing | B-U2a-GF allows only 3/16 / 30°, 3/8 / 30°, or **1/4 / 45°**. As-detailed α tolerance is +10°/−0°, so 55° max. | Fig. 5.1, 5.4.1.1 | **Incorrect**: 45° |
| Positions | All | B-U2a-GF 1/4 / 45°: **F, V, OH** | Fig. 5.1 | **Incorrect** |
| Electrode vs. gas | E71T-1C on 75% Ar / 25% CO2. The caption says "E71T-1C/1M". | The gas must be the classification gas. Mixed gas needs an "-M" classification. | 5.6.4(1), (4) | **Incorrect** |
| Filler group | E71T-1C, A5.20 | Group I FCAW: E7XT-X, -XC, -XM | Table 5.7 | OK |
| Base metal | A36, Group I | A36 is Group I up to 3/4 in | Table 5.6 | OK |
| Thickness | CJP 1/8–3/4 in | Consistent with Group I and the 32 °F band | | OK |
| "With PWHT" thickness | 1/8–3/4 in | PWHT is None, so it should be blank | 5.9 | **Incorrect (internal)** |
| Preheat | 32 °F min | Category B, ≤ 3/4 in: 32 °F (fn a) | Table 5.11 | OK [GAP fn a, p. 82] |
| Interpass | "—" | Minimum preheat **and interpass** | 5.7.1 | **Missing** |
| Preheat category | Not stated | Table 5.5(4) | | **Missing** |
| Electrode diameter | 0.045 in | Within Table 5.4 limits | | OK |
| Amps / volts / WFS / travel | 162–198 A / 22–25 V / 270–330 / 6–8 ipm | Within Table 5.5 tolerances. Current within the manufacturer's range (Table 5.4). | | OK. Verify the manufacturer. |
| DCEP, CV, uphill, steel backing, 35 cfh | | 5.5.4, 5.8.1.1, 5.4.1.2, Table 5.5 | | OK |
| Bead / layer limits | Weave; none stated | Table 5.4, 5.8.2.1 | | **Verify** |
| Prepared by | CWI "Authorized by" | The Contractor prepares the WPS | 5.2.1 | **Verify** |

## D. Visual Inspection Report 2026-002

| Field | Issue | Ref | Status |
|---|---|---|---|
| Date | 11-27-26, but the review was on 11-22-26 | — | **Incorrect** |
| Client | "West Weld" should be Weld West | — | **Incorrect** |
| "10.15 for tubulars" | The tubular table is 10.14. The code's own 7.23 misprints 10.15. | 8.9 | **Incorrect** |
| Loading type | Not stated; Table 8.1 columns differ | Table 8.1 | **Missing** |
| Accepted members/joints | "Two columns and two beams" only | 8.5.4 | **Missing** |
| Weld sizes | Not measured or recorded | 8.5.3 | **Missing** |
| Stiffener welds with no callout, but "reflects plans: Yes" | Complete drawings are required. No unspecified welds without the Engineer's approval. | 8.1.6, 8.5.1 | **Incorrect** |
| WPS / welder | Not referenced | 8.3.3, 8.4.1 | **Missing** |
| Inspector role | Not stated | 8.1.2, 8.1.3 | **Verify** |
| Standards list | Boilerplate API/ASTM/ASME | 8.7 | BP |

## Printed-code issues found in this review

13. **7.23** cites "Tables 8.1 or 10.15", and **7.23.1** cites "8.1, and 10.16". The tubular table is 10.14.
14. **Tables 5.1–5.4 exceptions** cite "5.6.2" for weathering steel. The correct clause is 5.6.3.

(Issues 1–12 are in `wqtr-checklist.md` §7 and `visual-inspection-checklist.md` §5.)

Code changes that follow from this review are in `TODO.md`.
