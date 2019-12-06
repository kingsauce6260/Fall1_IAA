
  # Loading Libray ----------------------------------------------------------

  # Libraries
  library(MASS)
  library(unbalanced)
  library(multcomp)
  library(brglm)
  library(car)
  library(sas7bdat)
  library(dplyr)



# Read Data ---------------------------------------------------------------

  insurancedf <- read.sas7bdat('/Users/thomasgow/Documents/IAA/Logistic Regression/CodingLogisticRegressionIAA/Homework2_LR/insurance_t_bin.sas7bdat')
  insurancevaliddf <- read.sas7bdat('/Users/thomasgow/Documents/IAA/Logistic Regression/CodingLogisticRegressionIAA/Homework2_LR/insurance_v_bin.sas7bdat')



# Keep Variables ----------------------------------------------------------

  # Defining type of each variable
  
  ins_t_bin_c <- dplyr::select(insurancedf,"DDA", "DIRDEP", "NSF", "SAV", "ATM", "CD", "IRA", "LOC",
                             "INV", "ILS", "MM", "MTG", "CC", "SDB", "HMOWN", "MOVED",
                             "INAREA", "CASHBK", "MMCRED", "CCPURC", "BRANCH", "RES","DDABAL_Bin",
                             "ACCTAGE_Bin", "DEPAMT_Bin", "CHECKS_Bin", "NSFAMT_Bin", "PHONE_Bin",
                             "TELLER_Bin", "SAVBAL_Bin", "ATMAMT_Bin", "POS_Bin", "POSAMT_Bin",
                             "CDBAL_Bin", "IRABAL_Bin", "LOCBAL_Bin", "INVBAL_Bin", "ILSBAL_Bin",
                             "MMBAL_Bin", "MTGBAL_Bin", "CCBAL_Bin", "INCOME_Bin", "LORES_Bin",
                             "HMVAL_Bin", "AGE_Bin", "CRSCORE_Bin", "INS")
  
  categ_names <- colnames(ins_t_bin_c)
# Missing Categories ------------------------------------------------------

  # Number of missin variables per character var
  colSums(is.na(ins_t_bin_c))
  
  # Fix all missing values
  ins_t_bin_c[is.na(ins_t_bin_c)] <- 'M'
  
# Convergence Problems ----------------------------------------------------

  LS <- NULL
  
  for(i in 2:length(categ_names)){
    LS[i-1] <- sum(table(ins_t_bin_c$INS, ins_t_bin_c[[i]]) == 0)
  }
  
  data.frame(categ_names[-1], LS)
  
  data.frame(categ_names[-1], LS)[order(-LS),]
  
  
  # Definite CASHBK, MMCRED
  with(ins_t_bin_c, table(MMCRED, INS))
  with(ins_t_bin_c, table(CASHBK, INS))
  
  
  # Fix Convergence Problems - Combing Categories
  # CASHBK and MMCRED
  ins_t_bin_c$CASHBK[which(ins_t_bin_c$CASHBK > 0)] <- "1+"
  ins_t_bin_c$MMCRED[which(ins_t_bin_c$MMCRED > 2)] <- "3+"
  
  
  # Model to also see convergence problems
  model <- glm(INS~., data=ins_t_bin, family = binomial)
  summary(model)
  
  # Factor all variables
  ins_t_bin_c <- ins_t_bin_c %>%
    dplyr::mutate_all(factor)

# Main Effects Model ------------------------------------------------------

  # Logistic Regression Model - Full Model
  full.model <- glm(INS ~ ., 
                    data = ins_t_bin_c, 
                    family = binomial(link = "logit"))
  
  # Logistic Regression Model - Backward Selection
  back.model <- step(full.model, 
                     direction = "backward", 
                     k=log(nrow(ins_t_bin_c)))
  summary(back.model)

  # Logistic Regression Model - Main Model
  # Variables obtained from backward selection
  main.model <- glm(INS ~ DDA + NSF + IRA + ILS + MM + CC + INV + BRANCH +
                      DDABAL_Bin + CHECKS_Bin + TELLER_Bin + SAVBAL_Bin + 
                      ATMAMT_Bin + CDBAL_Bin + MMBAL_Bin, 
                    data = ins_t_bin_c, family = binomial(link = "logit"))

  int.model <- glm(INS ~ (DDA + NSF + IRA + ILS + MM + CC + INV + BRANCH +
                             DDABAL_Bin + CHECKS_Bin + TELLER_Bin + SAVBAL_Bin +
                             ATMAMT_Bin + CDBAL_Bin + MMBAL_Bin)^2,
                   data = ins_t_bin_c, family = binomial(link = "logit"))

  for.model <- step(main.model, 
                    scope = list(lower=formula(main.model), 
                                 upper=formula(int.model), 
                                 k=log(nrow(ins_t_bin_c))), 
                    direction = "forward")

  summary(for.model)
  ((exp(for.model$coefficients)-1)*100) %>% sort()
  

# Final Logistic Model ----------------------------------------------------

  # Final Model variables and interactions obtained from previous models
  final.model <- glm(INS ~ (DDA + NSF + IRA + ILS + MM + CC + INV + BRANCH +
                              DDABAL_Bin + CHECKS_Bin + TELLER_Bin + SAVBAL_Bin + 
                              ATMAMT_Bin + CDBAL_Bin + DDABAL_Bin*SAVBAL_Bin + 
                              MM*DDABAL_Bin + DDA*IRA),
                     data = ins_t_bin_c, family = binomial(link = "logit"),
                     k=log(nrow(ins_t_bin_c)))
  summary(final.model)





