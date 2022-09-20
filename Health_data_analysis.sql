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
WITH (FORMAT CSV, HEADER, DELIMITER '|')
;

--Previewing data--

SELECT *
FROM health_data