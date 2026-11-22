# AWS D1.1/D1.1M:2025 reference for Weld Sync

These files came out of a claude.ai Project ("Weld Sync", Nov 2026). In that project McKay photographed sections of his D1.1:2025 book, and Claude built requirement checklists from the photos. Every requirement in them is tied to a clause, table or figure number.

| File | What it is |
|---|---|
| `clause-map.md` | Where everything lives in the 2025 edition. Includes a list of changes from 2020: the table renumbering and the plate/pipe split. |
| `wqtr-checklist.md` | Welder qualification. Table 6.13 essential variables, Tables 6.11/6.12 (plate), Tables 10.8/10.12 (pipe), coupons, acceptance criteria, retests. |
| `wps-prequalified-checklist.md` | Clause 5: Table 5.5 content and tolerances, Tables 5.4/5.6/5.7/5.11, the gas rule in 5.6.4, Fig. 5.1 B-U2a rows. |
| `visual-inspection-checklist.md` | Table 8.1, Table 10.14, Tables 7.8/7.9 weld profiles, and Clause 8 inspector duties. |
| `findings-weld-west-2026-11.md` | A worked review of a real WPS, two WPQRs and an inspection report produced by the app. |
| `TODO.md` | The Weld Sync code changes that came out of that review. **Start here.** |

## Rules for using these in code

- **CODE** items are requirements. **BP** items are best practice. Don't enforce BP as if it were code.
- **[VERIFY]** marks either a reading that's unclear in the photo or a suspected misprint in the printed code. **Do not hard-code a [VERIFY] value.** Surface it to the inspector instead, or leave it blank.
- **[GAP]** means the page hasn't been photographed yet. Don't fill a gap from memory or from D1.1:2020.
- The **printed-code issues** lists (WQTR checklist §7, findings doc end) record misprints in the 2025 book, such as Table 10.12's box row min > max, and 7.23 citing "10.15". Where the app cites a clause, cite the correct one.
- McKay is the inspector of record. The app drafts; he decides.

The project in claude.ai is the master copy. If the checklists change there, re-copy them here.
