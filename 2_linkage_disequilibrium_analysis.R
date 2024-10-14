setwd(LD_DIR); cat("Current working directory:", getwd())
exposure_csv_file <- file.path(COR_DIR, "exposure.pvalue.csv")
CLUMP_KB <- 500  # Clumping window, default is 10000.
CLUMP_R2 <- 0.1  # Clumping r2 cutoff. Note that this default value has recently changed from 0.01 to 0.001.
# ---Read exposed data
exposure_data <- read.csv(exposure_csv_file, header = TRUE, sep = ",", check.names = FALSE)

# ---Remove interlocking unbalanced SNPs and save
unclump_snps <- ieugwasr::ld_clump(dat = dplyr::tibble(rsid = exposure_data$SNP, pval = exposure_data$pval.exposure, id = exposure_data$id.exposure),
                                   clump_kb = CLUMP_KB,
                                   clump_r2 = CLUMP_R2,
                                   plink_bin = get_plink_exe(),
                                   bfile = file.path(LD_REF, EXPOSURE_POP))
exposure_data <- exposure_data %>%
  dplyr::inner_join(unclump_snps, by = c("SNP" = "rsid")) %>%
  dplyr::select(names(.))
print(paste("Remaining number", nrow(exposure_data)))
write.csv(exposure_data, file = "exposure.LD.csv", row.names = FALSE); file.create(paste0("exposure.LD.csv - ", CLUMP_KB, " kb, ", CLUMP_R2, "R²"))

rm(list = setdiff(ls(), GLOBAL_VAR))  # Remove useless variables
