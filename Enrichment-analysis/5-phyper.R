
pvals <- apply(gsa, 1, function(row) phyper(row[1], row[3], row[4], row[2], 
                                             lower.tail = TRUE)) # default, test depletion

qvals <- p.adjust(pvals, 'fdr')
gsa <- cbind(gsa, pvals, qvals)

#phyper(48, 97, 1395, 724) # ??


pvals2 <- apply(gsa, 1, function(row) phyper(row[1], row[5], row[4], row[2], 
                                             lower.tail = FALSE)) # default, test depletion


qvals2 <- p.adjust(pvals2, 'fdr')
gsa <- cbind(gsa, pvals2, qvals2)


gsa_order <- gsa[order(gsa$qvals2, decreasing = FALSE), ]


sign_enriched <- gsa_order[1:6, 9:10]
