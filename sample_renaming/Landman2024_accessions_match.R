library(readxl)
library(tidyr)

setwd("C:/Users/dnagy/OneDrive - Nexus365/Documents/DPhil Clin Medicine/DPhil/GNBSI/Landman")

#longreads with both rerio and dorado basecalling (i.e. duplicated samples)
PRJNA1076692 <- read_excel("Landman_2024_supplementary_table_1.xlsx", sheet = "accession PRJNA1076692")
#short reads (main)
PRJNA1076808 <- read_excel("Landman_2024_supplementary_table_1.xlsx", sheet = "accession PRJNA1076808")
#short reads, 20 odd sequences
PRJNA903550 <- read_excel("Landman_2024_supplementary_table_1.xlsx", sheet = "accession PRJNA903550")

#create a new column in the longread dataset with a unique sample number
PRJNA1076692$sample_unique <- substr(PRJNA1076692$Sample_name, 1,12)
PRJNA1076692$basecaller <- substr(PRJNA1076692$Sample_name, 14, length(PRJNA1076692$Sample_name))
#check with length(unique(PRJNA1076692$sample_unique))

PRJNA1076692_wide <- pivot_wider(PRJNA1076692, names_from =  "basecaller", values_from = c("Accession", "Sample_name" , "MDRO", "Strain", "Collected_by", "Country", "wgmlst_genogroup","MLST sequence type","MLST complex", "MLVA complex", "MLVA type" , "Mec gene", "sccmec_type", "cgmlst_complex_type_(www.cgmlst.org/ncs)","specimen","specimen_class" ,"specimen_submitter", "carba_allel","MIC meropenem (mg/L)"))

PRJNA1076692_essential <- PRJNA1076692[,c("sample_unique","basecaller", "Accession", "MDRO")]
PRJNA1076692_essential_wide <- pivot_wider(PRJNA1076692_essential, names_from =  "basecaller", values_from = c("Accession", "MDRO"))

PRJNA1076692_essential_wide$Accession_short <- vector("character", nrow(PRJNA1076692_essential_wide))
PRJNA1076692_essential_wide$Accession_PRJNA903550 <- vector("character", nrow(PRJNA1076692_essential_wide))
PRJNA1076692_essential_wide$Accession_PRJNA1076808 <- vector("character", nrow(PRJNA1076692_essential_wide))

check_result <- 0
for (i in 1:nrow(PRJNA903550)) {
  for (j in 1:nrow(PRJNA1076692_essential_wide)) {
    if (PRJNA903550$Strain[i] == PRJNA1076692_essential_wide$sample_unique[j]){
      PRJNA1076692_essential_wide$Accession_short[j] <- PRJNA903550$Sample_name[i]
      PRJNA1076692_essential_wide$Accession_PRJNA903550[j] <- PRJNA903550$Sample_name[i]
      check_result <- check_result +1
    }
  }
}
print(check_result)


check_result2 <- 0
for (i in 1:nrow(PRJNA1076808)) {
  for (j in 1:nrow(PRJNA1076692_essential_wide)) {
    if (PRJNA1076808$Strain[i] == PRJNA1076692_essential_wide$sample_unique[j]){
      PRJNA1076692_essential_wide$Accession_short[j] <- PRJNA1076808$Accession[i]
      PRJNA1076692_essential_wide$Accession_PRJNA1076808[j] <- PRJNA1076808$Accession[i]
      check_result2 <- check_result2 +1
    }
  }
}
print(check_result2)

write.table(PRJNA1076692_essential_wide, "landman_accessions_match.tsv", sep = "\t", row.names = FALSE)
write.csv(PRJNA1076692_essential_wide, "landman_accessions_match.csv", row.names = FALSE)

#Get SRRs corresponding to SAMN
filereport_PRJNA1076692 <- read.table("filereport_read_run_PRJNA1076692_tsv.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
filereport_PRJNA1076808 <- read.table("filereport_read_run_PRJNA1076808_tsv.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
filereport_PRJNA903550 <- read.table("filereport_read_run_PRJNA903550_tsv.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)

PRJNA1076692_essential_wide$SRR_dorado <- vector("character", nrow(PRJNA1076692_essential_wide))
PRJNA1076692_essential_wide$SRR_rerio <- vector("character", nrow(PRJNA1076692_essential_wide))
PRJNA1076692_essential_wide$SRR_short <- vector("character", nrow(PRJNA1076692_essential_wide))


#Add long-read SRRs
for (i in 1:nrow(PRJNA1076692_essential_wide)){
  for (j in 1:nrow(filereport_PRJNA1076692)) {
    if (PRJNA1076692_essential_wide$Accession_dorado[i] == filereport_PRJNA1076692$sample_accession[j] ) {
      PRJNA1076692_essential_wide$SRR_dorado[i] <- filereport_PRJNA1076692$run_accession[j]
    }
    if (PRJNA1076692_essential_wide$Accession_rerio[i] == filereport_PRJNA1076692$sample_accession[j] ) {
      PRJNA1076692_essential_wide$SRR_rerio[i] <- filereport_PRJNA1076692$run_accession[j]
    }
  }  
}

#Add short-read SRRs:
for (i in 1:nrow(PRJNA1076692_essential_wide)){
  for (j in 1:nrow(filereport_PRJNA1076808)) {
    if (PRJNA1076692_essential_wide$Accession_short[i] == filereport_PRJNA1076808$sample_accession[j] ) {
      PRJNA1076692_essential_wide$SRR_short[i] <- filereport_PRJNA1076808$run_accession[j]
    }
  }  
}

for (i in 1:nrow(PRJNA1076692_essential_wide)){
  for (j in 1:nrow(filereport_PRJNA903550)) {
    if (PRJNA1076692_essential_wide$Accession_short[i] == filereport_PRJNA903550$sample_accession[j] ) {
      PRJNA1076692_essential_wide$SRR_short[i] <- filereport_PRJNA903550$run_accession[j]
    }
  }  
}


PRJNA1076692_essential_wide$empty <- vector("character", nrow(PRJNA1076692_essential_wide))
write.table(PRJNA1076692_essential_wide, "SRR_SAMN_accessions_match.tsv", sep = "\t", row.names = FALSE)
write.csv(PRJNA1076692_essential_wide, "SRR_SAMN_accessions_match.csv", row.names = FALSE)