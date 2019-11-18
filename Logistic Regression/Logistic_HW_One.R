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

# read data
insurance_t <- read_sas("/Users/thomasgow/Documents/IAA/Logistic Regression/Homework1_LR-2/insurance_t.sas7bdat")

# summary of variables
summary(insurance_t)

insurance_t <- na.omit(insurance_t)
# Number of missing values (NA) for each variable
sapply(insurance_t, function(x) sum(is.na(x)))

# Defining type of each variable
continuous_vars <- dplyr::select(insurance_t,"ACCTAGE", "DDABAL","DEP", "DEPAMT", "CHECKS", "NSFAMT",
               "PHONE", "TELLER", "SAVBAL", "ATMAMT", "POSAMT", "CDBAL",
               "IRABAL", "LOCBAL", "INVBAL", "ILSBAL", "MMBAL", "MTGBAL",
               "CCBAL", "INCOME", "LORES", "HMVAL", "AGE", "CRSCORE",
               "POS")

binary_vars <- dplyr::select(insurance_t,"DDA", "DIRDEP", "NSF", "SAV", "ATM", "CD", "IRA", "LOC",
               "INV", "ILS", "MM", "MTG", "CC", "SDB", "HMOWN", "MOVED",
               "INAREA")

ordinal_vars <- dplyr::select(insurance_t,"CASHBK", "MMCRED", "CCPURC")

nominal_vars <- dplyr::select(insurance_t,"BRANCH", "RES")

var_types <- rbind(continuous_vars,
                   binary_vars,
                   ordinal_vars,
                   nominal_vars)

# Logistic Regression Model #
logit.model <- glm(INS ~ ., 
                   data = insurance_t, family = binomial(link = "logit"))

# important variables
summary_logit <- as.data.frame(summary(logit.model)$coefficients)
summary_logit$Var_ID <- rownames(summary_logit)

summary_logit <- dplyr::arrange(summary_logit, summary_logit$`Pr(>|z|)`)


# The bank currently uses a 0.002 alpha cut off level
# The significant variables would include in significant rank:
# SAV, DDA, CD, DDABAL, TELLER, SAVBAL, ATMAMT, MM, CC, BRANCHB16,
# MMBAL, INV, PHONE
l <- list()
# Explore these relationships
# Continuous variables
for(i in colnames(continuous_vars)){
  ins_temp <- insurance_t[,"INS"]
  temp <- insurance_t[,i]
  temp <- cbind(ins_temp, temp)
  frmla <- as.formula(paste0("INS ~", i))
  null_model <- glm(INS ~ 1, data = insurance_t, family = binomial)
  model_with_var <- glm(frmla, data = insurance_t, family = binomial)
  lrt <- anova(model_with_var, null_model, test = "LRT")
  significance[i] <- lrt$`Pr(>Chi)`[!is.na(lrt$`Pr(>Chi)`)]
  
}

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




