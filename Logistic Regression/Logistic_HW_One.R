# Needed Libraries for Analysis #
library(MASS)
library(visreg)
library(brglm)
library(car)
library(mgcv)
library(haven)
library(unbalanced)
library(multcomp)
library(dplyr)
library(stats)
library(vcdExtra)
library(DescTools)

# read data
ins_t <- haven::read_sas("/Users/thomasgow/Documents/IAA/Logistic Regression/Homework1_LR-2/insurance_t.sas7bdat")

# summary of variables
str(ins_t)

# Defining type of each variable
ins_t_cont <- dplyr::select(ins_t,"ACCTAGE", "DDABAL","DEP", "DEPAMT", "CHECKS", "NSFAMT",
                            "PHONE", "TELLER", "SAVBAL", "ATMAMT", "POSAMT", "CDBAL",
                            "IRABAL", "LOCBAL", "INVBAL", "ILSBAL", "MMBAL", "MTGBAL",
                            "CCBAL", "INCOME", "LORES", "HMVAL", "AGE", "CRSCORE",
                            "POS")

ins_t_bin <- dplyr::select(ins_t,"DDA", "DIRDEP", "NSF", "SAV", "ATM", "CD", "IRA", "LOC",
                           "INV", "ILS", "MM", "MTG", "CC", "SDB", "HMOWN", "MOVED",
                           "INAREA")

ins_t_ord <- dplyr::select(ins_t,"CASHBK", "MMCRED", "CCPURC")

ins_t_nom <- dplyr::select(ins_t,"BRANCH", "RES")


# Variable Relationships with INS - Binary
MH <- NULL
bin_name <- colnames(ins_t_bin)

# Loop through CHMtest
# Mensil Henzal test
# Input is the table of target variable and table of predictor variable
for(i in 1:length(bin_name)){
  MH[i] <- vcdExtra::CMHtest(table(ins_t$INS, ins_t[[i]]))$table[1,3]
}

data.frame(bin_name, MH)

MH_df <- dplyr::arrange(data.frame(bin_name, MH), MH)

# Odds Ratio
OR <- NULL

# Loop through OddRatio
# Input is the table of target variable and table of predictor variable
for(i in 1:length(bin_name)){
  OR[i] <- OddsRatio(table(ins_t$INS, ins_t_bin[[i]]))
}

OR_df <- dplyr::arrange(data.frame(bin_name, OR), desc(OR))


# Variable Relationships with INS - Ordinal
MM_O <- NULL
ord_name <- colnames(ins_t_ord)

# Loop through CHMtest
# Mensil Henzal test
# Input is the table of target variable and table of predictor variable
for (i in 1:length(ord_name)) {
  MM_O[i] <- vcdExtra::CMHtest(table(ins_t$INS, ins_t_ord[[i]]))$table[1,3]
}

MH_O_df <- dplyr::arrange(data.frame(ord_name, MM_O), MM_O)

# Fisher test
fisher.test(table(ins_t$INS, ins_t_ord$CASHBK))
fisher.test(table(ins_t$INS, ins_t_ord$MMCRED))


# Variable Relationships with INS - Nominal
chisq <- NULL
nom_name <- colnames(ins_t_nom)

# Loop through CHMtest
# Chi sq
# Input is the table of target variable and table of predictor variable
for(i in 1:length(nom_name)){
  chisq[i] <- vcd::assocstats(table(ins_t$INS, ins_t_nom[[i]]))$chisq_tests[2,3]
}

CHISQ_N_df <- dplyr::arrange(data.frame(nom_name, chisq), chisq)




# Variable Relationships with INS - Continuous
cont_name <- colnames(ins_t_cont)

chisq_c <- NULL

for (i in 1:length(cont_name)) {
  chisq_c[i] <- summary(glm(ins_t$INS ~ ins_t_cont[[i]],
                            family = binomial(link = "logit")))$coef[2,4]
}

CHISQ_C_df <- dplyr::arrange(data.frame(cont_name, chisq_c), chisq_c)


# Checking Assumptions for Continuous variables
cont_name <- colnames(ins_t_cont)

GAM <- NULL

for (i in 1:length(cont_name)) {
  var_name <- ins_t_cont[[i]]
  GAM[i] <- summary(gam(ins_t$INS ~ var_name, family = binomial(link = "logit"),
                        method = "REML"))$p.pv[2]
}


GAM_df <- dplyr::arrange(data.frame(cont_name, GAM), GAM)


# Number of missing value per variable
sapply(ins_t, function(x) sum(is.na(x)))

