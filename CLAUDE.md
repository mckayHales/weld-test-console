# Weld Sync

Read `HANDOFF.md` first. It covers how the app works, the two links, and where the code lives in `index.html`.

## AWS D1.1:2025 requirements

The governing code edition is **AWS D1.1/D1.1M:2025**. Code-checked requirement checklists, built from photos of McKay's book, live in `docs/d1.1-2025/`:

- `docs/d1.1-2025/TODO.md`: open code changes from a real document review. **Start here for D1.1 work.**
- `docs/d1.1-2025/wqtr-checklist.md`: welder qualification (Tables 6.11–6.14, 10.8, 10.12, Figs. 6.21–6.27, acceptance criteria).
- `docs/d1.1-2025/wps-prequalified-checklist.md`: Clause 5 (Tables 5.4–5.7, 5.11, Fig. 5.1 B-U2a, 5.6.4 gas rule).
- `docs/d1.1-2025/visual-inspection-checklist.md`: Table 8.1, Table 10.14, Tables 7.8/7.9, Clause 8 Part A duties.
- `docs/d1.1-2025/clause-map.md`: where things live in the 2025 edition, and what moved from 2020.
- `docs/d1.1-2025/findings-weld-west-2026-11.md`: worked review of app output.

Rules:
- Cite 2025 clause, table and figure numbers. Many 2020 numbers changed; see clause-map §2.
- Never hard-code a value marked **[VERIFY]**, or fill a **[GAP]** from memory.
- **CODE** items are requirements; **BP** items are suggestions.
- The app drafts. The inspector verifies and signs.
