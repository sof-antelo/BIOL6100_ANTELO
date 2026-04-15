#GLMMs lecture
##################
# Sof Antelo
# Comp Bio 6100
# 4/14/2026
##################
#PART 1: Overview
#Using Bumble Bee Disease Seasonal Variation dataset and is organized into five core topics:

#Model structure for the four main y ~ x data-type combinations
#Testing for significance
#Distributions and log-transformation
#Random effects and nesting
#Interaction effects
#The response variable should usually drive the choice of model family. In this dataset we can use:

#BQCV, DWV and Nosema prevalence as a binary response
#BQCV, DWV and Nosema load as a continuous response,
# Bee Species, Host Plant, and Bee Cast as categorical predictors
#and Sampling Event as a time-like predictor.
#Site Code as random effects
##############################################################################################################

#PART 2: setup
# load packages
library(tidyverse)
library(lubridate)
library(lme4)
library(car)

#import data 
bee_dat <- read_csv("data/Burnham_field_data_pathogens_wide.csv")

bee_dat <- bee_dat %>%
  mutate(
    sampling_date = mdy(sampling_date),
    site_code = factor(site_code),
    field_id = factor(field_id),
    bee_caste = factor(bee_caste),
    bombus_spp = factor(bombus_spp),
    host_plant = factor(host_plant),
    sampling_event = factor(sampling_event),
    sampling_event_num = as.numeric(as.character(sampling_event)),
    log10_BQCV_load = log10(BQCV_pathogen_load + 1),
    log10_DWV_load = log10(DWV_pathogen_load + 1),
    log10_Nosema_load = log10(Nosema_pathogen_load + 1)
  )

glimpse(bee_dat)

#PART 3:Model structure for the four main variable type combinations
  #3.1:Continuous y ~ Continuous x
# filter for only pos:
df_filtered <- bee_dat[bee_dat$log10_DWV_load > 0 & bee_dat$log10_BQCV_load > 0, ]

qplot(
  x = log10_BQCV_load,
  y = log10_DWV_load,
  data = df_filtered) +
geom_smooth(method = "lm", se = TRUE)
m_cont_cont <- lm(log10_DWV_load ~ log10_BQCV_load, data = df_filtered)
Anova(m_cont_cont)

  #3.2:Continuous y ~ Categorical x
qplot(
  x = bombus_spp,
  y = log10_BQCV_load,
  data = df_filtered,
  geom = "boxplot")
m_cont_cat <- lm(log10_BQCV_load ~ bombus_spp, data = df_filtered)
Anova(m_cont_cat)

  #3.3:Categorical y ~ Continuous x
qplot(
  x = log10_BQCV_load,
  y = DWV_pathogen_binary,
  data = bee_dat) +
  geom_smooth(
    method = "glm",
    method.args = list(family = "binomial"))
m_cat_cont <- glm(
  DWV_pathogen_binary ~ log10_BQCV_load,
  data = bee_dat,
  family = binomial(link="logit")
)
Anova(m_cat_cont)

  #3.4:Categorical y ~ Categorical x
# summarize
sm <- bee_dat %>% 
  group_by(bee_caste) %>%
  dplyr::summarise(
    mean = mean(DWV_pathogen_binary, na.rm=T), 
  ) 

qplot(
  x = bee_caste,
  y = mean,
  data = sm
)
m_cat_cat <- glm(
  DWV_pathogen_binary ~ bee_caste,
  data = bee_dat,
  family = binomial(link="logit")
)
summary(m_cat_cat)

#PART4:Testing for significance
  #4.1 Let’s Create a couple of new models and test for significance:
# a model using a binomial dist.
bin_mod <- glm(data = bee_dat, DWV_pathogen_binary ~ bombus_spp * sampling_event + host_plant, family = binomial(link="logit"))

# a gaussian model:
gaus_mod <- lm(data = bee_dat, log10_Nosema_load ~ sampling_event * host_plant)

  #4.2 Coefficient tests from the model summary
summary(bin_mod)
summary(gaus_mod)

  #4.3 Type II or Type III tests with car
Anova(bin_mod, type = 2)
Anova(gaus_mod, type = 2)

  #4.5 Likelihood ratio test: full vs null model
m_dwv_null <- lm(data = df_filtered, log10_DWV_load ~ 1)
m_dwv_full <- lm(data = df_filtered, log10_DWV_load ~ sampling_event + host_plant)

  #4.5 Likelihood ratio test: full vs reduced model
m_dwv_reduced <- lm(data = df_filtered, log10_DWV_load ~ sampling_event)

anova(m_dwv_reduced, m_dwv_full, test = "LRT")

  #4.6 Term deletion with drop1()
drop1(m_dwv_full, test = "Chisq")

#PART 5: Distributions and log transformation
  #5.1 First, look at the response distributions
    #5.1.1 Binary response: BQCV presence
qplot(
  x = factor(BQCV_pathogen_binary),
  data = bee_dat,
  geom = "bar")

    #5.1.2 Continuous raw response: DWV load
qplot(
  x = DWV_pathogen_load,
  data = df_filtered,
  geom = "histogram",
  bins = 30)

    #5.1.3 Log-transformed continuous response: DWV load
qplot(
  x = log10_DWV_load,
  data = df_filtered,
  geom = "histogram",
  bins = 30)

    #5.1.4 Continuous raw response: Nosema load
qplot(
  x = Nosema_pathogen_load,
  data = bee_dat,
  geom = "histogram",
  bins = 30)

  #5.2 Distribution guide
    #Use Gaussian models for continuous responses that are roughly symmetric, often after transformation.
    #Use binomial models for 0/1 responses such as pathogen presence.
    #Use Gamma models for positive continuous responses when you want to model the raw scale directly.
    #Use Poisson or negative binomial for count responses, which are not the main response type in this dataset.

  #5.3 Why log-transform?
    # A log transform is useful when:
    #   the response is continuous and positive,
    #   the raw data are strongly right-skewed,
    #   variance increases with the mean,
    #   and interpretation on a multiplicative scale makes sense.
m_dwv_log <- lm(log10_DWV_load ~ sampling_event + bee_caste, data = bee_dat)
summary(m_dwv_log)

#PART 6: Random effects and nesting
# GLMMs extend GLMs by adding random effects, which account for grouped or non-independent observations.

# In field biology, non-independence often arises because samples are collected within the same site, field, or other grouping level.
  
  #6.1 Why random effects?
  # Use random effects when:
   # observations are clustered,
   # you expect groups to differ in baseline response,
   # and the group levels are better treated as a sample from a broader population rather than as fixed categories of direct interest.

  #6.2 Random intercept example

#binomial GLMM for BQCV presence with a random intercept for site.
g_bqcv_site <- lmer(
  log10_BQCV_load ~ bombus_spp + sampling_event + (1 | site_code),
  data = df_filtered)

Anova(g_bqcv_site)

  #6.3 Nested random effects
#If fields are nested within sites, we can write that as field_id within site_code.
g_bqcv_site <- lmer(
  log10_BQCV_load ~ bombus_spp + (1 | site_code/sampling_event),
  data = df_filtered)

Anova(g_bqcv_site)

  #6.4 Gamma mixed model example
#We can also use a mixed model for a different response error dist.
# make pos only nosema
nosPos <- bee_dat[bee_dat$Nosema_pathogen_load > 0,]

# gamma
nos_gamma <- glmer(
  Nosema_pathogen_load ~ site_code + bombus_spp + (1 | sampling_event),
  data = nosPos, family = Gamma)
Anova(nos_gamma)
# log
nos_log <- lmer(
  log10_Nosema_load ~ site_code + bombus_spp + (1 | sampling_event),
  data = nosPos)
Anova(nos_log)

#PART 7: Interactions
# Interactions ask whether the effect of one predictor depends on the level of another predictor.
# Because sampling_event is time-like, it is a useful interaction term in this dataset.

  #7.1 Example 1: interaction in a Gaussian model
#Does the change in DWV load across sampling event differ by caste?
qplot(
  x = sampling_event_num,
  y = log10_DWV_load,
  color = bee_caste,
  data = bee_dat)
m_dwv_interaction <- lmer(log10_DWV_load ~ sampling_event * bee_caste + (1 | site_code), data = bee_dat)
summary(m_dwv_interaction)
Anova(m_dwv_interaction, type = 2)

  #7.2 Example 2: interaction in a binomial model
#Does the probability of BQCV infection across sampling event differ by caste?
m_bqcv_interaction <- glm(
  BQCV_pathogen_binary ~ sampling_event * log10_DWV_load,
  data = bee_dat,
  family = binomial(link="logit")
)
summary(m_bqcv_interaction)
#Can also compare the interaction model to the additive model:
Anova(m_bqcv_interaction, type = 2)
m_bqcv_additive <- glm(
  BQCV_pathogen_binary ~ sampling_event + log10_DWV_load,
  data = bee_dat,
  family = binomial(link="logit")
)

summary(m_bqcv_additive) # higher aic
Anova(m_bqcv_additive, type = 2)
anova(m_bqcv_additive, m_bqcv_interaction, test = "Chisq")

# Summary 
#Start by identifying whether the response is continuous or categorical.
# Use the y ~ x matrix to choose a basic model structure.
# Inspect the distribution of the response before choosing a family.
# Use log transformation for right-skewed continuous responses when appropriate.
# Use interactions when the effect of one predictor may depend on another.
# Use random effects when observations are grouped or nested.
# Test significance using several complementary tools: summary(), car::Anova(), likelihood ratio tests, and reduced-model comparisons.