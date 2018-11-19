# libraries and dependiencies

library(visdat)
library(data.table)
library(dplyr)

sourceDir <- function(path, ...) {
  for (nm in list.files(path, pattern = "\\.[RrSsQq]$")) {
    source(file.path(path, nm), ...)
  }
}
sourceDir(path = "usefulR")

# load data
df <- importProteins(file = "data/proteins_table.txt",
                     quant_cols_regex = "^Set[A-Z]_tmt10plex_1[2,3][0-9][N,C]?$",
                     protein_id_col = "Protein accession")

# explore
vis_dat(x = df,
        warn_large_data = FALSE)

vis_miss(x = df,
         warn_large_data = FALSE,
         cluster = TRUE)

vis_compare()

vis_expect(df, ~.x >= 10)

df %>%
  select(matches("^Set[A-Z]_tmt10plex_1[2,3][0-9][N,C]?$")) %>%
  vis_cor(na_action = "complete.obs")

vis_guess(df)
