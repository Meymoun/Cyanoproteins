

pvalue <- apply(gsa, 1, function(row) phyper(row[1], row[2], row[4], row[3]))


qvalue <- p.adjust(pvals, 'fdr')
gsa <- cbind(gsa, pvalue, qvalue)

phyper(48, 724, 1395, 97) # ??
phyper(48, 97, 1395, 724) # ??
