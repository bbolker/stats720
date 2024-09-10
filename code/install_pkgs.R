do_cmdstan <- FALSE
download.file("https://raw.githubusercontent.com/bbolker/stats720/main/code/pkg_list.txt", dest = "pkg_list.txt")
pkgs <- scan("pkg_list.txt", what = character())
i1 <- installed.packages()
pkgs <- setdiff(pkgs, rownames(i1))
install.packages(pkgs, repos = "https://cloud.r-project.org")
if (do_cmdstan) {
   install.packages("cmdstanr", repos = c('https://stan-dev.r-universe.dev', getOption("repos")))
   cmdstanr::install_cmdstan()
}
