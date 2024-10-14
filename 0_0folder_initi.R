# ---GWAS Data exposure factors and outcome abbreviations, identifiers, reference genome identifiers, population categories
EXPOSURE_NAME <- ''     # Data name. 
EXPOSURE_DATA_ID <- ''  # Data identifier. 
EXPOSURE_REFER_ID <- '' # Reference sequence versions used for GWAS data, such as GRCh37, etc.
EXPOSURE_POP <- ''      # Demographic stock identification

OUTCOME_NAME <- ''
OUTCOME_DATA_ID <- ''
OUTCOME_REFER_ID <- ''
OUTCOME_POP <- ''

# Location of datasets used for LD reference in the Thousand Genomes Project
LD_REF <- ''  # Download the http://fileserve.mrcieu.ac.uk/ld/1kg.v3.tgz file and unzip the archive. Ensure that the .bed, .bim and .fam files are available in this directory

# ---The root directory of the analysis results. Must be created manually in advance
root_dir <- ''

# subfolder name
topic <- paste0(EXPOSURE_NAME, '(', EXPOSURE_DATA_ID, ')', '→', OUTCOME_NAME, '(', OUTCOME_DATA_ID, ')')
fmt <- '#_FORMATED_DATA'                   # Data formatting
cor <- '1_correlation_analysis'            # correlation analysis
ld <- '2_linkage_disequilibrium_analysis'  # linkage disequilibrium analysis
mr_weak <- '3_remove_weak_IV'              # Weak instrumental variable rejection
mr_con <- '4_remove_confounder'            # Removal of confounding factors
mr <- '5_do_MR'                            # Mendelian randomisation analysis

# Subfolder Path
FMT_DIR <- file.path(root_dir, fmt)
TOPIC_DIR <- file.path(root_dir, topic)
COR_DIR <- file.path(root_dir, topic, cor)
LD_DIR <- file.path(root_dir, topic, ld)
MR_WEAK_DIR <- file.path(root_dir, topic, mr_weak)
MR_CON_DIR <- file.path(root_dir, topic, mr_con)
MR_DIR <- file.path(root_dir, topic, mr)
dirs <- list(FMT_DIR, TOPIC_DIR, COR_DIR, LD_DIR, MR_WEAK_DIR, MR_CON_DIR, MR_DIR)

# File directory initialised with #confounder_SNPs.txt file
for (dir in dirs) { if (!dir.exists(dir)) { dir.create(dir) } }
confounder_file <- file.path(MR_CON_DIR, '#confounder_SNPs.txt')
if (!file.exists(confounder_file)) { file.create(confounder_file) }

# Remove useless variables
GLOBAL_VAR <- c('EXPOSURE_NAME', 'OUTCOME_NAME',  # Abbreviations for exposure factors and outcomes
                'EXPOSURE_DATA_ID', 'OUTCOME_DATA_ID',  # GWAS data identifier
                'EXPOSURE_REFER_ID', 'OUTCOME_REFER_ID',  # Reference genome identifier
                'EXPOSURE_POP', 'OUTCOME_POP',  # Population category
                'LD_REF',  # Dataset location for LD reference
                'FMT_DIR', 'COR_DIR', 'LD_DIR', 'MR_WEAK_DIR', 'MR_CON_DIR', 'MR_DIR',  # Subfolder Path
                'GLOBAL_VAR')
rm(list = setdiff(ls(), GLOBAL_VAR))
