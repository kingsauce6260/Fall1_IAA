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


  
  
insurance_t <- na.omit(insurance_t)
# Number of missing values (NA) for each variable
sapply(insurance_t, function(x) sum(is.na(x)))

# important variables
summary_logit <- as.data.frame(summary(logit.model)$coefficients)
summary_logit$Var_ID <- rownames(summary_logit)

summary_logit <- dplyr::arrange(summary_logit, summary_logit$`Pr(>|z|)`)

# The bank currently uses a 0.002 alpha cut off level
# The significant variables would include in significant rank:
# DDA, DDABAL, TELLER, SAVBAL, ATMAMT, MMBAL, PHONE
# SAV, CD, DDABAL, TELLER, SAVBAL, ATMAMT, MM, CC, BRANCHB16,
# MMBAL, INV, PHONE
# Explore these relationships
# Continuous variables
# 
ddabal_df <- select(insurance_t, INS, DDABAL)
null_model <- glm(INS ~ 1, data = insurance_t, family = binomial)
model_with_var <- glm(INS~DDABAL, data = ddabal_df, family = binomial)
lrt <- anova(model_with_var, null_model, test = "LRT")
significance[1] <- lrt$`Pr(>Chi)`[!is.na(lrt$`Pr(>Chi)`)]

ddabal_df <- dplyr::filter(ddabal_df, DDABAL<4000)
boxplot(DDABAL~INS,data=ddabal_df)

# Important Binary Variables
# SAV, CD, DDABAL, TELLER, SAVBAL, ATMAMT, MM, CC, BRANCHB16,
# MMBAL, INV, PHONE
# SAV


# Continuous variables
for(i in colnames(ordinal_vars)){
  ins_temp <- insurance_t[,"INS"]
  temp <- insurance_t[,i]
  temp <- cbind(ins_temp, temp)
  frmla <- as.formula(paste0("INS ~", i))
  null_model <- glm(INS ~ 1, data = insurance_t, family = binomial)
  model_with_var <- glm(frmla, data = insurance_t, family = binomial)
  lrt <- anova(model_with_var, null_model, test = "LRT")
  significance[i] <- lrt$`Pr(>Chi)`[!is.na(lrt$`Pr(>Chi)`)]
  pearson_test <- chisq.test(temp)
  significance <- pearson_test$p.value
  
}

contingency_tbl <- table(tmp_dat[[variable]], tmp_dat[["INS"]])
pearson_test <- chisq.test(contingency_tbl)
significance <- pearson_test$p.value



# Logistic Regression Model #
logit.model <- glm(INS ~ ., 
                   data = insurance_t, family = binomial(link = "logit"))



