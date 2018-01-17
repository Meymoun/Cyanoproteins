pvals <- apply(gsa, 1, function(row) phyper(
  row[1]-1, row[5], row[4], row[2], 
  lower.tail = FALSE)) # TRUE = test depletion, FALSE = test enrichment

qvals <- p.adjust(pvals2, 'fdr')
enrichment_analysis <- cbind(enrichment_analysis, pvals, qvals)

# overview of all 
enrichment_analysis_order <- enrichment_analysis[order(
  enrichment_analysis$qvals, decreasing = FALSE), ]

# select q-values < 0.05
significant_enriched <- enrichment_analysis[enrichment_analysis$qvals < 0.05, ]