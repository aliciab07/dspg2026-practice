# Set up Git 

install.packages("usethis")
library(usethis)

git_sitrep()

use_git_config(
  user.name = "Alicia Bacani",
  user.email = "aliciabacani07@gmail.com", 
  core.editor = "nano" 
)

git_default_branch_configure()

use_git()
