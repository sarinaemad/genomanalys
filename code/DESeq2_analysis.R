#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)
BHI_DIR <- args[1]  # Path to BHI counts directory
SERUM_DIR <- args[2]  # Path to Serum counts directory

library(DESeq2)

BHI_counts <- list.files(BHI_DIR, pattern = "*.txt", full.names = TRUE)
SERUM_counts <- list.files(SERUM_DIR, pattern = "*.txt", full.names = TRUE)

BHI_data <- lapply(BHI_counts, read.table, header = TRUE, row.names = 1)
SERUM_data <- lapply(SERUM_counts, read.table, header = TRUE, row.names = 1)

BHI_df <- do.call(cbind, BHI_data)
SERUM_df <- do.call(cbind, SERUM_data)

cat("BHI count data dimensions: ", dim(BHI_df), "\n")
cat("SERUM count data dimensions: ", dim(SERUM_df), "\n")

countData <- cbind(BHI_df, SERUM_df)

colData <- DataFrame(condition = c(rep("BHI", ncol(BHI_df)), rep("Serum", ncol(SERUM_df))))

stopifnot(ncol(countData) == nrow(colData))

dds <- DESeqDataSetFromMatrix(countData = countData,
                              colData = colData,
                              design = ~ condition)

dds <- DESeq(dds)
library(pheatmap)
library(RColorBrewer)

output_dir <- "/home/saem4348/genomanalys/analyses/8_expression_analysis"
dir.create(output_dir, showWarnings = FALSE)

res <- results(dds)

res_filtered <- res[which(res$padj < 0.001), ]

res_sorted <- res_filtered[order(res_filtered$padj), ]

write.csv(as.data.frame(res), file = file.path(output_dir, "DESeq2_results_BHI_vs_Serum_ALL.csv"))

write.csv(as.data.frame(res_sorted), file = file.path(output_dir, "DESeq2_results_BHI_vs_Serum_significant.csv"))

top50 <- head(res_sorted[order(abs(res_sorted$log2FoldChange), decreasing = TRUE), ], 50)
write.csv(as.data.frame(top50), file = file.path(output_dir, "Top50_DEGs_log2FC.csv"))

