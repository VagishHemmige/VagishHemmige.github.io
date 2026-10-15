# Helpers for the publications in data/VH library.bib (the Zotero export).
# Used by R/cv.R; manuscripts.qmd can use them too, so both format
# publications the same way.

library(RefManageR)

# Zotero writes some LaTeX: {{protected}} words, accents such as Na\"ive,
# \& and -- for a dash. Turn it into plain text.
latex_to_text <- function(x) {
  if (is.null(x) || length(x) == 0) return(x)
  accents <- c(
    '\\"a' = "ä", '\\"e' = "ë", '\\"i' = "ï", '\\"o' = "ö", '\\"u' = "ü",
    "\\'a" = "á", "\\'e" = "é", "\\'i" = "í", "\\'o" = "ó", "\\'u" = "ú",
    "\\`a" = "à", "\\`e" = "è", "\\~n" = "ñ", "\\c c" = "ç", "\\c{c}" = "ç"
  )
  x <- gsub("\\{\\\\(.)\\{?([a-z])\\}?\\}", "\\\\\\1\\2", x)  # {\"i} or {\"{i}} -> \"i
  x <- gsub("\\\\([\"'`~])\\{([a-z])\\}", "\\\\\\1\\2", x)    # \"{i} -> \"i
  for (a in names(accents)) x <- gsub(a, accents[[a]], x, fixed = TRUE)
  x <- gsub("\\&", "&", x, fixed = TRUE)
  x <- gsub("---", "—", x, fixed = TRUE)
  x <- gsub("--", "–", x, fixed = TRUE)
  x <- gsub("[{}]", "", x)
  if (any(grepl("\\", x, fixed = TRUE))) {
    message("LaTeX left in text: ", paste(x[grepl("\\", x, fixed = TRUE)], collapse = " | "))
  }
  x
}

# "Diane S." "Lauderdale" -> "Lauderdale DS". Group authors keep their name.
vancouver_name <- function(given, family) {
  family <- latex_to_text(paste(family, collapse = " "))
  if (is.null(given) || length(given) == 0) return(family)
  parts <- unlist(strsplit(latex_to_text(given), "[ .-]+"))
  parts <- parts[parts != ""]
  paste(family, toupper(paste(substr(parts, 1, 1), collapse = "")))
}

vancouver_names <- function(people) {
  if (is.null(people) || length(people) == 0) return(NA_character_)
  paste(vapply(unclass(people), \(p) vancouver_name(p$given, p$family), character(1)),
        collapse = ", ")
}

# Add a full stop unless the text already ends in . ? or !
end_sentence <- function(x) if (grepl("[.?!]$", x)) x else paste0(x, ".")

field <- function(entry, name) {
  v <- entry[[name]]
  if (is.null(v) || length(v) == 0) NA_character_ else latex_to_text(paste(v, collapse = " "))
}

# One row per publication, oldest first.
read_publications <- function(file = "data/VH library.bib") {
  refs <- ReadBib(file, check = FALSE)
  rows <- lapply(names(refs), function(key) {
    e <- unclass(refs[[key]])[[1]]
    month <- tolower(substr(field(e, "month"), 1, 3))
    data.frame(
      key       = key,
      type      = if (tolower(attr(e, "bibtype")) == "article") "article" else "chapter",
      authors   = vancouver_names(e$author),
      editors   = vancouver_names(e$editor),
      title     = sub("\\.$", "", field(e, "title")),
      # Drop "...: An Official Publication of ..." subtitles from journal names
      journal   = sub("\\s*:\\s*(an |the )?official .*$", "", field(e, "journal"),
                      ignore.case = TRUE),
      booktitle = field(e, "booktitle"),
      publisher = field(e, "publisher"),
      address   = field(e, "address"),
      year      = suppressWarnings(as.integer(field(e, "year"))),
      month     = match(month, tolower(month.abb)),
      volume    = field(e, "volume"),
      number    = field(e, "number"),
      pages     = gsub("–|-+", "-", field(e, "pages")),
      doi       = field(e, "doi")
    )
  })
  pubs <- do.call(rbind, rows)
  pubs[order(pubs$year, pubs$month, pubs$key, na.last = TRUE), ]
}

# Mark my name in bold, Markdown style: "Hemmige VS" -> "**Hemmige VS**"
bold_me <- function(x) gsub("\\b(Hemmige VS?)\\b", "**\\1**", x)

# Citation in a Vancouver-like style, with Markdown marks:
# my name in **bold** and the journal or book title in *italics*.
format_citation <- function(p) {
  has <- \(x) !is.na(x) && x != ""
  out <- c(if (has(p$authors)) bold_me(end_sentence(p$authors)), end_sentence(p$title))
  if (p$type == "article") {
    src <- paste0("*", p$journal, "*. ", p$year)
    if (has(p$volume)) {
      src <- paste0(src, ";", p$volume, if (has(p$number)) paste0("(", p$number, ")"))
    }
    if (has(p$pages)) src <- paste0(src, ":", p$pages)
    out <- c(out, end_sentence(src))
    # Online-first papers have no volume yet; the DOI identifies them
    if (!has(p$volume) && has(p$doi)) out <- c(out, paste0("doi:", p$doi))
  } else {
    if (has(p$editors)) out <- c(out, paste0("In: ", p$editors, ", editors."))
    else out <- c(out, "In:")
    out <- c(out, paste0("*", p$booktitle, "*."))
    pub <- paste0(if (has(p$address)) paste0(p$address, ": "),
                  if (has(p$publisher)) paste0(p$publisher, "; "), p$year)
    out <- c(out, end_sentence(pub))
    if (has(p$pages)) out <- c(out, paste0("p. ", p$pages, "."))
  }
  paste(out, collapse = " ")
}