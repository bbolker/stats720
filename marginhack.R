cc <- commandArgs(trailingOnly = TRUE)
search_range <- 4
fn <- cc[1]
invisible(file.copy(fn, paste0(fn, ".bak"), overwrite = TRUE))
r <- readLines(fn)
caption_locs <- grep("\\caption", r)
if (length(caption_locs) > 0 ) {
    for (L in caption_locs) {
        rng <- L:(L+search_range)
        r[rng] <- gsub("\\marginpar", "\\marginnote", r[rng])
    }
}
writeLines(r, fn)
