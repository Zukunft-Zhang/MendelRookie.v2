setwd(MR_WEAK_DIR); cat("Current working directory:", getwd())
exposure_csv_file <- file.path(LD_DIR, "exposure.LD.csv")
F_THRESHOLD <- 10  # F Statistical threshold

# ---Read LD analysis result file
exposure_data <- read.csv(exposure_csv_file, header = TRUE, sep = ",", check.names = FALSE)

# ---Completing columns R² and F
exposure_data$R2 <- TwoSampleMR::get_r_from_bsen(exposure_data$beta.exposure, exposure_data$se.exposure, exposure_data$samplesize.exposure)^2
exposure_data$Fval <- (exposure_data$samplesize.exposure - 2) * exposure_data$R2 / (1 - exposure_data$R2)

# ---Filter tool variables that retain F>10
exposure_data <- exposure_data[exposure_data$F > F_THRESHOLD,]
print(paste("Remaining SNP number", nrow(exposure_data)))
write.csv(exposure_data, "exposure.F.csv", row.names = FALSE); file.create(paste0("exposure.F.csv - F＞", F_THRESHOLD))

rm(list = setdiff(ls(), GLOBAL_VAR))  # Remove useless variables
