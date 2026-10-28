# Generate the CV as a Word file from the structured records in data/.
# Run from the project root (open the RStudio project first).
# Output goes to cv/, which Git ignores.

library(officer)
library(yaml)
source("R/citations.R")

# ---- Settings ----------------------------------------------------------------

styles_file  <- "cv/cv-styles.docx"  # formatting only; see the styles in Word
private_file <- "cv/private.yml"     # name, address, email: kept out of the public repo

`%||%` <- function(a, b) if (is.null(a)) b else a

read_records <- function(name) {
  yaml::read_yaml(file.path("data", paste0(name, ".yml")), fileEncoding = "UTF-8")
}

# ---- Dates -------------------------------------------------------------------
# Dates in data/ are ISO strings at whatever precision is known:
# "2009", "2012-10" or "2018-04-13". end_date can also be "present" or null.
# Never call as.Date() on them directly.

# "2009" -> "2009"; "2012-10" -> "10/2012"; "2018-04-13" -> "4/13/2018"
cv_date <- function(x) {
  if (is.null(x)) return("")
  if (x == "present") return("present")
  p <- as.integer(strsplit(x, "-", fixed = TRUE)[[1]])
  switch(length(p),
         as.character(p[1]),
         paste0(p[2], "/", p[1]),
         paste0(p[2], "/", p[3], "/", p[1]))
}

# "2002-06" -> "June 2002"
cv_month_year <- function(x) {
  if (is.null(x)) return("")
  p <- as.integer(strsplit(x, "-", fixed = TRUE)[[1]])
  if (length(p) == 1) return(as.character(p))
  paste(month.name[p[2]], p[1])
}

# start and end -> "6/2006-6/2009"; a null end gives "11/1/2026-"
cv_range <- function(start, end) {
  if (is.null(end)) return(paste0(cv_date(start), "-"))
  if (identical(start, end)) return(cv_date(start))
  paste0(cv_date(start), "-", cv_date(end))
}

# Sort oldest first. Ties keep their order in the YAML file.
sort_by_date <- function(records, field = "start_date") {
  records[order(vapply(records, \(r) r[[field]] %||% "", character(1)))]
}

# Report records whose stored date_text no longer matches their dates
check_dates <- function(records, file) {
  for (r in records) {
    if (is.null(r$date_text)) next
    got <- cv_range(r$start_date, r$end_date)
    if (got != r$date_text) {
      message(file, ": ", r$id, " dates give '", got,
              "' but date_text is '", r$date_text, "'")
    }
  }
}

# ---- Building blocks -----------------------------------------------------------

bold <- fp_text_lite(bold = TRUE)
ital <- fp_text_lite(italic = TRUE)

# One entry: date, tab, first line; then detail lines under the text column.
# first can be plain text or a list of ftext() pieces.
add_entry <- function(doc, date, first, details = character(0), first_bold = FALSE) {
  if (is.character(first)) {
    first <- list(ftext(first, if (first_bold) bold else NULL))
  }
  doc <- body_add_fpar(doc, do.call(fpar, c(list(ftext(date), run_tab()), first)),
                       style = "CV Entry")
  for (d in details) {
    if (inherits(d, "fpar")) {
      doc <- body_add_fpar(doc, d, style = "CV Detail")
    } else {
      doc <- body_add_par(doc, d, style = "CV Detail")
    }
  }
  doc
}

# "Bronx, NY", or a location such as "Remote" when there is no city
place <- function(r) {
  if (!is.null(r$city)) paste0(r$city, ", ", r$state) else r$location %||% character(0)
}

# ---- Sections ----------------------------------------------------------------

add_header <- function(doc, p, public = FALSE) {
  doc <- body_add_par(doc, "CURRICULUM VITAE", style = "CV Title")
  doc <- body_add_par(doc, p$name, style = "CV Name")
  if (!public) {
    for (line in p$address) {
      doc <- body_add_fpar(doc, fpar(ftext(line, bold)), style = "CV Contact")
    }
    doc <- body_add_fpar(doc, fpar(hyperlink_ftext(p$email, href = paste0("mailto:", p$email))),
                         style = "CV Contact")
  }
  doc <- body_add_fpar(doc, fpar(hyperlink_ftext(p$website, href = p$website)),
                       style = "CV Contact")
  doc
}

add_education <- function(doc, records) {
  check_dates(records, "education.yml")
  doc <- body_add_par(doc, "Education", style = "CV Section")
  for (r in sort_by_date(records)) {
    degree <- fpar(
      ftext(paste0("Degree: ", r$degree, if (!is.null(r$honors)) " ")),
      ftext(r$honors %||% "", ital),
      ftext(paste0(", ", cv_month_year(r$degree_date)))
    )
    details <- list(place(r), degree)
    if (!is.null(r$major)) details <- c(details, paste0("Major: ", r$major))
    if (!is.null(r$certificates)) {
      details <- c(details, paste("Language certificates in",
                                  paste(r$certificates, collapse = " and in ")))
    }
    doc <- add_entry(doc, cv_range(r$start_date, r$end_date), r$institution,
                     details, first_bold = TRUE)
  }
  doc
}

add_training <- function(doc, records) {
  check_dates(records, "training.yml")
  doc <- body_add_par(doc, "Postgraduate Training", style = "CV Section")
  for (r in sort_by_date(records)) {
    doc <- add_entry(doc, cv_range(r$start_date, r$end_date), r$institution,
                     c(place(r), r$role), first_bold = TRUE)
  }
  doc
}

add_appointments <- function(doc, records) {
  check_dates(records, "appointments.yml")
  # Records listing cv_sections appear only in the sections they name
  keep <- vapply(records, \(r) is.null(r$cv_sections) || "appointments" %in% r$cv_sections,
                 logical(1))
  doc <- body_add_par(doc, "Professional Employment and Hospital Appointments",
                      style = "CV Section")
  for (r in sort_by_date(records[keep])) {
    doc <- add_entry(doc, cv_range(r$start_date, r$end_date), r$title,
                     c(r$institution, place(r)))
  }
  doc
}

add_certifications <- function(doc, records) {
  check_dates(records, "certifications.yml")
  doc <- body_add_par(doc, "Board Certification", style = "CV Section")
  for (r in sort_by_date(records)) {
    doc <- add_entry(doc, cv_range(r$start_date, r$end_date),
                     paste(r$title, r$board, r$specialty, sep = ", "))
  }
  doc
}

add_memberships <- function(doc, records) {
  check_dates(records, "memberships.yml")
  doc <- body_add_par(doc, "Professional Society Membership", style = "CV Section")
  for (r in sort_by_date(records)) {
    doc <- add_entry(doc, cv_range(r$start_date, r$end_date), r$society)
  }
  doc
}

add_honors <- function(doc, records) {
  doc <- body_add_par(doc, "Awards and Honors", style = "CV Section")
  for (r in sort_by_date(records, "date")) {
    doc <- add_entry(doc, cv_date(r$date), r$title,
                     c(r$program, r$institution, place(r)))
  }
  doc
}

# "2006-05-06" -> "May 6, 2006"; less precise dates fall back to "May 2006"
cv_long_date <- function(x) {
  p <- as.integer(strsplit(x, "-", fixed = TRUE)[[1]])
  if (length(p) < 3) return(cv_month_year(x))
  paste0(month.name[p[2]], " ", p[3], ", ", p[1])
}

money <- function(x) {
  paste0("$", formatC(x, format = "f", digits = if (x %% 1 == 0) 0 else 2, big.mark = ","))
}

quoted <- function(x) paste0("\u201c", end_sentence(x), "\u201d")

# Turn **bold** and *italic* marks into formatted Word text
md_pieces <- function(x) {
  parts <- regmatches(x, gregexpr("\\*\\*[^*]+\\*\\*|\\*[^*]+\\*|[^*]+", x))[[1]]
  lapply(parts, function(s) {
    if (startsWith(s, "**")) ftext(gsub("^\\*\\*|\\*\\*$", "", s), bold)
    else if (startsWith(s, "*")) ftext(gsub("^\\*|\\*$", "", s), ital)
    else ftext(s)
  })
}

# Numbered list (bibliography), restarting at 1 for each list
add_numbered <- function(doc, items) {
  for (i in seq_along(items)) {
    pieces <- c(list(ftext(paste0(i, ".")), run_tab()), md_pieces(items[[i]]))
    doc <- body_add_fpar(doc, do.call(fpar, pieces), style = "CV Numbered")
  }
  doc
}

add_service <- function(doc, service, appointments) {
  check_dates(service, "service.yml")
  doc <- body_add_par(doc, "Other Professional Activities", style = "CV Section")
  
  doc <- body_add_par(doc, "Extramural Activities:", style = "CV Subsection")
  extra <- Filter(\(r) r$category == "extramural", service)
  for (r in sort_by_date(extra)) {
    doc <- add_entry(doc, cv_range(r$start_date, r$end_date),
                     list(ftext(paste0(r$role, ", ")), ftext(r$venue, ital)))
  }
  
  doc <- body_add_par(doc, "Intramural Activities:", style = "CV Subsection")
  intra <- Filter(\(r) r$category == "intramural", service)
  # Appointments listed for the service section too (stored once, in appointments.yml)
  shared <- Filter(\(r) "service" %in% r$cv_sections, appointments)
  shared <- lapply(shared, \(r) c(r, list(role = r$title, activity = NULL)))
  for (r in sort_by_date(c(intra, shared))) {
    first <- paste(c(r$role, r$activity), collapse = ", ")
    doc <- add_entry(doc, cv_range(r$start_date, r$end_date), first,
                     c(r$unit, r$institution, place(r)))
  }
  doc
}

add_talks <- function(doc, records) {
  doc <- body_add_par(doc, "Invited Extramural Presentations", style = "CV Section")
  for (r in sort_by_date(records, "date")) {
    where <- paste(c(r$role, r$venue, if (!is.null(r$city)) place(r)), collapse = ", ")
    doc <- add_entry(doc, cv_date(r$date), paste0(where, ". ", quoted(r$title)))
  }
  doc
}

add_grants <- function(doc, records) {
  check_dates(records, "grants.yml")
  doc <- body_add_par(doc, "Research", style = "CV Section")
  doc <- body_add_par(doc, "Grant Support", style = "CV Subsection")
  for (r in sort_by_date(records)) {
    doc <- add_entry(doc, cv_range(r$start_date, r$end_date),
                     paste0(r$sponsor, " ", r$award_number, "."),
                     c(quoted(r$title),
                       paste0("Total support: ", money(r$total_support)),
                       paste0("Role: ", r$role)))
  }
  doc
}

format_abstract <- function(r) {
  kind <- if (r$type == "oral") "Oral presentation" else "Poster presentation"
  where <- paste(c(r$meeting, cv_long_date(r$date), if (!is.null(r$city)) place(r)),
                 collapse = ", ")
  paste(c(if (!is.null(r$authors)) bold_me(end_sentence(r$authors)),
          end_sentence(r$title),
          paste0(kind, " at ", end_sentence(where)),
          if (!is.null(r$award)) end_sentence(paste0("Award: ", r$award))),
        collapse = " ")
}

add_bibliography <- function(doc, pubs, abstracts) {
  doc <- body_add_par(doc, "Bibliography", style = "CV Section")
  
  doc <- body_add_par(doc, "A. Original Contributions in Reviewed Journals:",
                      style = "CV Subsection")
  articles <- pubs[pubs$type == "article", ]
  doc <- add_numbered(doc, lapply(seq_len(nrow(articles)), \(i) format_citation(articles[i, ])))
  
  doc <- body_add_par(doc, "B. Books, Chapters in Books, and Review Articles:",
                      style = "CV Subsection")
  chapters <- pubs[pubs$type == "chapter", ]
  doc <- add_numbered(doc, lapply(seq_len(nrow(chapters)), \(i) format_citation(chapters[i, ])))
  
  doc <- body_add_par(doc, "C. Abstracts:", style = "CV Subsection")
  doc <- add_numbered(doc, lapply(sort_by_date(abstracts, "date"), format_abstract))
  
  doc <- body_add_par(doc, "D. Websites", style = "CV Subsection")
  doc <- body_add_par(doc, paste("See www.github.com/VagishHemmige for a full list of",
                                 "R teaching websites and R packages created."), style = "Normal")
  doc
}

# ---- PDF ---------------------------------------------------------------------
# Word converts the .docx to PDF. The PowerShell code is passed with -Command
# rather than as a .ps1 file, so Windows' "running scripts is disabled" policy
# doesn't block it. Needs Word installed (Windows).

ps_quote <- function(x) paste0("'", gsub("'", "''", x, fixed = TRUE), "'")

docx_to_pdf <- function(docx, pdf) {
  docx <- normalizePath(docx, winslash = "\\", mustWork = TRUE)
  pdf  <- file.path(normalizePath(dirname(pdf), winslash = "\\", mustWork = TRUE),
                    basename(pdf))
  pdf  <- gsub("/", "\\", pdf, fixed = TRUE)
  if (file.exists(pdf)) file.remove(pdf)  # so an old PDF can't pass for a new one

  cmd <- paste(
    "$ErrorActionPreference = 'Stop';",
    "$word = New-Object -ComObject Word.Application;",
    "$word.Visible = $false;",
    "try {",
    "  $doc = $word.Documents.Open(", ps_quote(docx), ", $false, $true);",
    "  $doc.ExportAsFixedFormat(", ps_quote(pdf), ", 17);",  # 17 = PDF
    "  $doc.Close(0)",
    "} finally { $word.Quit(0) }"
  )
  out <- suppressWarnings(system2(
    "powershell", c("-NoProfile", "-NonInteractive", "-Command", shQuote(cmd)),
    stdout = TRUE, stderr = TRUE))
  if (!file.exists(pdf)) {
    stop("Word could not convert ", docx, ":\n", paste(out, collapse = "\n"))
  }
  invisible(pdf)
}

# ---- Build -------------------------------------------------------------------
# Two copies, each as .docx and PDF (the PDF is made by Word):
#   private (full header): cv/Hemmige CV <date>.docx and .pdf, Git-ignored
#   public (no address or email): cv/Hemmige CV <date> public.docx and
#   files/Hemmige-CV.pdf, the copy the website serves

build_cv <- function(public) {
  docx_file <- file.path("cv", paste0("Hemmige CV ", Sys.Date(),
                                      if (public) " public", ".docx"))
  pdf_file  <- if (public) public_pdf else sub("\\.docx$", ".pdf", docx_file)

  doc <- read_docx(styles_file)
  doc <- add_header(doc, private, public = public)
  doc <- add_education(doc, read_records("education"))
  doc <- add_training(doc, read_records("training"))
  doc <- add_appointments(doc, read_records("appointments"))
  doc <- add_certifications(doc, read_records("certifications"))
  doc <- add_memberships(doc, read_records("memberships"))
  doc <- add_honors(doc, read_records("honors"))
  doc <- add_service(doc, read_records("service"), read_records("appointments"))
  doc <- add_talks(doc, read_records("talks"))
  doc <- add_grants(doc, read_records("grants"))
  doc <- add_bibliography(doc, read_publications(), read_records("abstracts"))

  # Remove the empty paragraph the styles file starts with
  doc <- cursor_begin(doc)
  doc <- body_remove(doc)

  print(doc, target = docx_file)
  docx_to_pdf(docx_file, pdf_file)
  message("Wrote ", docx_file, " and ", pdf_file)
}

# Stops if the public PDF contains any address line or the email
check_public_pdf <- function(pdf_file, p) {
  txt  <- paste(pdftools::pdf_text(pdf_file), collapse = "\n")
  priv <- c(p$address, p$email)
  hits <- priv[vapply(priv, grepl, logical(1), x = txt, fixed = TRUE)]
  if (length(hits)) {
    file.remove(pdf_file)
    stop("Private details found in ", pdf_file, " (file deleted): ",
         paste(hits, collapse = "; "))
  }
  message("Checked ", pdf_file, ": no address or email")
}

public_pdf <- "files/Hemmige-CV.pdf"
private    <- yaml::read_yaml(private_file)
dir.create("files", showWarnings = FALSE)

build_cv(public = FALSE)
build_cv(public = TRUE)
check_public_pdf(public_pdf, private)
