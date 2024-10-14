setwd(COR_DIR); cat("Current working directory:", getwd())
exposure_csv_file <- file.path(FMT_DIR, paste0(EXPOSURE_NAME, "_", EXPOSURE_DATA_ID, "_formatted.csv.gz"))
P_THRESHOLD <- 5e-05  # Threshold for screening for SNPs (recommended value: 5e-8)
output_fmt <- "png"   # Supported formats: jpg, pdf, tiff, png

# ---Reading data completes the formatted data
exposure_data <- TwoSampleMR::read_exposure_data(  # Note the column names!
  filename = exposure_csv_file, sep = ',',
  snp_col = 'SNP', chr_col = 'CHR', pos_col = 'BP',
  effect_allele_col = 'A1', other_allele_col = 'A2',
  beta_col = 'BETA', se_col = 'SE', eaf_col = 'FRQ', pval_col = 'P',
  samplesize_col = 'N',
)

# ---Completing the samplesize.exposure column if necessary
if (all(is.na(exposure_data$samplesize.exposure))) {
  while (TRUE) {
    num <- readline(prompt = "The samplesize.exposure column is missing, please populate the column with a uniform value based on the data source (web page, MataInfo, literature, etc.):")
    if (grepl("^\\d+\\.?\\d*$", num)) {
      exposure_data$samplesize.exposure <- as.numeric(num)
      message(‘has populated ’, num, ’ into the samplesize.exposure column’)
      break
    } else { stop("Input error! Only numeric types are supported") }
  }
}

# ---Filter out weakly correlated SNPs and output to file
output_data <- subset(exposure_data, pval.exposure < P_THRESHOLD)
cat(paste("Number of remaining SNPs:", nrow(output_data)))
write.csv(output_data, file = 'exposure.pvalue.csv', row.names = FALSE); file.create(paste0("exposure.pvalue.csv - P＜", P_THRESHOLD))

# ---Plotting Manhattan plots: preparing data and plotting outputs
exposure_data <- exposure_data[, c("SNP", "chr.exposure", "pos.exposure", "pval.exposure")]
colnames(exposure_data) <- c("SNP", "CHR", "BP", "pvalue")
CMplot(exposure_data,
       plot.type = "m",  # m：linear Manhattanattan chart
       LOG10 = TRUE, threshold = P_THRESHOLD, threshold.lwd = 3, threshold.lty = 1, signal.cex = 0.2,
       chr.den.col = NULL, cex = 0.2, bin.size = 1e5, ylim = c(0, 50), width = 15, height = 9,
       file.output = TRUE, file = output_fmt, verbose = TRUE
)

rm(list = setdiff(ls(), GLOBAL_VAR))  # Remove useless variables
gc()  # Rubbish collection