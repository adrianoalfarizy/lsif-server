# SAIF GTA SA Full Source Acceptance Audit

**Status: ACCEPTED FOR OFFLINE-WORLD PARSER DEVELOPMENT**

## Package summary
- Archive files: **998**
- Uncompressed size: **58.22 MiB**
- Raw GTA data files: **274** (20.04 MiB)
- Included Sanny Builder files: **722** (24.47 MiB); not needed for import

## Critical files
- `data/script/main.scm`: present
- `data/script/script.img`: present
- `01_DECOMPILED/main_decompiled.txt`: present and complete-looking
- `data/map.zon`, `data/info.zon`: present
- `data/Paths/carrec.img` and NODES0–63: present
- Full `data/maps`: present
- `vehicles.ide`, `carcols.dat`, `shopping.dat`, `weapon.dat`, `peds.ide`, `object.dat`: present

## Hashes
- `main.scm` SHA-256: `601def3baae766ce6a23e2f0b9b48f6b33c9a64e2fc32eb4f22ddea8b868b0fa`
- `script.img` SHA-256: `582b2ad47aafa9867238aff2d2b07cce5cc85496612157e759a4f25aa9e83187`
- `main_decompiled.txt` SHA-256: `6f9aba5978482d9f31fcc32cdbbd2c95577a9f650a13fa0df50904a6e3c3af84`

## Load-reference validation
- References checked from `gta.dat` and `default.dat`: **113**
- Data references present: **111**
- Missing `DATA\...` references: **0**
- Excluded model assets: `MODELS/CUTSCENE.IMG`, `MODELS/COLL/WEAPONS.COL` (not required for world metadata import)

## Decompiled SCM validation
- Size: **13.71 MiB**
- Lines: **535,204**
- Missions defined: **135**
- External scripts recovered: **78** (IDs 0–77)
- `create_car_generator` statements: **211**
- Statically parseable car generators: **201**
- Immediately valid non-zero vehicle candidates: **195**
- `create_pickup` statements: **335**
- Statically parseable pickups: **288**
- Immediately valid non-zero pickup candidates: **286**
- Unknown opcode markers: **0**

## IPL world sections
- `inst` records: **9,315**
- `enex` records: **376**
- `grge` records: **52**
- `pick` records: **5**
- `cars` records: **0**
- `cull` records: **1,266**
- `auzo` records: **155**
- `occl` records: **1,012**
- `jump` records: **0**

## Zone data
- `map.zon`: **6** broad map zones
- `info.zon`: **378** named area records

## External script coverage
`0:PLAYER_PARACHUTE`, `1:PARACHUTE`, `2:BCESAR2`, `3:BCESAR3`, `4:SLOT_MACHINE`, `5:ROULETTE`, `6:OTB_SCRIPT`, `7:ARCADE`, `8:VENDING_MACHINE`, `9:FOOD_VENDOR`, `10:GATES_SCRIPT`, `11:GYMBIKE`, `12:GYMBENCH`, `13:GYMTREAD`, `14:GYMDUMB`, `15:BASKETB`, `16:VIDPOK`, `17:BLACKJ`, `18:WHEELO`, `19:DEALER`, `20:HOME_BRAINS`, `21:POOL_SCRIPT`, `22:LOWR_CONT`, `23:BURG_BRAINS`, `24:GF_MEETING`, `25:GF_DATE`, `26:GF_SEX`, `27:CASINO_AMBIENCE`, `28:BAR_AMBIENCE`, `29:FOODBRAINS`, `30:OTB_AMBIENCE`, `31:STRIP_AMBIENCE`, `32:PLANES`, `33:TRAINS`, `34:ZERO_AMBIENCE`, `35:DANCE`, `36:SHOPKEEPER`, `37:CUSTOMER_PANIC`, `38:BAR_STAFF`, `39:BOUNCER`, `40:OTB_STAFF`, `41:PCHAIR`, `42:PCUSTOM`, `43:OTBWTCH`, `44:OTBSLP`, `45:OTBTILL`, `46:FBOOTHR`, `47:FBOOTHL`, `48:BARGUY`, `49:PEDROUL`, `50:PEDCARD`, `51:PEDSLOT`, `52:DANCER`, `53:STRIPW`, `54:STRIPM`, `55:BROWSE`, `56:COPSIT`, `57:COPLOOK`, `58:TICKET`, `59:SHOPPER`, `60:AMMU`, `61:TATTOO`, `62:BARBER`, `63:WARDROBE`, `64:CLOTHES`, `65:JUNKFUD`, `66:CARMOD1`, `67:CRANE1`, `68:CRANE2`, `69:CRANE3`, `70:CARPARK1`, `71:IMPOUND`, `72:VALET`, `73:PHOTO`, `74:PRISONR`, `75:CAMERA`, `76:DEBT`, `77:HOTDOG`

## Notes
- README is still the unfilled template. This does not block parsing because the `main.scm` hash, script structure, mission count, and external-script range are internally consistent.
- Future ZIPs do not need the `02_TOOLS/SannyBuilder4` folder.
- This package is sufficient to begin the source registry, SCM parser, ENEX queue, parked-vehicle queue, pickup queue, zones, shops, garages, and mission-context extraction.

## Safety decision
No runtime SAIF table should be modified from this package yet. First generate deterministic staging rows with source file, source line/offset, hash, category, confidence, and duplicate keys. Runtime replacement happens only after archive and category-level review.
