# Academic CV and website maintenance

## Durable operating instructions

### Future plugin review questions (2026-10-15)

The user identified the reconciliation questions as useful material to save for the eventual auto-updating plugin, then explicitly clarified: "We can do the detailed questions now but save too." Continue focused reconciliation questions now while preserving answers and reusable question patterns for later. This does not authorize building the plugin or scheduling tasks.

Future maintainer reviews should ask focused questions about: whether open-ended employment, certifications, memberships, and reviewer roles remain current; whether planned appointments started, changed, or were cancelled; missing institutions or dates; and conflicting facts across sources. Batch related questions, reuse prior confirmations with their dates, and update only facts the user confirms or reliable authorized sources establish. Do not infer an appointment actually started merely because its planned date passed, or mark credentials expired without evidence.

Resolved example: the user confirmed "Yes OMSR and MSRC was Einstein." Both Medical Student Research Committee entries now name Albert Einstein College of Medicine in service.yml; the Director of Medical Student Research appointment already names it. Save institution clarification as a reusable plugin question pattern. The two-meeting abstract question remains pending.

### User confirmations during reconciliation (2026-10-15)

- The first-place Patient Safety/Quality Improvement award for Predicting Risk of Clinical Deterioration was at Texas ACP only, not Baylor. abstracts.yml's existing award text now explicitly attributes it to Texas ACP Southeast Regional Conference, without changing its schema or the combined meeting field.
- The user confirmed "Same at both" for Predicting Risk of Clinical Deterioration: A Closer Look at Resident Handoffs and Rapid Response, presented at the 2018 Baylor Housestaff Symposium and Texas ACP Southeast Regional Conference. This is one underlying work presented at two meetings. Separate presentation occurrences are now factually justified, but their dates and a compatible schema/consumer implementation remain to be settled before restructuring abstracts.yml. This confirmation supersedes earlier pending statements about whether it was the same work.
- The user instructed use of the CV for the Merck grant end date: July 2, 2025; grants.yml already contains it.
- The user confirmed the missing Prostatitis chapter should remain in the CV and explicitly authorized adding it to Zotero. A duplicate search found none. Imported into Zotero My Library as bookSection, item key IYFZXTBM, citation key dangayachProstatitis: authors P. Dangayach and V. Hemmige, book Hospital Medicine, from the confirmed CV. Year, edition, editors, publisher and pages remain unverified. No project BibTeX files were manually edited or re-exported; inclusion in an appropriate export collection remains pending. Zotero local API was enabled with preference backup and the installed desktop app launched to complete the authorized import.
- Official master's subject: Health Studies. education.yml already follows this; about.qmd's Health Sciences wording needs a user-applied correction.
- OMSR and MSRC were at Einstein; the two MSRC service entries were updated to Albert Einstein College of Medicine. The director appointment already has that institution. Location fields on MSRC entries remain unspecified.
- Residency dates June 2006–June 2009 and fellowship dates July 2009–August 2012 are correct as recorded in training.yml.
- November 1, 2026 remains the planned start date for the Medical Associates of the Hudson Valley physician appointment. Do not treat it as already started on October 15.
- In response to a grouped check, the user confirmed no endings or changes to Mercor work, both board certifications, all three society memberships, and the five journal/abstract reviewer roles. Their source-explicit present end dates remain appropriate as of this confirmation.
- The abstract mentioning two meetings remains unresolved: do not assume identical abstracts or distinct submissions, and do not restructure it until confirmed.

These confirmations require no changes to current YAML values. Continue reconciliation with unverified entries rather than asking these questions again.

### Initial YAML expansion (2026-10-15)

The user confirmed `cv/Hemmige Einstein CV 2026-09-04.docx` as the migration baseline and then authorized: "Start with new YAML. Then we can do the minute reconciliation needed." This supersedes the setup-only restriction for creating the new records below. Existing YAML/BibTeX files and parent website files were left unchanged. Detailed entry reconciliation, publication format selection, and CV generation remain pending.

Added 43 records in eight additive top-level sequence files: education.yml (3), training.yml (2), appointments.yml (8), certifications.yml (2), memberships.yml (3), honors.yml (3), service.yml (20), grants.yml (2). These are now within the user-approved YAML maintenance scope. Each record has a stable id; file comments identify the baseline source. Dates use quoted ISO strings at source precision, with date_text preserving original ranges; end_date "present" is explicit source wording and null means unspecified. Consumers must handle year/month precision instead of blindly applying as.Date. No inferred current status was added for the November 2026 appointment. Private address and email were not imported.

Director of Medical Student Research is stored once in appointments.yml with cv_sections [appointments, service], reflecting its appearance in both CV sections. A future service renderer must include this record by reference rather than duplicate it. The new files have no existing website consumers; user-applied Quarto/R changes are needed to display or generate from them. Existing hard-coded education remains a transitional copy to reconcile; do not maintain it as a second authority after integration. Missing institution fields on the two Medical Student Research Committee entries are deliberately null because those individual CV entries do not explicitly name the institution.

Before creation, all eight preexisting data files were copied and hash-verified into a unique sandbox temporary directory. That directory was not accessible in a later shell session, so a persistent baseline of the seven original record files was also saved and hash-verified at `C:\Users\katta\.codex\visualizations\2026\10\15\01a140a3-9fb5-7f83-9e30-067a3c179c8b\cv-record-baseline-09e05cd0`, outside the public repository. Their hashes still match the initial inventory. All 13 YAML files parsed with R yaml using explicit UTF-8 input; 43 new unique IDs and expected counts were verified. No website/CV render was run.
### Clarified end state (2026-10-15)

Publication clarification: The user confirmed that the current BibTeX files come from Zotero. The eventual goal includes automatic publication updates through ChatGPT. Whether publication records should ultimately be maintained in BibTeX, YAML, or Zotero with generated exports remains undecided. Evaluate the update workflow before choosing the authoritative publication store; do not assume the present BibTeX arrangement is permanent or convert it prematurely. Current YAML-only write authorization remains in force until the user explicitly authorizes a publication integration or a different write scope. Zotero export configuration, ownership, and overwrite behavior still need investigation. After choosing the authoritative store, use a single direction of synchronization and avoid competing authoritative copies.

After the user fixes the repository and its consumers, the intended maintainer is a ChatGPT plugin that updates only the authoritative YAML files in data. Nothing else in the repository should be modified by that workflow: no bibliography edits, website source/style/template edits, CV/output writes, Git operations that change state, or publishing. The user handles those tasks separately. If a YAML update needs a consumer change, explain the dependency for the user to apply; do not broaden the plugin's write scope.

Keep the core reconciliation, maintenance, and validation workflow independent of Codex-specific tools so people using ChatGPT Work without Codex can use it. Treat storage as a separate, explicitly authorized integration. Support direct local-folder maintenance on desktop where available, and investigate persistent storage for web/mobile before promising support. Plugin installation does not imply filesystem access. Prefer an explicit allowlist of approved YAML files and enforce the write boundary in the storage integration where supported, in addition to these behavioral instructions. Adding a new YAML file or expanding that allowlist requires explicit user authorization. The current setup task still authorizes only this AGENTS.md; it does not authorize record changes or plugin implementation.

The user handoff below is the governing project context. Its FIRST TASK describes the initialization stage, not a recurring instruction to redo the inventory. Initialization inventory was performed on 2026-10-15; CV reconciliation and record edits remain pending. Only this AGENTS.md was authorized for modification during setup. Future record changes require a user request and the baseline safeguards below.

No existing applicable AGENTS.md was found in the repository or checked ancestor directories at setup. Recheck applicable instructions when scope changes.

## Verified local inventory (2026-10-15)

- Repository: C:\Users\katta\Desktop\VagishHemmige.github.io
- Working directory and project editing boundary: C:\Users\katta\Desktop\VagishHemmige.github.io\data
- Git origin fetch/push: https://github.com/VagishHemmige/VagishHemmige.github.io.git (matches the expected repository).
- Git status was clean before creating this file. Git access to the parent required an approved read-only command outside the shell sandbox. This does not authorize future permission expansion or any Git mutation.
- Configured filesystem access allows reading the parent repository and writing data, plus a separate visualization workspace and temporary locations. Parent project writes are not permitted. Instructions and enforced permissions are distinct; inspect the actual current environment in future sessions.
- No remote or published content was used as a substitute for local files. Historical ChatGPT conversations were not accessed.

### Sources and outputs

`_quarto.yml` configures a Quarto website with `output-dir: docs`, HTML/Cosmo, and `styles.scss`. Root `.qmd` files, `R/cv.R`, data, styles, CSL, and the original resource folders are sources. `docs` contains generated pages and copied assets matching the configuration. `_site` contains an older-looking partial HTML output (index/about and libraries), but its current production role is unverified. `.quarto` is present and ignored. None of these observations authorize deletion. `README.md` says it is generated from `README.Rmd`.

Resource folders are `abstracts`, `teaching`, `presentations` (including `Invited talks` and `Conferences`), and `images`. Their PDF/PNG/JPG files are original linked resources, not disposable build products. `.gitignore` excludes `/cv/`, `/presentations/raw`, `/abstracts/raw`, `/teaching/raw`, `.Rproj.user`, and `/.quarto/`. Ignored files can still be essential sources. The CV archive directory was empty at inspection.

### Data consumers and current shape

All five YAML files are top-level sequences of mappings. Counts below are top-level record counts, not completeness claims.

| Source in data | Records | Consumers and significant fields |
| --- | ---: | --- |
| abstracts.yml | 35 | abstracts.qmd and mentoring.qmd: title, meeting, city/state, date, type, award, pdf/link, scope, optional mentees list |
| mentoring.yml | 21 | mentoring.qmd: name, level, role, years, status, current, projects, manuscripts, link, text; level/role may be scalars or lists |
| projects.yml | 5 | Projects.qmd: title, theme, description, status, site/repo, methods list |
| talks.yml | 26 | presentation.qmd: title, venue, city/state, date, category, slides/link |
| teaching.yml | 10 | teaching.qmd: title, venue, dates list, target, description, category, slides/link; page derives first year, most recent date and session count |
| VH library.bib | 72 | manuscripts.qmd via RefManageR::ReadBib; mentoring.qmd via ReadBib plus front matter bibliography; contains articles and book chapters |
| VH book chapter library.bib | 72 | No direct consumer found in inspected source; byte-identical to VH library.bib at setup |

Bibliography provenance: README.Rmd explicitly describes Zotero BibTeX exports, and bibliography attachment paths refer to local Zotero storage. No export script, auto-export configuration, collection selection, or Better BibTeX settings were found in inspected project source. Exact export ownership and whether either file is automatically overwritten remain unknown. Do not edit exports until this is resolved. Do not infer a chapter-only role from the second filename. Both files had SHA256 C63F2F6510E576823F8EB6D50B96F39358F9517C31E3DC07CFE68CDCCEB7D601 at setup.

Hard-coded CV-adjacent information: about.qmd contains education/training with institutions and date ranges, interests, methods, speaking topics, mentoring prose, project summaries and contact links. index.qmd contains professional overview, location, highlights, skills and package links. media.qmd contains writing, news and podcast entries and embeds. Projects.qmd and mentoring.qmd also contain introductory collaboration/mentoring prose. These are not fully represented in the data records. Completeness of appointments, service, grants, awards, and other CV sections cannot be assessed until the confirmed CV is reconciled.

### CV infrastructure and baseline candidates

`R/cv.R` loads officer, RefManageR and stringr, reads `cv/Hemmige Einstein CV template.docx`, and writes `cv/Hemmige Einstein CV <Sys.Date()>.docx`. It currently contains no insertion of YAML/BibTeX content. Do not run it: it writes outside data and could overwrite a same-day file. No complete records-to-CV pipeline was found. CV layout and output formats remain undecided; template contents have not yet been inspected.

Observed cv filenames (not yet approved as migration baseline):

- Hemmige Einstein CV 2026-09-04.docx (newest dated full Word candidate by filename)
- Hemmige Einstein CV 2026-03-20.docx
- Hemmige Einstein CV 2026-03-01.docx
- Hemmige CV 2026-03-20.pdf
- Hemmige CV 2026-04-13 short.docx
- Hemmige Einstein CV template.docx
- ~$mmige Einstein CV template.docx (Word temporary/lock-style filename; not a baseline candidate)

Ask the user which full CV is current before reading it as the migration baseline. Do not assume filename dates establish authority.

### Compatibility constraints to preserve

- Root pages read `data/...` paths. Resource paths in YAML are used directly in page links and resolve from root-level pages, not from data; retain paths such as `teaching/...`, `abstracts/...`, and `presentations/...`, including spaces and case.
- Dates are parsed with base R as.Date and grouped with lubridate. Existing strings include unpadded months/days. Teaching uses a dates list rather than one date; do not collapse sessions.
- Presentations render only categories invited, conference, grand_rounds, teaching. Abstracts render oral/poster, with scope badges international/national/regional/local. Mentoring filters exact Active/Former; project badges use lowercase active/completed/paused. Changing values can hide records.
- Preserve nullable fields and scalar/list distinctions. Consumer code supplies some absent optional columns but does not constitute a general schema validator.
- Mentoring manuscripts are BibTeX keys that link to manuscript page anchors. Preserve keys and validate references before changes.
- Abstract-to-mentee relationships match exact names in each abstract's mentees list; one abstract may link multiple mentees. Preserve that single activity record.
- Project references in mentoring are titles, converted to slugs. Abstract slugs derive from title, meeting and year, in both page consumers. Title/date/name changes can break cross-links.
- Existing mentoring project links use lowercase projects.html whereas the source/output name is Projects.qmd/Projects.html. Flag for the user's RStudio correction; do not silently change parent source.
- Projects.qmd groups by title/theme/description/status/site/repo and merges methods. This may mask duplicates; validate source records directly.
- Manuscripts.qmd derives article/chapter sections from journal/booktitle fields in the main library, sorts numeric years, and drops records without a constructed citation. Rendered pages can omit records and are not complete backups.
- Some records and resource filenames have differing year/date text. Treat these as questions, not automatic factual corrections.

### Next stage

Confirm the current CV and bibliography export workflow. Then perform a read-only reconciliation accounting for every entry in the confirmed CV: matched record/key, missing, conflicting, duplicate, or intentionally excluded, with section and source location. Identify information currently hard-coded and propose compatible additions without changing source authority prematurely. Before the first record edit, create a uniquely named recoverable backup in a permitted location, preferably outside the public repository; establish that location and never overwrite an older backup. No record backup was created during setup because no records were changed. After approval of reconciliation/schema decisions, maintain structured records as the authority and provide precise parent Quarto/R edits for the user to apply in RStudio.

## Preserved user handoff

The following preserves the complete setup request and durable preferences. Read temporal instructions in light of the setup status above.
Set up this local project for maintaining Vagish Hemmige’s academic CV and personal Quarto website. Read the context below, inspect the existing project, and create an AGENTS.md in the data folder to preserve these instructions for future chats. Do not change the YAML or bibliography records yet.

PROJECT CONTEXT

This is an existing personal academic website, not a new website to build from scratch. The entire website repository is the project context; the data folder is the agent’s editing boundary.

Full local website repository:
C:\Users\katta\Desktop\VagishHemmige.github.io

Agent working directory and approved editing scope:
C:\Users\katta\Desktop\VagishHemmige.github.io\data

Public website:
https://vagishhemmige.github.io/

Expected GitHub repository:
https://github.com/VagishHemmige/VagishHemmige.github.io

Verify the GitHub URL against the local Git remote. Do not assume the published website or remote repository includes all current local changes.

Related planning and historical conversations are in my ChatGPT project “Github personal page.” This handoff summarizes the working decisions; do not assume you can see those conversations.

GOALS AND SEQUENCE

1. Inventory the existing structured records and website implementation.
2. Reconcile my current CV with those records, accounting for every CV entry.
3. Establish a reproducible way to generate the CV from the structured records, while continuing to use them for the website.
4. Maintain the records through ChatGPT/Codex conversations.
5. Later add standing tasks that check appropriate external sources and ask me about activities that require my input.
6. Eventually package the proven process as a shareable plugin with separate initializer and maintainer workflows.

Do not build the plugin, create scheduled tasks, or redesign the website now. First establish a reliable workflow for my own records.

SOURCE OF TRUTH

- Importing an existing CV into structured records is a one-time initialization workflow.
- After initialization, the flow is strictly structured records → CV and website.
- Do not parse generated CVs back into the records or maintain the CV independently.
- Factual corrections belong in the source records.
- YAMLs should hold the appropriate nonbibliographic CV information.
- Existing BibTeX files may remain authoritative for publications and book chapters. Inspect how they are populated and consumed before proposing conversion or edits.
- Determine whether Zotero exports or another process manages those bibliography files. Avoid edits that would be overwritten by the next export.
- Do not create competing authoritative copies of the same information.
- CV layout and output formats remain to be decided after inspecting the existing CV and implementation.

UNDERSTAND THE WHOLE REPOSITORY

Read and map the parent website repository, including:
- _quarto.yml
- Relevant .qmd files
- R scripts and helper functions
- Styles and templates
- The data and cv folders
- Bibliography files
- Teaching, presentation, abstract, and image resources
- Git configuration and existing changes, using read-only commands

Identify source files versus generated output directories from the configuration and actual usage. Do not assume a directory is disposable based on its name.

Understand how relative paths in the records resolve to files elsewhere in the website repository.

Keep the broader website context when proposing data changes. Do not treat data as a standalone website or initialize a separate Git repository inside it.

DIVISION OF WORK

- The agent maintains structured records inside data.
- I use RStudio to edit files outside data, render the website and CV, review changes, and manage Git commits and publishing.
- I want the agent to update the actual data files directly, without requiring me to copy updated YAMLs back and forth.
- When a data change requires corresponding Quarto or R changes, identify the dependency and provide precise suggested edits for me to apply in RStudio.
- Coordinate incompatible schema changes with those manual edits so the existing website continues to work.
- Prefer small, incremental improvements to the existing site.

ACCESS AND EDITING BOUNDARIES

- Confirm the current working directory and configured filesystem permissions.
- The parent website repository may be read to understand the project.
- Project edits are limited to the data folder unless I explicitly authorize a different scope and the environment permits it.
- Do not edit website source, styles, templates, slides, PDFs, images, or other files outside data.
- Do not run a render that writes into the parent repository.
- Do not push, publish, commit, change branches, rewrite Git history, or expand permissions without explicit authorization.
- Do not delete files, bulk rename files, discard existing changes, or overwrite source documents without explicit authorization.
- Inspect existing changes before editing and preserve unrelated work.
- Before the first record changes, establish a recoverable baseline in a permitted location. Prefer a backup outside the public repository when available; never overwrite an earlier backup.
- Project instructions guide behavior; configured filesystem permissions provide the enforced boundary. Do not describe instructions alone as a sandbox.

DATA DESIGN AND MAINTENANCE

- Build on the existing fields and their Quarto/R consumers.
- Propose incompatible schema changes before applying them.
- Preserve existing facts, useful fields, and relationships.
- Ask focused questions about missing or ambiguous information. Do not invent dates, roles, accomplishments, statuses, or other facts.
- Represent an underlying activity once where practical, even if it appears in multiple website or CV sections.
- Preserve relationships such as multiple mentees associated with one abstract without duplicating the abstract itself.
- Consider stable IDs, explicit statuses, and lightweight provenance where they solve a concrete maintenance problem.
- Distinguish public website content, CV-only content, and private information.
- A visibility field does not protect information stored in a public GitHub repository. Identify an appropriate storage approach before adding private information.
- After edits, validate YAML syntax and relevant required fields, IDs, duplicates, relationships, and compatibility with current consumers.
- Summarize which records changed, why, what was checked, and any questions still unresolved.
- Rendered pages are secondary references and may omit information; they are not complete backups.

KNOWN DATA FILES

The current data folder contains:
- abstracts.yml
- mentoring.yml
- projects.yml
- talks.yml
- teaching.yml
- VH book chapter library.bib
- VH library.bib

Inspect their actual contents and structure before drawing conclusions.

FUTURE PLUGIN

The eventual reusable plugin should have two distinct workflows:
- Initializer: import an existing CV, reconcile it with existing records, resolve ambiguity, establish the schema, and verify complete CV generation.
- Maintainer: update authoritative records through conversations and reviewed source checks, validate changes, and support regeneration of outputs.

Keep reusable instructions, schemas, and templates separate from my personal records. Capture useful lessons as we work, but do not generalize or package the plugin prematurely.

FIRST TASK

1. Read any existing applicable AGENTS.md instructions. If data/AGENTS.md already exists, reconcile these instructions with it rather than blindly replacing it.
2. Perform a read-only inventory of the full repository structure and the relevant YAML, BibTeX, Quarto, and R source.
3. Create or update data/AGENTS.md with these durable instructions and verified project paths. This is the only project-file change authorized at this stage.
4. Report:
   - Which records feed which website pages.
   - How the bibliography files are generated or maintained, or what remains unknown.
   - Which CV-related information is already structured.
   - Which information is hard-coded in website source.
   - Whether any CV-generation infrastructure already exists.
   - Compatibility constraints that matter for future data changes.
5. Inspect filenames in the website’s cv folder and identify candidate source CVs. Ask me to confirm which is current before using one as the migration baseline.
6. Propose the next reconciliation step.

Do not migrate records, change schemas, or modify bibliography entries yet.

