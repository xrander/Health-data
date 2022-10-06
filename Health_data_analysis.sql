-- Active: 1663635897256@@127.0.0.1@5432@project
CREATE TABLE health_data(
    group_num SMALLINT,
    ID BIGINT PRIMARY KEY,
    outcome SMALLINT,
    age SMALLINT,
    gender SMALLINT NOT NULL,
    BMI NUMERIC(15,10),
    hypertensive NUMERIC(15,10),
    atrialfibrillation NUMERIC(15,10),
    CHD_with_no_MI NUMERIC(15,10),
    diabetes SMALLINT,
    deficiencyanemias SMALLINT,
    depression NUMERIC(15,10),
    Hyperlipemia SMALLINT,
    Renal_failure SMALLINT,
    COPD NUMERIC(15,10),
    heart_rate NUMERIC(15,10),
    Systolic_blood_pressure NUMERIC(15,10),
    Diastolic_blood_pressure NUMERIC(15,10),
    Respiratory_rate NUMERIC(15,10),
    temperature NUMERIC(15,10),
    SP_O2 NUMERIC(15,10),
    Urine_output NUMERIC(15,10),
    hematocrit NUMERIC(15,10),
    RBC NUMERIC(15,10),
    MCH NUMERIC(15,10),
    MCHC NUMERIC(15,10),
    MCV NUMERIC(15,10),
    RDW NUMERIC(15,10),
    Leucocyte NUMERIC(15,10),
    Platelets NUMERIC(15,10),
    Neutrophils NUMERIC(15,10),
    Basophils NUMERIC(15,10),
    Lymphocyte NUMERIC(15,10),
    PT NUMERIC(15,10),
    INR NUMERIC(15,10),
    NT_proBNP NUMERIC(10,2),
    Creatine_kinase NUMERIC(15,10),
    Creatinine NUMERIC(15,10),
    Urea_nitrogen NUMERIC(15,10),
    glucose NUMERIC(15,10),
    Blood_potassium NUMERIC(15,10),
    Blood_sodium NUMERIC(15,10),
    Blood_calcium NUMERIC(15,10),
    Chloride NUMERIC(15,10),
    Anion_gap NUMERIC(15,10),
    Magnesium_ion NUMERIC(15,10),
    PH NUMERIC(4,2),
    Bicarbonate NUMERIC(15,10),
    Lactic_acid NUMERIC(15,10),
    PCO2 NUMERIC(15,10),
    EF SMALLINT
);

--importing data from local directory--

COPY health_data
FROM 'C:\Users\aduol\Downloads\SQL DATA SET\Data\Health_data.csv'
WITH (FORMAT CSV, HEADER, DELIMITER '|');

--Previewing data--
SELECT
*
FROM health_data;

--a data from outcome is having null and we'll remove that row
-- Finding data with null value
SELECT
  id,
  age,
  outcome,
  COUNT(*)
FROM health_data
WHERE outcome IS NULL
GROUP BY id, age, outcome;

/*the NULL data is attached to the age 83, since a person can either be dead or alive,
this row will be deleted.
The id '162338' has been identified as neither dead or alive and will be deleted from the table
*/

DELETE FROM health_data
WHERE id = 162338;

-- running the query to find the null value again should return empty spaces now.

/*next we'll be converting data types of select variables with true/false values
into integer type
*/

ALTER TABLE health_data ALTER COLUMN hypertensive TYPE INTEGER;
ALTER TABLE health_data ALTER COLUMN chd_with_no_mi TYPE INTEGER;
ALTER TABLE health_data ALTER COLUMN atrialfibrillation TYPE INTEGER;
ALTER TABLE health_data ALTER COLUMN depression TYPE INTEGER;
ALTER TABLE health_data ALTER COLUMN copd TYPE INTEGER;
ALTER TABLE health_data ALTER COLUMN outcome TYPE INTEGER;

--SOlUTION TO QUESTIONS
--Which age group is the  most in the hospital
SELECT
    DISTINCT(age),
    count(*) AS num_of_patient
FROM health_data
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

--which age group of patients dies more in the hospital?
-- where 0 = alive and 1 = dead
SELECT
<<<<<<< HEAD
DISTINCT(age),
  outcome,
  count(*)
=======
  DISTINCT(age),
  outcome,
  count(*) AS num_of patients
>>>>>>> a47798c63ea5028bc0723f1e2e8c21bfbb682af8
FROM health_data
GROUP BY 1,2
ORDER BY age;

--- which genders is the most prevalent in the hospital?
--WHERE 1 = Male and 2 = Female
SELECT
<<<<<<< HEAD
  gender,
  count(*) AS count
FROM health_data
GROUP BY gender
ORDER BY count;

--which gender group is having the highest number of death?
-- WHERE outcome code 1 = dead, Gender 1 = Male and 2 = Female
SELECT
=======
>>>>>>> a47798c63ea5028bc0723f1e2e8c21bfbb682af8
  gender,
  count(*) AS num_of_patients
FROM health_data
GROUP BY 1
ORDER BY count;

--which gender group is having the highest number of death?
-- WHERE outcome code 1 = dead, Gender 1 = Male and 2 = Female
SELECT
  gender,
  count(*) AS number_of_patient
FROM health_data
WHERE outcome = 1
GROUP BY gender, outcome
ORDER BY 2 DESC
LIMIT 1;
-- Male is having the highest number of deaths with 80 male patients dead

--how many patients died in the hospital with atrial fibrillation
-- outcome code 1 = dead and atrialfibrillation code 0 = having and 1 = not having
SELECT
  atrialfibrillation,
  outcome,
  count(*) AS number_of_patient
FROM health_data
WHERE outcome = 1 AND atrialfibrillation = 0
GROUP BY 1, 2
ORDER BY 3;
-- 67 patients died of atritalfibrillation

--how many male and female died in the hospital having atrial fibrillation
-- outcome code 1 = dead and atrialfibrillation code 0 = having and 1 = not having
SELECT
  gender,
  atrialfibrillation,
  outcome,
  count(*) AS number_of_patient
FROM health_data
WHERE outcome = 1 AND atrialfibrillation = 0
GROUP BY 1, 2, 3
ORDER BY 4;
-- 28 Male and 39 Female

--how many patients in the hospital have depression?
-- 0 = depressed and 1 = not depressed
SELECT
  depression,
  count(*) AS depressed_patient
FROM health_data
WHERE depression = 0
GROUP BY 1
ORDER BY 2;
-- 1036 patients are depressed.

-- Is there a correlation between depression and aging?
SELECT
  corr(depression, age)
      AS depression_age_r -- r denotes the Pearson correlation coefficient
FROM health_data;
-- The results shows a very weak negative correlation between age and depression.

-- Rate of gender with hypertension
--- male = 1 and female = 2 hypentension code 0 = hypertensive, 1 = not_hypertensive 
SELECT
  round(
    ((SELECT
      count(hypertensive):: decimal
      FROM health_data
      WHERE hypertensive = 0 AND gender = 1) /
    (SELECT
      count(hypertensive)
      FROM health_data 
      WHERE hypertensive = 0)) * 100, 2
      ) AS hypertensive_male,
  round(
    ((SELECT
    count(hypertensive):: decimal
    FROM health_data
    WHERE hypertensive = 0 AND gender = 2) /
    (SELECT
    count(hypertensive)
    FROM health_data
    WHERE hypertensive = 0)) * 100, 2
    ) AS hypertensive_female
FROM health_data
GROUP BY 1, 2;
-- 46.19 percent of hypertensive patients are male and 51.81 percent of female are hypertensive

-- what is the rate of non-survived patients with hypertension?
SELECT
  round(
      ((SELECT count(outcome):: decimal
        FROM health_data
        WHERE hypertensive = 0 AND outcome = 1) /
      (SELECT count(outcome)
      FROM health_data
      WHERE outcome = 1))
       * 100, 2) AS pct_dead_with_hypertensive_patient
FROM health_data
GROUP BY 1;
-- 36.48 percent of the dead patients have hypertension


-- How many patients with renal failure are alive in the hospital?
---0 = without renal failure and 1 = with renal failure
SELECT
  renal_failure,
  outcome,
  count(*) AS patient_with_renal_failure_alive
FROM health_data
WHERE outcome = 0 AND renal_failure = 1
GROUP BY 1, 2;
-- 392 patients with renal failure are still alive

-- how many patients in the hospital with Hperlipemia are dead?
SELECT
  outcome,
  hyperlipemia,
  count(*) AS dead_patient_with_Hperlipemia
FROM health_data
WHERE outcome = 1 AND hyperlipemia = 0
GROUP BY 1, 2;
--109 patients with hyperlipemia are dead


-- how many patients in the hospital with Anemia are dead?
SELECT
  outcome,
  deficiencyanemias,
  count(*) AS dead_patient_with_deficiency_anemias
FROM health_data
WHERE outcome = 1 AND deficiencyanemias = 0
GROUP BY 1, 2;
-- 124 patients with anemia deficieny are dead


-- What is the proportion of survival and non-survival between depressed and non-depressed patients
  -- (a) What is the proportion of patients that survived with or without depression
SELECT
  round(
    ((SELECT
       count(depression):: decimal
      FROM health_data
      WHERE depression =0 AND outcome = 0) /
      (SELECT count(depression)
      FROM health_data
      WHERE outcome = 0)) * 100, 2
      ) AS pct_depressed_survived_,
  round(
    ((SELECT
       count(depression):: decimal
      FROM health_data
      WHERE depression = 1 AND outcome = 0) /
    (SELECT count(depression)
      FROM health_data
      WHERE outcome = 0)) * 100, 2
       ) AS pct_not_depressed_survived
FROM health_data
GROUP By 1;

  -- (b) What is the proportion of dead patients with and without depression
SELECT
  round(
    (SELECT
      count(depression):: decimal 
    FROM health_data
    WHERE depression = 1 AND outcome = 1) /
    (SELECT count(depression)
    FROM health_data
    WHERE outcome = 1) * 100, 2
    ) AS pct_not_depressed_not_survive,
  round(
    ((SELECT
      count(depression):: decimal
    FROM health_data
    WHERE depression = 0 AND outcome = 1) /
    (SELECT 
      count(depression)
    FROM health_data
    WHERE outcome = 1)) * 100, 2
    ) AS pct_depressed_not_survived
FROM health_data
GROUP BY 1
;


-- what is the proportion of survival and non-survival between diabetic and non diabetic patients
--- to answer this question, we divide the question into two parts
--- first part, we answer the proportion of diabetic and non diabetic patients that died
--- for the second part, we query the proportion of diabetic that survived

-- percentage of diabetic and non_diabetic patients
SELECT
  round(
      (SELECT
      count(diabetes)
    FROM health_data
    WHERE diabetes = 0) :: NUMERIC(4,1)/ 
      count(diabetes) * 100, 1
      ) AS diabetic_patients,
  round (
      (SELECT
        count(diabetes)
      FROM health_data
      WHERE diabetes = 1) :: NUMERIC(4,1)/ 
        count(diabetes) * 100, 1
        ) AS non_diabetic_patients
FROM health_data;
-- 57.9% of all the patients are diabetic

-- percentage of dead diabetic and non_diabetic patients
SELECT
  round(
    dead.diabetic :: NUMERIC(4,1) /
     (dead.diabetic + dead.non_diabetic)
    * 100, 2) pct_dead_diabetic,
  round(
    dead.non_diabetic :: NUMERIC(4,1) / 
    (dead.diabetic + dead.non_diabetic)
    * 100, 2) pct_dead_non_diabetic
FROM
    (SELECT
      (SELECT
        count(diabetes)
      FROM health_data
      WHERE diabetes = 1 AND outcome = 1) AS non_diabetic,
      (SELECT
        count(diabetes) 
      FROM health_data
      WHERE diabetes = 0 AND outcome = 1) AS diabetic
    FROM health_data
    GROUP BY 1,2) AS dead;
-- 64.15 of all the dead patients have diabetes

-- percentage of diabetic and non-diabetic patients that survived
SELECT
  round(
      survived.diabetic :: NUMERIC(4,1) /
       (survived.diabetic + survived.non_diabetic)
      * 100, 2) AS pct_survive_diabetic,
  round(
      survived.non_diabetic :: NUMERIC(4,1) /
      (survived.diabetic + survived.non_diabetic)
        * 100, 2) AS pct_survived_non_diabetic
FROM
    (SELECT
      (SELECT
        count(diabetes)
      FROM health_data
      WHERE diabetes = 1 AND outcome = 0) AS non_diabetic,
      (SELECT
        count(diabetes)
      FROM health_data
      WHERE diabetes = 0 AND outcome = 0) AS diabetic
    FROM health_data
    GROUP BY 1,2) AS survived;
-- 56.93 percent of the patients that are still alive have diabetes