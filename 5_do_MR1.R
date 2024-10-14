setwd(MR_DIR); cat("Current working directory:", getwd())
exposure_csv_file <- file.path(MR_CON_DIR, "exposure.confounder.csv")
outcome_file <- file.path(FMT_DIR, paste0(OUTCOME_NAME, "_", OUTCOME_DATA_ID, "_formatted.csv.gz"))


# ---Reading collated exposure data
exposure_data <- read.csv(exposure_csv_file, header = TRUE, sep = ",", check.names = FALSE)

# ---Read the ending data.
outcome_data <- TwoSampleMR::read_outcome_data(  # Note the column names!
  filename = outcome_file, sep = ',',
  snp_col = 'SNP',
  effect_allele_col = 'A1', other_allele_col = 'A2',
  beta_col = 'BETA', se_col = 'SE', eaf_col = 'FRQ', pval_col = 'P'
)

# ---Filter the ending data for intersections with instrumental variables and output to a file.
outcome_table <- merge(exposure_data, outcome_data, by.x = "SNP", by.y = "SNP")
write.csv(outcome_table[, -(2:ncol(exposure_data))], file = "outcome.csv")
rm(outcome_table)

# ---Consolidation of exposure and closure data into one data frame after tagging them
exposure_data$exposure <- EXPOSURE_NAME
outcome_data$outcome <- OUTCOME_NAME
data <- TwoSampleMR::harmonise_data(exposure_data, outcome_data, action = 1)

# ---Output instrumental variables
write.csv(data[data$mr_keep == "TRUE",], file = "SNP.csv", row.names = FALSE)

# ---MR-PRESSO method for outlier detection to get biased SNPs
mr_presso_result <- run_mr_presso(data)
write.csv(mr_presso_result[[1]]$
            `MR-PRESSO results`$
            `Outlier Test`, file = "outlier_SNPs.csv")


# ---Perform Mendelian randomisation analysis
mr_result <- mr(data)
write.csv(generate_odds_ratios(mr_result), file = "MR-Result.csv", row.names = FALSE)

# ---heterogeneity test
write.csv(mr_heterogeneity(data), file = "heterogeneity.csv", row.names = FALSE)

# ---multivariate validity test
write.csv(mr_pleiotropy_test(data), file = "pleiotropy.csv", row.names = FALSE)

# ---drawings
pdf(file = "pic.scatter_plot.pdf", width = 7.5, height = 7); mr_scatter_plot(mr_result, data); dev.off()  # scatterplot
res_single <- mr_singlesnp(data)
pdf(file = "pic.forest.pdf", width = 7, height = 6.5); mr_forest_plot(res_single); dev.off()  # forest plot
pdf(file = "pic.funnel_plot.pdf", width = 7, height = 6.5); mr_funnel_plot(singlesnp_results = res_single); dev.off()  # funnel plot
pdf(file = "pic.leaveoneout.pdf", width = 7, height = 6.5); mr_leaveoneout_plot(leaveoneout_results = mr_leaveoneout(data)); dev.off()  # sensitivity analysis

rm(list = setdiff(ls(), GLOBAL_VAR))  # Remove useless variables
gc()  # Rubbish collection
