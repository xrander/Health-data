---
title: "Retrospective Health Data Analysis"
author: "Olamide Adu"
date: "2023-03-25"
output:
   prettydoc::html_pretty:
    theme: 'oldstyle'
    toc: true
    toc_float: false
    highlight: github
    code_theme: zenburn
    keep_md: true
editor_options: 
  markdown: 
    wrap: 72
---

# Retrospective Health-data Analysis

Retrospective exploratory data analysis of intensive care unit health-data downloaded from kaggle.com already preprocessed by user @saurabhshahane.

**NB**: The [data](https://www.kaggle.com/datasets/saurabhshahane/in-hospital-mortality-prediction)
used is part of a whole data from [**MIMIC III original database**](https://www.kaggle.com/datasets/drscarlat/mimic2-original-icu/download?datasetVersionNumber=1). Data usage is mainly for exploratory data, improving analytical skills using some analytics tools. Mainly ![R](https://raw.githubusercontent.com/xrander/Health-data/master/Resource/4375063_logo_project_r_icon.png)
and
![](https://github.com/xrander/Health-data/raw/master/Resource/4691328_postgresql_icon.png)

## Description of the Data

The MIMIC-III database is publicly a available critical care database containing de-identified data on 46520 patients and 58976 admissions to the ICU of the Beth Israel Deaconess Medical Center, Boston, USA between 2001 and 2008.
![](https://production-media.paperswithcode.com/datasets/1e5baf4a-ec7c-4c72-ae79-ebdb48d7253d.png)

#### Quick Overview A data of more than 50 variables and 1176
observations

#### Data Definition

-   group_num

-   ID: The patient ID

-   outcome: 0 = Alive and 1 = Dead

-   age: the age of the patient

-   gender: 1 = Male and 2 = Female

-   BMI: Body Mass Index

-   hypertensive: 0 = with and 1 = without

-   atrialfibrillation: 0 = with and 1 = without

-   CHD_with_no_MI: Coronary heart disease with Myocardial infarction, 0 = with and 1 without
    
-   diabetes: 0 = with and 1 without

-   deficiencyanemias: 0 = with and 1 = without

-   depression: 0 = with and 1 = without

-   Hyperlipemia:this refers to high concentration of fats or lipids in
    the blood. 0 = with and 1 = without

-   Renal_failure: 0 = without renal failure and 1 = with renal failure

-   COPD: chronic obstructive pulmonary disease(A disease causing airflow blockage and breathing related problems). 0 = without and 1 = without

-   heart_rate: a range of 60 to 100 bpm is considered normal

-   Systolic_blood_pressure: measure of the pressure in arteries when the heart beats.

-   Diastolic_blood_pressure: measure of the pressure in the arteries when the heart rests between beats
-   Respiratory_rate: this is the number of breathes per minute. The normal range is between 12-20, anything under above or below this range is abnormal. 25 is considered too high.

-   temperature

-   SP_O2: Oxygen saturation (measure of how much oxygen the blood carries as a percentage of the maximum it could carry). The normal range for healthy individuals is between 96% to 99%

-   Urine_output

-   hematocrit: percentage volume of red blood cells in the blood.

-   RBC: acronym for Red Blood Count.

-   MCH: Mean Corpuscular Hemoglobin, this is the average amount of hemoglobin in each of the red blood cells

-   MCHC: Mean Cell Hemoglobin Concentration, this is the average concentration of hemoglobin in a given volume of blood.

-   MCV: Mean Corpuscular Volume, this is the measure of the average size of the red clood cells

-   RDW: red cell distribution width. it is the differences in the volume and size of the red blood cells

-   Leucocyte

-   Platelets

-   Neutrophils

-   Basophils

-   Lymphocyte

-   PT: measure of the time it takes the liquid portion of the blood to clot.

-   INR

-   NT_proBNP: a measure of heart failure.

-   Creatine_kinase

-   Creatinine

-   Urea_nitrogen

-   glucose

-   Blood_potassium

-   Blood_sodium

-   Blood_calcium

-   Chloride

-   Anion_gap: measures the difference between the negatively and positively charged electrolytes in the blood.

-   Magnesium_ion

-   PH

-   Bicarbonate

-   Lactic_acid

-   PCO2: Partial Pressure of Carbon Dioxide, this measures the carbondioxide within the arterial or venous blood.

-   EF: Ejection Fraction: Used to gauge how healthy the heart is. It is the amount of blood that the heart pumps each time it beats.

## Questions

![](https://i.pinimg.com/originals/0e/53/94/0e53948c0d24283e7cdd42f9bb0bda4e.jpg)
<p>*imagesource: pinterest*</p>

<p> Based on the data available the following questions will be answered</p>

<p>- Which age group is the most in the hospital?</p>

<p>- which age group of patients dies more in the hospital?</p>

<p>- which gender is the most prevalent in the hospital? </p> 

<p>- which gender group is having the highest number of death? </p> 

<p>- how many patients died in the hospital with atrial fibrillation?</p>

<p>- how many patients in the hospital have depression?</p>

<p>- what is the rate of non-survived patients with hypertension?</p>

<p>- Rate of gender with hypertension</p>

<p>- How many patients with renal failure are alive in the hospital?</p>

<p>- how many patients in the hospital with Hperlipemia are dead?</p>

<p>- how many patients in the hospital with Anemia are dead?</p> 

<p>- What is the proportion of survival and non-survival between diabetic and non-diabetic patients</p>

<p>- What is the proportion of survival and non-survival between depressed and non-depressed patients
</p>
