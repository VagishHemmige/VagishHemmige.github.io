# Stops if the website CV contains your address or email from cv/private.yml.
# Run from the project root after saving files/Hemmige-CV.pdf, before pushing.
# Needs pdftools: install.packages("pdftools")

p    <- yaml::read_yaml("cv/private.yml")
txt  <- paste(pdftools::pdf_text("files/Hemmige-CV.pdf"), collapse = "\n")
priv <- c(p$address, p$email)
hits <- priv[vapply(priv, grepl, logical(1), x = txt, fixed = TRUE)]
if (length(hits)) stop("Private details in files/Hemmige-CV.pdf: ", paste(hits, collapse = "; "))
message("OK: no address or email in files/Hemmige-CV.pdf")
