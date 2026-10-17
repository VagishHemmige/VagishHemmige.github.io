# data/ — instructions for agents

Current local sources inspected 2026-10-17. Keep this file short and current: edit changed facts in place. History, releases, backups, design decisions and detailed reconciliation belong in the owner's private Academic Records profile, not this public repository.

## Authority and durable context

- Codex maintains approved YAML in `data/` and separately approved, reviewed PDFs in `abstracts/`, `presentations/` and `teaching/`. Check actual host permissions and the current profile allowlists each time; instructions alone grant no access.
- Vagish manages `.qmd`, `R/`, styles, rendering, Git and publishing in RStudio unless separately authorized. Describe precise consumer edits when needed; do not make them. Do not run `R/cv.R` or `quarto render` under routine maintenance scope.
- Show each exact record/PDF proposal and obtain approval before saving. Ask one question at a time about missing or ambiguous facts; never invent dates, institutions, roles or current status. Preserve existing resources; do not overwrite attachments silently.
- Before copying an upload, warn and pause if patient identifiers may be present. Follow the current plugin's initial screening/private-copy approval, local PowerPoint conversion, visual/privacy review and public-use approval procedure. Conversion is not de-identification. Offer attachments now/later/none and match later uploads to an existing activity.
- Read the current installed Academic Records workflow. Resolve private configuration through the owner's local `~/.codex/academic-records/handoff.json` and its `full_profile_locator`; do not assume this route or its access remains current. Forwarding needs explicit human authorization.
- In that private profile, `config.json` owns preferences; `DEVELOPMENT.md` is the design entry point, with linked review/design/history files. Consult saved confirmations and deferrals before asking again. Keep website suggestions there, not here. Do not recreate setup, schedules or competing profiles. Installation is not source-search permission.
- Reusable mentoring/project discovery decisions and deferred acceptance cases are in private `reviews/MENTORING-DISCOVERY-DESIGN.md` and `reviews/WEEKLY-REVIEW-TESTS.md`. Check current implementation before claiming a design is supported. Coauthorship or attendance alone establishes neither mentoring nor project membership; inactivity alone does not establish project closure.

## Sources of truth

- Records flow from YAML/Zotero exports to website pages and the existing Word/officer CV generator. Never import a generated CV back into records. The confirmed historical import baseline is `cv/Archive/Hemmige Einstein CV 2026-09-04.docx`; preserve it and do not ask for the baseline again.
- Publications come from Zotero. Never hand-edit `VH library.bib` or its exports; corrections/imports use the separately approved Zotero workflow. Recheck actual collection/auto-export behavior and side effects before a library write.
- `VH book chapter library.bib` currently matches `VH library.bib` byte for byte; no direct source consumer was found. Neither observation authorizes deletion or assumptions about future export behavior.
- Store each activity once. `cv_sections` can expose an appointment in multiple CV sections, as for Director of Medical Student Research (`appointments`, `service`).
- Private contacts and CV formatting sources remain in ignored `cv/private.yml` and `cv/cv-styles.docx`. Never copy private details into public data or delete ignored sources. Word CV layout is already user-approved; completeness is a separate question. Public-CV preparation is deferred until requested.

## Files and consumers

Counts are dated observations, not completeness claims. Update them when records change; inspect the actual consumer before changing a field's shape.

| YAML file | Count | Consumers |
| --- | ---: | --- |
| abstracts.yml | 35 | abstracts.qmd, mentoring.qmd, R/cv.R |
| mentoring.yml | 21 | mentoring.qmd |
| projects.yml | 5 | Projects.qmd |
| talks.yml | 26 | presentation.qmd, R/cv.R |
| teaching.yml | 10 | teaching.qmd |
| media.yml | 11 | media.qmd; website only |
| education.yml | 3 | R/cv.R |
| training.yml | 2 | R/cv.R |
| appointments.yml | 8 | R/cv.R |
| certifications.yml | 2 | R/cv.R |
| memberships.yml | 3 | R/cv.R |
| honors.yml | 3 | R/cv.R |
| service.yml | 20 | R/cv.R |
| grants.yml | 2 | R/cv.R |

`VH library.bib` has 73 entries and feeds manuscripts.qmd, mentoring.qmd and R/cv.R. `R/citations.R` supplies CV citations and shared website LaTeX cleanup; the website still constructs citations separately. Some Home/About prose remains hard-coded; do not maintain competing authorities or assume all CV YAML is integrated into pages.

## Compatibility rules

- All record files are top-level sequences of mappings. Preserve scalar/list shapes and explicit nulls. Abstract `authors` is one citation string, not a list; preserve order and `authors_truncated` where present. Mentoring `level`/`role` may be scalar or list; `projects`/`manuscripts` and abstract `mentees` are lists.
- Abstracts and talks require full `YYYY-MM-DD` dates for current page consumers; mentoring.qmd also parses abstract dates, not dates on mentoring records. Teaching `dates` is a list of full session dates; do not collapse sessions.
- Other CV dates retain source precision as quoted year/month/day strings. `end_date: "present"` is explicit ongoing source wording; null is unknown/unspecified, not proof of ongoing status. Preserve `date_text`; the generator checks discrepancies. Media dates remain null until established from evidence.
- Values: talk `category` = invited/conference/grand_rounds/teaching; abstract `type` = oral/poster and `scope` = international/national/regional/local; mentoring `status` = Active/Former; project `status` = active/completed/paused; service `category` = intramural/extramural.
- Media `section` = writing/printed_news/video_news/podcast; `id` matches `^[a-z][a-z0-9-]*$`. URLs use HTTPS; embeds require recognized provider-specific HTTPS hosts/paths for youtube/apple_podcasts/libsyn, not arbitrary HTML. Inspect validator and media.qmd restrictions, not just URL prefixes.
- Abstract anchors depend on title + meeting + year. Mentoring `projects` matches project titles and links to `Projects.html`; `manuscripts` matches existing BibTeX citation keys; abstract `mentees` matches exact names. Renaming affects links. One abstract may name several mentees without duplicate records.
- YAML resource paths resolve from the repository root, with exact case and spaces. A null talk city currently renders as Virtual. Four existing virtual talks were confirmed (CDC/HHS 2022-05-18; Nassau/Suffolk 2023-04-05; US Chagas Network 2023-08-04; Westchester 2023-11-03); do not infer future missing cities mean virtual. Ask before saving an in-person talk with no known city.
- Preserve `_quarto.yml`'s root-page render restriction so maintenance instructions are not rendered into the site. Generated folders and ignored files are not automatically disposable.

## Before and after saving

- Use current proposal/stale-source/approval-evidence safeguards and a unique hash-verified backup outside the public repository. Preserve failure evidence; inspect actual status instead of blindly retrying, rolling back or minting historical success from matching bytes alone.
- Parse all YAML as UTF-8; check IDs, required fields, shapes, dates/enums, cross-references and affected website/CV consumers. Use the current validator's reviewed baseline-error policy: show remaining/resolved errors; reject new/changed errors and parser/structure failures. Never silently repair unrelated records.
- Report exact sources saved, facts/evidence, checks, backup and unresolved questions. Distinguish records/PDFs saved from CV generation, website rendering and deployment. Give the existing owner-managed handoff without implying those outputs were regenerated.

## Outstanding factual/consumer questions

- Verify the Madan 2025/2026 entries sharing a DOI in Zotero before proposing any merge/removal; no deletion is authorized by this note. Prostatitis chapter year 2015 and other publication details still need authoritative verification.
- The 2018 “Predicting Risk of Clinical Deterioration…” abstract is one work at Baylor and Texas ACP Southeast Regional, with the award at Texas ACP only. Occurrence dates/compatible representation remain unsettled. Do not research the declined Austin date unless asked.
- ISHLT full meeting wording needs an authoritative source. Preserve official title capitalization rather than automatically normalizing it.
- Talk dates 2013-01-01, 2016-06-01 and 2018-03-01 need source-precision verification before any representation change; current pages require full dates. Do not infer placeholders from day 1 alone. Preserve source wording/backticks unless a concrete correction is approved. Merck grant end date 2025-07-02 and training dates were confirmed; do not reopen them without new evidence.
- Macdonald grant `date_text` contains a two-digit year; any normalization needs review. Hudson Valley start 2026-11-01 remains planned until confirmed, even after that date passes.
- `software.yml` and `profile.yml` remain proposals, not authorized files. New schema/files need explicit approval, compatible consumers and allowlist changes. Current publication authority is Zotero; any future store migration is a separate decision.
