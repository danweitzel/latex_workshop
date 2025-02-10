## Title: Examining Racial Resentment in the 2020 ANES Pilot Study
## Author: Daniel Weitzel
## Email: daniel.weitzel@colostate.edu
## Date: 2025-02-09
## Purpose: Generating a graph and a table for the LaTeX workshop

## Set the working directory
setwd("")

# Install the necessary package from Github
#library(devtools)
#install_github("jamesmartherus/anesr")

# Load libraries
library(anesr)
library(haven)
library(tidyverse)
library(texreg)
library(modelsummary)
library(wesanderson)

# Load the 2020 Pilot
data(pilot_2020) #Load 2018 Pilot Study

# Clean the data, below is the final clean, this is iterative though
pilot_2020 <-
  pilot_2020 |> 
  dplyr::select(race7, rr_scale, pid7, pk_index, income, age, educ, sex, expknowimmig, viol2a, selfmon4) |> 
  zap_labels() |> 
  mutate(rr_scale = ifelse(rr_scale > 16, NA, rr_scale),
         race7 = ifelse(race7 == 9, NA, race7),
         pid7 = ifelse(pid7 == 9, NA, pid7),
         viol2a = ifelse(viol2a == 9, NA, viol2a),
         selfmon4 = ifelse(selfmon4 == 96, NA, selfmon4),
         income = ifelse(income == 99, NA, income),
         male = ifelse(sex == 1, 1, 0),
         knows_immigrants = case_when(expknowimmig == 1 ~ 1,
                                      expknowimmig == 2 ~ 0,
                                      TRUE ~ NA), 
         race7_string = case_when(race7 == 1 ~ "White",
                                  race7 == 2 ~ "Black",
                                  race7 == 3 ~ "Asian",
                                  race7 == 4 ~ "Mixed",
                                  race7 == 5 ~ "Hispanic",
                                  race7 > 5 ~ "Native, PI"),
         race7_string = fct_relevel(race7_string, "White")) 


## Data Summary Table
summary_pilot_2020 <-
  pilot_2020 |> 
  dplyr::select(rr_scale, race7_string, pid7, pk_index, income, age, educ, male, knows_immigrants, viol2a, selfmon4) 
  
datasummary_skim(summary_pilot_2020,
                 output = "manuscript/tables/summary.tex",
                 title = "Summary Statistics")

# A fancy table with modelsummary:
models <- list(
  "Bivariate model" =  lm(rr_scale ~ pk_index, data = pilot_2020),
  "Full model" = lm(rr_scale ~ pk_index + race7_string + pid7 + income + age + educ + male + knows_immigrants + viol2a + selfmon4, data = pilot_2020))

# Coefficient map for a clean table
ms_coefmap <- c("Intercept" = "(Intercept)", 
                "race7_stringAsian" = "Asian", 
                "race7_stringBlack" = "Black", 
                "race7_stringHispanic" = "Hispanic",
                "race7_stringMixed" = "Mixed", 
                "race7_stringNative, PI" = "Native, PI", "pid7" = "PID 7", 
                "pk_index" = "Pol. Knowledge", 
                "income" = "Income", 
                "age" = "Age", 
                "educ" = "Education", 
                "male" = "Male", 
                "knows_immigrants" = "Knows Immig.",
                "viol2a" = "Violence justified", 
                "selfmon4" = "Center of attention")

# Generating a nice table and saving it into the manuscript/tables folder
modelsummary(models,
             output = "manuscript/tables/ols_rr_analysis.tex",
             caption = "Linear Regression Results \\label{tab:ols_rr}",
             stars = c('***' = .05),
             coef_rename = ms_coefmap,
             estimate  = "{estimate}{stars}", 
             statistic =  "std.error",
             gof_map = c("nobs", "r.squared")) 


## Plotting the dependent variable
pilot_2020 |> 
  ggplot(aes(x = rr_scale)) +
  geom_bar() +
  theme_classic()  +
  labs(title = "Distribution of the Racial Resentment Scale",
       x = "Racial Resentment",
       y = "Count")
ggsave("manuscript/figures/rr_barplot.pdf", width = 9, height = 7.5, units = "in")

pilot_2020 |> 
  drop_na(race7_string) |> 
  mutate(race7_string = fct_reorder(race7_string, rr_scale, .fun = median)) |> 
  ggplot(aes(y = rr_scale, x = race7_string)) +
  geom_boxplot() +
  theme_classic()  +
  labs(title = "Racial Resentment Scale Across Racial Categories",
       x = "Racial Categories",
       y = "Racial Resentment")
ggsave("manuscript/figures/rr_race_boxplot.pdf", width = 9, height = 7.5, units = "in")

## Plot a regression with color by model
modelplot(models,
          coef_rename = ms_coefmap,
          coef_omit = "Interc") +
  scale_color_manual(values = wes_palette('Darjeeling1')) +
  geom_vline(xintercept = 0, color = "black", linetype= "dashed") +
  theme_classic()  +
  labs(x = "Coefficients", 
       y = "Variables",
       color = "Model",
       title = "Linear regression models of Racial Resentment") +
  geom_vline(xintercept = 0, color = "black", linetype= "dashed")
ggsave("manuscript/figures/ols_coefficient_1.pdf", width = 9, height = 7.5, units = "in")
