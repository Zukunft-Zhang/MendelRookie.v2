# Mendelian randomisation analysis (MR)
The basic principle of Mendelian Randomization (MR) is:
Based on the results of the GWAS, randomly assigned genetic variants (i.e. SNPs) were introduced as a randomisation tool (instrumental variable (IV)) in place of exposure factors.

- On the one hand, the assignment of subjects, order and samples is randomised and random-induced errors, treatment effects and sample bias are eliminated;
- On the other hand, the use of instrumental variables rather than exposure factors circumvents the effects of confounders and reverse causation and greatly reduces the likelihood that the results will be influenced by unknown factors.

Thus, the introduction of instrumental variables in MR helped to reveal the causal relationship between exposure factors and outcomes and ensured the reliability of the findings.

## Description of the project document

- `README.md`:This document, the project description document
- `#_env_init.R`:Loading project dependencies
- `#_subsetting`:Extract subsets from datasets for debugging projects
- `0_0folder_init.R`:Initialise folders for each Mendelian randomisation analysis
- `0_1data_formating.R`:Formatting GWAS data using `MungeSumstats::format_sumstats()` for subsequent analysis
- `1_correlation_analysis.R`:Screening SNPs based on association
- `2_linkage_disequilibrium_analysis.R`:Screening SNPs based on linkage disequilibrium
- `3_remove_weak_IV.R`:Screening SNPs based on F-statistics
- `4_remove_confounder.R`:Remove SNPs that may cause confounding
- `5_do_MR1.R`:Perform a Mendelian Randomisation analysis.
- `5_do_MR2.R`:Plotting the results of Mendelian randomisation

## open source protocol

This project uses the GNU protocol, see [LICENSE](https://github.com/TullyMonster/MendelRookie/blob/master/LICENSE) for details.

## Frequently Asked Questions and Possible Solutions

### Get the `FastTraitR` and `FastDownloader` packages.

The `FastTraitR` and `FastDownloader` packages for removing confounders are provided by [Medical Research](https://www.medicineitlab.com/).
For more information, see [`FastDownloader` installation tutorial
](https://flash0926.yuque.com/org-wiki-flash0926-kivyu0/otdnsb/tluzaguvye4t9l08).

|                  | Windows OS                                                         | Unix-like OS                                                                 |
|------------------|--------------------------------------------------------------------|------------------------------------------------------------------------------|
| `FastDownloader` | [FastDownloader-WindowsOS.zip](annex/FastDownloader-WindowsOS.zip) | [FastDownloader-Unix-likeOS.tar.gz](annex/FastDownloader-Unix-likeOS.tar.gz) |
| `FastTraitR`     | `FastDownloader::install_pkg("FastTraitR")`                        | `FastDownloader::install_pkg("FastTraitR")`                                  |

### PLINK Binary Installation

The `plinkbinr` package already contains the PLINK binaries for each OS, so projects **generally do not need to download additional **PLINK programs.

However, if you want to specify the location of the PLINK program, you can get it from [PLINK 1.9 home](https://www.cog-genomics.org/plink/).

## Session Information


```
R version 4.3.3 (2024-02-29 ucrt)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows 8 x64 (build 9200)

Matrix products: default


locale:
[1] LC_COLLATE=Chinese (Simplified)_China.936 
[2] LC_CTYPE=Chinese (Simplified)_China.936   
[3] LC_MONETARY=Chinese (Simplified)_China.936
[4] LC_NUMERIC=C                              
[5] LC_TIME=Chinese (Simplified)_China.936    

time zone: Asia/Shanghai
tzcode source: internal

attached base packages:
[1] stats4    stats     graphics  grDevices utils     datasets 
[7] methods   base     

other attached packages:
 [1] GenomicFiles_1.38.0                     
 [2] BiocParallel_1.36.0                     
 [3] MungeSumstats_1.10.1                    
 [4] lubridate_1.9.3                         
 [5] forcats_1.0.0                           
 [6] stringr_1.5.1                           
 [7] purrr_1.0.2                             
 [8] readr_2.1.5                             
 [9] tibble_3.2.1                            
[10] tidyverse_2.0.0                         
[11] SNPlocs.Hsapiens.dbSNP155.GRCh38_0.99.24
[12] SNPlocs.Hsapiens.dbSNP155.GRCh37_0.99.24
[13] BSgenome_1.70.2                         
[14] rtracklayer_1.62.0                      
[15] BiocIO_1.12.0                           
[16] MRPRESSO_1.0                            
[17] FastTraitR_1.0.0                        
[18] FastDownloader_1.0.0                    
[19] plinkbinr_0.0.0.9000                    
[20] friendly2MR_0.2.0                       
[21] cowplot_1.1.3                           
[22] ggfunnel_0.1.0                          
[23] ggforestplot_0.1.0                      
[24] ggplot2_3.5.0                           
[25] LDlinkR_1.4.0                           
[26] MendelianRandomization_0.9.0            
[27] TwoSampleMR_0.5.11                      
[28] CMplot_4.5.1                            
[29] tidyr_1.3.1                             
[30] dplyr_1.1.4                             
[31] gwasglue_0.0.0.9000                     
[32] ieugwasr_0.2.2-9000                     
[33] gwasvcf_0.1.2                           
[34] VariantAnnotation_1.48.1                
[35] Rsamtools_2.18.0                        
[36] Biostrings_2.70.3                       
[37] XVector_0.42.0                          
[38] SummarizedExperiment_1.32.0             
[39] Biobase_2.62.0                          
[40] GenomicRanges_1.54.1                    
[41] GenomeInfoDb_1.38.8                     
[42] IRanges_2.36.0                          
[43] S4Vectors_0.40.2                        
[44] MatrixGenerics_1.14.0                   
[45] matrixStats_1.2.0                       
[46] BiocGenerics_0.48.1                     

loaded via a namespace (and not attached):
  [1] splines_4.3.3            later_1.3.2             
  [3] bitops_1.0-7             filelock_1.0.3          
  [5] R.oo_1.26.0              XML_3.99-0.16.1         
  [7] lifecycle_1.0.4          lattice_0.22-6          
  [9] MASS_7.3-60.0.1          backports_1.4.1         
 [11] magrittr_2.0.3           openxlsx_4.2.5.2        
 [13] plotly_4.10.4            rmarkdown_2.26          
 [15] yaml_2.3.8               remotes_2.5.0           
 [17] httpuv_1.6.15            zip_2.3.1               
 [19] sessioninfo_1.2.2        pkgbuild_1.4.4          
 [21] DBI_1.2.2                abind_1.4-5             
 [23] pkgload_1.3.4            zlibbioc_1.48.2         
 [25] R.utils_2.12.3           RCurl_1.98-1.14         
 [27] rappdirs_0.3.3           GenomeInfoDbData_1.2.11 
 [29] MatrixModels_0.5-3       codetools_0.2-20        
 [31] DelayedArray_0.28.0      xml2_1.3.6              
 [33] tidyselect_1.2.1         shape_1.4.6.1           
 [35] gmp_0.7-4                BiocFileCache_2.10.2    
 [37] GenomicAlignments_1.38.2 jsonlite_1.8.8          
 [39] ellipsis_0.3.2           survival_3.5-8          
 [41] iterators_1.0.14         foreach_1.5.2           
 [43] tools_4.3.3              progress_1.2.3          
 [45] Rcpp_1.0.12              glue_1.7.0              
 [47] SparseArray_1.2.4        xfun_0.43               
 [49] usethis_2.2.3            withr_3.0.0             
 [51] numDeriv_2016.8-1.1      BiocManager_1.30.22     
 [53] fastmap_1.1.1            fansi_1.0.6             
 [55] SparseM_1.81             digest_0.6.35           
 [57] timechange_0.3.0         R6_2.5.1                
 [59] mime_0.12                colorspace_2.1-0        
 [61] arrangements_1.1.9       biomaRt_2.58.2          
 [63] RSQLite_2.3.6            R.methodsS3_1.8.2       
 [65] utf8_1.2.4               generics_0.1.3          
 [67] data.table_1.15.4        robustbase_0.99-2       
 [69] prettyunits_1.2.0        httr_1.4.7              
 [71] htmlwidgets_1.6.4        S4Arrays_1.2.1          
 [73] pkgconfig_2.0.3          gtable_0.3.4            
 [75] blob_1.2.4               htmltools_0.5.8.1       
 [77] profvis_0.3.8            scales_1.3.0            
 [79] png_0.1-8                knitr_1.46              
 [81] tzdb_0.4.0               rjson_0.2.21            
 [83] curl_5.2.1               cachem_1.0.8            
 [85] parallel_4.3.3           miniUI_0.1.1.1          
 [87] AnnotationDbi_1.64.1     restfulr_0.0.15         
 [89] pillar_1.9.0             grid_4.3.3              
 [91] vctrs_0.6.5              urlchecker_1.0.1        
 [93] promises_1.3.0           dbplyr_2.5.0            
 [95] xtable_1.8-4             evaluate_0.23           
 [97] GenomicFeatures_1.54.4   cli_3.6.2               
 [99] compiler_4.3.3           rlang_1.1.3             
[101] crayon_1.5.2             fs_1.6.3                
[103] stringi_1.8.3            viridisLite_0.4.2       
[105] assertthat_0.2.1         munsell_0.5.1           
[107] lazyeval_0.2.2           devtools_2.4.5          
[109] glmnet_4.1-8             quantreg_5.97           
[111] Matrix_1.6-5             hms_1.1.3               
[113] bit64_4.0.5              KEGGREST_1.42.0         
[115] shiny_1.8.1.1            googleAuthR_2.0.1       
[117] iterpc_0.4.2             gargle_1.5.2            
[119] broom_1.0.5              memoise_2.0.1           
[121] DEoptimR_1.1-3           bit_4.0.5
```

# Acknowledgements   
The project is an English version of [MendelRookie](https://github.com/TullyMonster/MendelRookie). We are deeply appreciative of the open-source ethos that [TullyMonster](https://github.com/TullyMonster) and his team have exemplified. Their willingness to share their valuable scripts and tutorials not only fosters a collaborative environment but also accelerates scientific progress by making cutting-edge methods accessible to a broader audience. This spirit of generosity and commitment to knowledge sharing is truly commendable and has undoubtedly enriched the research community. We are inspired by their dedication to promoting transparency and collaboration, which are cornerstones of the open-source movement. Their work serves as a beacon for others to follow, encouraging a culture where innovation thrives on the free exchange of ideas and resources.

# Contact Us    
We have made minor refinements to the project code by [TullyMonster](https://github.com/TullyMonster) , which now enables a more precise analysis of the potential causal relationships between the rumen microbial communities and fat deposition phenotypes in 1150 sheep. This study is currently being submitted to [npj Biofilms and Microbiomes](https://www.nature.com/npjbiofilms/). 
If you are interested in this research or have any questions, we cordially invite you to get in touch with us. We are extremely enthusiastic about sharing our data and code resources to foster open communication and collaboration within our community. Additionally, to facilitate smooth interaction, we have established a Tencent QQ group named "HandsomeSheepMicrobiome" and look forward to engaging in in-depth discussions with you.
- corresponding author: wangweimin@lzu.edu.cn
- First author: zhangyukun.lzu@foxmail.com
- Tencent QQ group: 599070608 (Group Name: HandsomeSheepMicrobiome)
