# Weld Sync: D1.1:2025 code-compliance changes

These items came from reviewing real app output against D1.1:2025: WPS FCAW-38, WPQRs for Quinn Morley 3G/4G, and inspection report 2026-002. Full details and clause references are in `findings-weld-west-2026-11.md`, `wqtr-checklist.md` and `wps-prequalified-checklist.md`.

Before changing anything, check the current code. HANDOFF.md says some of this already exists, for example `wpsChecks(p)` for Clause 5 and `suggest(w)` for ranges. Treat each item as "verify, then fix if needed."

## Status: v2026-11-22.2

Items 1–21 are all done. HANDOFF.md §5 describes how each one works.

There is one difference from item 11, on purpose:
- 5.4.1.5 lets GMAW and FCAW use SMAW joint details.
- The SMAW B-U2a row at 1/4 in / 45° is "All" positions.
- So FCAW at 1/4 in / 45° in all positions is still prequalified when the WPS calls the joint **B-U2a**.
- If the WPS calls it **B-U2a-GF**, the app flags it, because that row is F, V, OH only.
- FCAW-38's 60° groove angle fails either way.

McKay to confirm this reading.

None of the "Do NOT encode yet" items below are encoded.

## WQTR / WPQR

1. **"Qualified To" field.** Default to "AWS D1.1/D1.1M:2025, Clause 6". The joint designation (e.g. B-U2a) moves to a separate "Test joint / WPS detail" field. (6.3.1, 6.17)
2. **Two signature blocks.**
   - Contractor certification: name, title, signature. The WPQR is the Contractor's certification (6.20, 6.2.2.2).
   - Test witnessed/verified by CWI.
3. **Required test thickness.** Block generation when the test thickness (or pipe OD and wall) is missing, and derive every range from it. The 4G record printed blank ranges. (Table 6.12, Table 10.12)
4. **Non-essential variables.**
   - Print filler classification, gas, base metal and filler diameter as "As tested, not a qualification limit (Table 6.13)".
   - Show the process as FCAW, with -G/-S recorded as a detail.
   - Keep these as true limits: the SMAW F-number range (Table 6.14; a test qualifies the tested F-number and lower), GMAW-S as a separate process, vertical progression, backing, and single/multiple electrodes (operators).
5. **Combined positions.** When the same welder and process have passing 3G + 4G (or 3F + 4F), output "All positions" per Table 6.11, either on a summary or on each record.
6. **Coupon geometry check.** Fig. 6.21 maximums, unless the WPS joint is a confirmed prequalified detail. Warn when the WPS groove exceeds these.

   | Coupon | α max | R max |
   |---|---|---|
   | Welder, with backing | 45° | 1/4 in |
   | Welder, without backing | 60° | 3/16 in |
   | Operator, with backing | 20° | 5/8 in |
   | Operator, without backing | 60° | 3/16 in |

7. **Acceptance citations.**
   - Visual: 6.23.1 → 6.10.1.
   - Bends: 6.23.5 → 6.10.3.3.
   - RT in lieu of bends: 6.23.3.2 → 8.12.2 except 8.12.2.2. RT is not allowed for GMAW-S (6.18.1.1).
   - Don't cite "Clause 6 Part C" for criteria that live in 6.10 (Part B).
8. **Auto-number test and record numbers.** Drop the handwritten "Std. Test No.".
9. **Pipe ranges from a plate groove test.** Groove on pipe is "≥ 24 in **with backing or backgouging only**". Keep the condition in the same cell. (Table 6.11 fn b)
10. **Continuity, not expiry.** No fixed expiry date. Track 6-month continuity per process. (6.2.3.1)

## WPS (prequalified, Clause 5)

11. **Fig. 5.1 joint lookup.** Store the rows (process, T1, R, α, positions, FCAW gas). Warn when the R/α/position combination isn't listed; the as-detailed α tolerance is +10°/−0°. Auto-append "-GF" for GMAW/FCAW. FCAW-38 claimed B-U2a at 60°/1/4 in, "All" positions. B-U2a-GF allows 1/4 in only at 45°, in F, V, OH.
12. **Electrode/gas rule (5.6.4).** For FCAW-G, the gas must be the classification gas (a C designator means CO2). Mixed gas requires an -M or dual -C/-M classification. Flag E71T-1C used with 75/25.
13. **Table 5.5 completeness.** Before a WPS can be marked prequalified, require:
    - preheat category (Table 5.11)
    - interpass temperature
    - current type and polarity
    - amps and volts
    - WFS and travel speed
    - gas and flow
    - groove details
    - PWHT

    Check ranges against the tolerances: ±10% A, ±15% V, ±10% WFS, ±25% travel, +50/−25% flow.
14. **Preheat from Table 5.11.** Compute it from the category plus the thickest part, rather than free text. Category B: 32 °F for 1/8–3/4 in, 50 °F for > 3/4–1-1/2 in, 150 °F for > 1-1/2–2-1/2 in, 225 °F above.
15. **Base metal group by thickness.** A36 is Group I only up to 3/4 in and Group II at all thicknesses (Table 5.6). HANDOFF mentions "Table 5.3" for groups: in 2025 it is **Table 5.6**. Check for stale 2020 table numbers throughout.
16. **Internal consistency.** Blank the "With PWHT" thickness when PWHT is None. Require "prepared by: Contractor" (5.2.1), kept separate from the CWI review.

## Inspection report

17. **Tubular reference.** "Table 10.15 for tubulars" → **Table 10.14**. The code's own 7.23 misprints 10.15.
18. **Fields to add:**
    - loading type (static / cyclic / tubular), which selects the Table 8.1 column
    - inspector role, Contractor's or verification (8.1.3)
    - WPS(s) used (8.3.3)
    - welder IDs with WPQR numbers (8.4.1)
    - member/joint table with specified and measured sizes (8.5.1, 8.5.3, 8.5.4)
    - base metal, for the 48 h rule in Table 8.1(5)
19. **Unspecified-welds check.** A yes/no for "welds present that aren't on the drawings". If yes, require an Engineer approval reference (8.1.6, 8.5.1).
20. **Dates.** Keep the inspection date separate from the report date, and warn when either is in the future.
21. **Standards list.** Trim the boilerplate ("API, ASTM, ASME"). List only what the contract invokes (8.7).

## Do NOT encode yet (open [VERIFY] items)

- Table 10.12, box Fig. 10.20 row: pipe size min/max is printed reversed (24 / 4).
- Table 10.8 pipe butt column header is printed "PJP" where "CJP" is expected. The box T-, Y- and K-connection 2G row has also been hand-edited.
- Table 10.8 footnote k placement on the 6GR rows.
- The Table 6.13 tack welder column for rows 4–7.
- Table 8.1 (7)(A)(1)(b): "> 1/16 in" conflicts with (a).
- Fig. 5.1 notes a and j (p. 85), and Table 5.11 footnote a (p. 82). Not photographed yet.
