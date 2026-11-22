# Prequalified WPS Checklist: AWS D1.1/D1.1M:2025

**Status:** Step 2, prequalified WPSs. Usable for FCAW, GMAW and SMAW CJP butt joints. The gaps are listed in section 7.

**Built from:** pp. 62–81 and 86–87 (scan 6).

**Conventions**
- **CODE** marks a requirement taken from the uploaded pages.
- **BP** marks a best-practice suggestion.
- **[GAP]** marks something that depends on a page not yet uploaded.

---

## 1. General (CODE)

| # | Requirement | Ref |
|---|---|---|
| 1.1 | A prequalified WPS is exempt from Clause 6 testing only if it meets **all** of Clause 5. Otherwise it must be qualified by test. | 5.1 |
| 1.2 | Every prequalified WPS must be written. | 5.1 |
| 1.3 | **The Contractor prepares the WPS.** Any format may be used (Annex J has examples). | 5.2.1 |
| 1.4 | All requirements of Tables 5.1–5.4 must be met for the process used. | 5.2, 5.8.1 |
| 1.5 | The parameters in Table 5.5 must appear on the WPS, within the ranges allowed. A change outside the Table 5.5 tolerances requires a new or revised WPS, or qualification by test. | 5.2.1 |
| 1.6 | Qualified and prequalified WPSs may be combined, provided each process's essential-variable limits are observed. | 5.2.2 |
| 1.7 | Welders using the WPS must be qualified per Clause 6 Part C, or Clause 10 Part D for tubulars. | 5.1 |
| 1.8 | The Contractor's inspector ensures the prequalified WPS conforms with Clauses 5, 7, 10 (if tubular) and the contract documents. | 8.3.1 |

## 2. Required content (Table 5.5, items 1–21)

1. Process. A change in process requires a separate WPS.
2. Position(s)
3. Base metal group number (Table 5.6)
4. **Base metal preheat category (Table 5.11)**
5. Filler metal classification (SMAW, GMAW, FCAW)
6. Filler/flux classification (SAW)
7. Nominal electrode diameter
8. Number of electrodes (SAW)
9. Electrode spacing and orientation (SAW)
10. Amperage (SAW, FCAW, GMAW)
11. Voltage (SAW, FCAW, GMAW)
12. Mode of transfer (GMAW)
13. Type of current (AC or DC)
14. Polarity
15. Wire feed speed (SAW, FCAW, GMAW)
16. Travel speed
17. Nominal shielding gas composition (FCAW-G, GMAW)
18. Shielding gas flow rate (FCAW-G, GMAW)
19. Weld type
20. Groove weld details
21. PWHT

**Tolerances**

| Variable | Tolerance |
|---|---|
| Amperage | ±10% |
| Voltage | ±15% |
| WFS (if not amperage-controlled) | ±10% |
| Travel speed | ±25% |
| Gas flow rate | +50% / −25% |
| SAW arc spacing and angles | per items 27–31 |

## 3. Base metal, filler and gas

| Item | Requirement | Ref |
|---|---|---|
| Base metal | Only Table 5.6 steels may be used. A36 is **Group I up to 3/4 in** and **Group II at all thicknesses**. | 5.3, Table 5.6 |
| Filler | Only Table 5.7 fillers may be used. **FCAW, Group I or II, A5.20:** E7XT-X, E7XT-XC, E7XT-XM. Electrodes with the −2C, −2M, −3, −10, −13, −14 and −GS suffixes are excluded. −11 suffix electrodes are excluded above 1/2 in. Any filler listed for a group may weld any base metal in that group. | 5.6, Table 5.7 |
| Mixed groups | Match either the higher-strength base metal, or the lower-strength one using a low-hydrogen deposit. | Table 5.6 note 1 |
| Overmatch | Up to 10 ksi above the Table 5.7 matching filler is allowed. | 5.6.2 |
| **Gas, FCAW-G and GMAW** | Must conform to AWS A5.32. It must also either be the gas used to classify the electrode, or meet the OE-designator rules. **For FCAW-G, an electrode without an OE designator must have been classified by its manufacturer as an "-M" (mixed gas) product** before it is run on mixed gas. | 5.6.4(1), 5.6.4(4) |
| GMAW, A5.18 | Ar/CO2 (Ar 75–90%), Ar/O2 (Ar 95–98%), or 100% CO2 | Table 5.10 |
| Weathering steel, exposed bare | Per Table 5.9, except single-pass welds (5.6.3.1–2) | 5.6.3 |

## 4. Process limits

### FCAW and GMAW metal-cored (Table 5.4)

**Electrode diameter**

| Material thickness T | Minimum diameter | Maximum diameter (FCAW) |
|---|---|---|
| ≤ 3/8 in | FCAW: 0.030 in. GMAW-cored: no minimum. | — |
| > 3/8 in | 0.045 in (FCAW and GMAW-cored) | 1/8 in flat/horizontal; 3/32 in vertical; 5/64 in overhead |

**Other limits**
- **Current:** within the filler manufacturer's recommended range.
- **Root bead thickness:** 3/8 in flat; 5/16 in horizontal; 1/2 in vertical; 5/16 in overhead.
- **Fill and cap bead thickness:** 1/4 in maximum.
- **Single-pass fillet:** 1/2 in flat; 3/8 in horizontal; 1/2 in vertical; 5/16 in overhead.
- **Layer width:** use a split root layer when the root opening is ≥ 1/2 in (max bead width 1 in). Split layers when width exceeds 5/8 in (flat) or 1 in (horizontal, vertical, overhead).

### GMAW solid wire (Table 5.3)
- Electrode diameter ≤ 1/16 in.
- **Minimum amperage by wire size:** .030 → 190 A; .035 → 210 A; .040 → 230 A; .045 → 260 A; 1/16 → 300 A. The manufacturer's recommendations may be used instead, **provided the transfer mode is not short circuit**.
- **Pulsed spray minimum average current:** .035 → 100 A; .045 → 110 A; .052 → 120 A; 1/16 → 140 A.
- Bead and layer limits are the same as FCAW, except the single-pass fillet limits apply as tabulated.
- GMAW-S is **not prequalified** (5.5.1, 5.5.2).

### SMAW (Table 5.1)

**Electrode diameter**

| Position | Maximum | Exception |
|---|---|---|
| Flat, fillet | 5/16 in | Root pass excepted |
| Flat, groove | 1/4 in | Root pass excepted |
| Flat, root pass | 3/16 in | — |
| Horizontal, fillet | 1/4 in | — |
| Horizontal, groove | 3/16 in | — |
| Vertical and overhead | 3/16 in | 5/32 in for EXX14 and low-hydrogen electrodes |

**Bead limits**
- Root bead: 3/8 in flat; 5/16 in horizontal; 1/2 in vertical; 5/16 in overhead.
- Fill and cap beads: 3/16 in.
- Single-pass fillet: 3/8 in flat; 5/16 in horizontal; 1/2 in vertical; 5/16 in overhead.

### SAW
See Table 5.2 for the current, bead and layer limits by electrode arrangement.

### All processes
| Item | Requirement | Ref |
|---|---|---|
| Power source | CV for GMAW and FCAW | 5.5.4 |
| Vertical progression | Upward for all passes. Exceptions: undercut repair downhill with preheat ≥ 70 °F; tubulars, in the direction the welder is qualified for. | 5.8.1.1 |
| Pass shape | Neither depth nor maximum width of any pass may exceed its surface width | 5.8.2.1, Fig. 5.6 |
| PWHT | Prequalified only with the Engineer's approval, plus: yield ≤ 50 ksi; not Q&T, QST, TMCP or cold-worked; no CVN requirement; strength and ductility data in the PWHT condition; done per 7.8 | 5.9 |

## 5. Joints

### CJP (5.4.1)
- Detail per Fig. 5.1.
- "As detailed" tolerances apply to drawings; "as fit-up" tolerances apply in the shop.
- One-sided CJP needs **steel backing**. Non-steel backing qualifies only if it is removed and the root is backgouged and backwelded.
- SMAW joint details may be used for GMAW and FCAW.
- Mechanized or automatic welding: root-opening variation ≤ 1/8 in.

**Single-V butt with backing (Fig. 5.1, p. 87)**

| Designation | Process | T1 | R | α | Positions | FCAW gas |
|---|---|---|---|---|---|---|
| B-U2a | SMAW | U | 1/4 | 45° | All | — |
| B-U2a | SMAW | U | 3/8 | 30° | F, V, OH | — |
| B-U2a | SMAW | U | 1/2 | 20° | F, V, OH | — |
| **B-U2a-GF** | GMAW/FCAW | U | 3/16 | 30° | F, V, OH | Required |
| **B-U2a-GF** | GMAW/FCAW | U | 3/8 | 30° | F, V, OH | Not required |
| **B-U2a-GF** | GMAW/FCAW | U | 1/4 | 45° | **F, V, OH** | Not required |
| B-L2a-S | SAW | 2 max | 1/4 | 30° | F | — |
| B-U2-S | SAW | U | 5/8 | 20° | F | — |

**Tolerances:** R as detailed +1/16, −0; as fit-up +1/4, −1/16. α as detailed +10°, −0°; as fit-up +10°, −5°.

**[GAP]** Notes a and j are on p. 85.

**Square-groove details (Fig. 5.1, pp. 86–87)**

| Designation | Process | T1 max | T2 | R | R as detailed | R as fit-up | Positions | FCAW gas |
|---|---|---|---|---|---|---|---|---|
| B-L1a | SMAW | 1/4 | — | T1 | +1/16, −0 | +1/4, −1/16 | All | — |
| C-L1a | SMAW | 1/4 | U | T1 | +1/16, −0 | +1/4, −1/16 | All | — |
| B-L1a-GF | FCAW/GMAW | 3/8 | — | T1 | +1/16, −0 | +1/4, −1/16 | All | Not required |
| B-L1b | SMAW | 1/4 | — | T1/2 | +1/16, −0 | +1/16, −1/8 | All | — |
| B-L1b-GF | GMAW/FCAW | 3/8 | — | 0 to 1/8 | +1/16, −0 | +1/16, −1/8 | All | Not required |
| B-L1-S | SAW | 3/8 | — | 0 | ±0 | +1/16, −0 | F | — |
| B-L1a-S | SAW | 5/8 | — | 0 | ±0 | +1/16, −0 | F | — |
| TC-L1b | SMAW | 1/4 | U | T1/2 | +1/16, −0 | +1/16, −1/8 | All | — |
| TC-L1-GF | GMAW/FCAW | 3/8 | U | 0 to 1/8 | +1/16, −0 | +1/16, −1/8 | All | Not required |
| TC-L1-S | SAW | 3/8 | U | 0 | ±0 | +1/16, −0 | F | — |

B-L1b, B-L1-S, B-L1a-S and the TC-L1 details are backgouged, except B-L1-S.

### PJP and fillet
- **PJP (5.4.2):** detail per Fig. 5.2. Minimum weld size per Table 5.8. Drawings must show groove depth D for the required weld size S.
- **Fillets (5.4.3):** minimum size per Table 7.7; details per Fig. 5.3; skewed T-joints per Figs. 5.4 and 5.5.
- **Plug and slot (5.4.4):** technique per 7.24.

**Table 5.8, minimum PJP weld size**

| Base metal T | Minimum S |
|---|---|
| 1/8–3/16 in | 1/16 in |
| > 3/16–1/4 in | 1/8 in |
| > 1/4–1/2 in | 3/16 in |
| > 1/2–3/4 in | 1/4 in |
| > 3/4–1-1/2 in | 5/16 in |
| > 1-1/2–2-1/4 in | 3/8 in |
| > 2-1/4–6 in | 1/2 in |
| > 6 in | 5/8 in |

## 6. Preheat (Table 5.11, Category B: low-hydrogen SMAW, SAW, GMAW, FCAW)

Category B includes A36, A500, A572 Gr 42/50/55, A709 Gr 36/50/50W and others.

| Thickest part at point of welding | Minimum preheat / interpass |
|---|---|
| 1/8–3/4 in | 32 °F (footnote a) |
| > 3/4–1-1/2 in | 50 °F |
| > 1-1/2–2-1/2 in | 150 °F |
| > 2-1/2 in | 225 °F |

**Category A** (SMAW with non-low-hydrogen electrodes): 32 / 150 / 225 / 300 °F over the same bands.

**Mixed base metals:** use the highest of the applicable preheats (5.7.2).

**[GAP]** Footnote a and the remaining categories (C and on) are on p. 82.

## 7. Gaps

1. **p. 85:** Fig. 5.1 notes (a and j are cited by B-U2a-GF).
2. **p. 82:** Table 5.11 continued, including footnote a.
3. **pp. 88–107:** the rest of Fig. 5.1, only for the joints you actually use (bevel, J, U, T and corner).
4. **pp. 108–127:** Figs. 5.2–5.6, for PJP, fillet and skewed joints.
5. **Annex K (pp. 429–430):** contents of a prequalified WPS (informative).
