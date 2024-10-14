setwd(FMT_DIR); cat("Current working directory:", getwd())
exposure_file <- ""  # GWAS data, used as exposure factors
outcome_file <- ""   # GWAS data, used as endpoints


# format_gwas_data() start--------------------
format_gwas_data <- function(file, f_fmt,
                             gws_refer_id, exposure_or_outcome_name, exposure_or_outcome_data_id,
                             chromo = '', position = '', eff_allele = '', non_eff_allele = '', beta_val = '', p_val = '',
                             columns_to_remove = c()) {
  formatted_file_name <- paste0(exposure_or_outcome_name, "_", exposure_or_outcome_data_id, "_formatted.csv.gz")
  if (file.exists(formatted_file_name)) {                                       # Skip processing if the formatted file exists
    return(paste0("File already exists：", formatted_file_name, ". Skip formatting ......"))
  } else { cat("Start reading data ......\n") }
  if_rename <- FALSE
  if (f_fmt == "tsv") { data <- readr::read_tsv(file); if_rename <- TRUE }       # Pre-read TSV files and plan to rename columns
  else if (f_fmt == "csv") { data <- readr::read_csv(file); if_rename <- TRUE }  # Pre-reading of CSV files and planned renaming of columns
  else if (f_fmt == "vcf") { data <- file }                                      # VCF files do not require pre-reading
  else { stop(paste0(f_fmt, "This format is not yet supported. Data formatting exception exited!")) }
  if (if_rename) {                                                               # Delete specific columns and rename columns
    data <- data %>%
      select(-one_of(columns_to_remove)) %>%  # Deleting a Specified Column
      select_if(~!all(is.na(.))) %>%          # Delete all columns with NA values
      dplyr::rename(
        CHR = chromo,         # SNP chromosome number
        BP = position,        # Chromosome location of the SNP
        A1 = eff_allele,      # allelic effect
        A2 = non_eff_allele,  # non-effective allele
        BETA = beta_val,      # beta value
        P = p_val             # P-value
      )  # The above 6 columns must be strictly declared
    cat("Pre-read is complete, start formatting ......\n")
  }
  # Delete log files (with ‘_log_’ in the file name)
  for (file in list.files(getwd())) { if (grepl(paste0(exposure_or_outcome_name, "_", exposure_or_outcome_data_id, "_formatted_log_.+\\.txt"), file)) { file.remove(file) } }
  MungeSumstats::format_sumstats(  # Perform formatting
    data,
    ref_genome = gws_refer_id,                            # Reference Genome Identifiers for GWAS
    dbSNP = 155,                                          # dbSNP version number (144 or 155)
    ignore_multi_trait = TRUE,                            # Ignore multiple P-values
    strand_ambig_filter = FALSE,                          # Deletion of SNPs with an unspecified string of genes
    bi_allelic_filter = FALSE,                            # Removal of SNPs for non-binary alleles
    allele_flip_check = FALSE,                            # Check and flip allele orientation against reference genome
    indels = FALSE,                                       # Contains indel variant or not
    nThread = 16,                                         # Number of threads in parallel
    save_path = file.path(FMT_DIR, formatted_file_name),  # Outputting formatted files
    log_mungesumstats_msgs = TRUE,                        # Saving log messages
    log_folder = getwd(),                                 # Log folder save path
  )
  cat(paste0("Formatting is complete:", formatted_file_name, "\n"))
}

# format_gwas_data() end--------------------

# ---Formatting Exposed Data
format_gwas_data(file = exposure_file, f_fmt = "...",
                 gws_refer_id = EXPOSURE_REFER_ID, exposure_or_outcome_name = EXPOSURE_NAME, exposure_or_outcome_data_id = EXPOSURE_DATA_ID,
                 # chromo = "...", position = "...", eff_allele = "...", non_eff_allele = "...", beta_val = "...", p_val = "..."
)

# ---Formatting ending data
format_gwas_data(file = outcome_file, f_fmt = "...",
                 gws_refer_id = OUTCOME_REFER_ID, exposure_or_outcome_name = OUTCOME_NAME, exposure_or_outcome_data_id = OUTCOME_DATA_ID,
                 # chromo = "...", position = "...", eff_allele = "...", non_eff_allele = "...", beta_val = "...", p_val = "...",
)

rm(list = setdiff(ls(), GLOBAL_VAR))  # Remove useless variables
