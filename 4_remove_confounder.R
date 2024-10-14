setwd(MR_CON_DIR); cat("Current working directory:", getwd())
exposure_csv_file <- file.path(MR_WEAK_DIR, "exposure.F.csv")

# ---Read the result file with the weak instrumental variables removed
exposure_data <- read.csv(exposure_csv_file, header = TRUE, sep = ",", check.names = FALSE)

# Get the current tool variable phenotype and save it to a file
snp_with_trait <- FastTraitR::look_trait(rsids = exposure_data$SNP, out_file = 'check_SNPs_trait.csv')
snp_with_trait_save <- snp_with_trait %>%
  arrange(trait) %>%
  select(trait) %>%
  distinct()  # Instrumental Variable Phenotype De-replication
writeLines(snp_with_trait_save$trait, 'check_SNPs_trait.txt')  # Save to file
print(paste("The phenotype descriptions of the currently filtered SNPs are saved in the check_SNPs_trait.txt file, separated by rows."))

# ----👇Manual collation of the list of confounders----
message(paste0("See if the phenotypes in the check_SNPs_trait.txt file are confounders for [", EXPOSURE_NAME, " → ", OUTCOME_NAME, "], \n save the confounders to the . /4_remove_confounder/#confounder_SNPs.txt file!"))
if (file.info("#confounder_SNPs.txt")$size == 0) { stop("Please manually collate the confounder list file #confounder_SNPs.txt!") }
# ----☝️Manual collation of the list of confounders----

# ---Compares and rejects SNPs for phrases contained in text files and saves them to file
confounders <- readLines("#confounder_SNPs.txt")
snp_with_trait$trait <- tolower(snp_with_trait$trait)  # Ensure that the trait column text is all lowercase
for (confounder in confounders) {
  snp_with_trait <- snp_with_trait[!grepl(tolower(confounder), snp_with_trait$trait),]
}
snp_with_trait <- dplyr::distinct(snp_with_trait, rsid, .keep_all = FALSE)  # remove redundancies
exposure_data <- exposure_data %>%
  dplyr::inner_join(snp_with_trait, by = c("SNP" = "rsid")) %>%
  dplyr::select(names(exposure_data))
print(paste("Number of SNPs remaining after removing confounders", nrow(exposure_data)))
print(paste("Number of remaining SNPs", nrow(exposure_data)))
write.csv(exposure_data, "exposure.confounder.csv", row.names = FALSE)

rm(list = setdiff(ls(), GLOBAL_VAR))  #  Remove useless variables
