(SELECT 
DISTINCT(first_answers.answer_name) AS 'ICD name',first_answers.icd10code AS 'ICD CODE',
IFNULL(SUM(CASE WHEN second_concept.gender = 'F' AND second_concept.person_id IS NOT NULL THEN 1 ELSE 0 END), 0) AS 'FEMALE PATIENT',
IFNULL(SUM(CASE WHEN second_concept.gender = 'M' AND second_concept.person_id IS NOT NULL THEN 1 ELSE 0 END),0) AS 'MALE PATIENT'
FROM

(SELECT 
    CASE WHEN concept_full_name IN ('Influenza due to identified avian influenza virus','Influenza due to other identified influenza virus',
'Influenza with other manifestations, virus not identified')
    THEN 'Viral Influenza' ELSE concept_full_name END AS answer_name,
    CASE WHEN icd10_code IN ('J09','J10','J11.8')
 THEN 'J11' ELSE icd10_code END AS icd10code,
         icd10_code
    FROM
        diagnosis_concept_view
    WHERE
        icd10_code IN ('J09','J10','J11.8')) first_answers
        
        LEFT OUTER JOIN
		
    (SELECT DISTINCT(p.person_id),dcv.concept_full_name,icd10_code,v.visit_id AS visit_id,p.gender AS gender FROM person p
    INNER JOIN visit v ON p.person_id = v.patient_id AND v.voided = 0
    INNER JOIN encounter e ON v.visit_id = e.visit_id AND e.voided = 0
    INNER JOIN obs o ON e.encounter_id = o.encounter_id AND o.voided = 0 AND DATE(o.obs_datetime) BETWEEN '#startDate#' AND '#endDate#'
    INNER JOIN obs o1 ON o.encounter_id = o1.encounter_id AND o1.obs_group_id = o.obs_group_id AND o1.value_coded = 18
    INNER JOIN concept_name cn ON o.concept_id = cn.concept_id AND cn.concept_name_type = 'FULLY_SPECIFIED' AND cn.name IN ('Coded Diagnosis') AND o.voided = 0 AND cn.voided = 0
    JOIN diagnosis_concept_view dcv ON dcv.concept_id = o.value_coded AND dcv.icd10_code IN ('J18.9','J12.9','J13','J14','J15.9','J16','P23')
    WHERE p.voided = 0) first_concept ON first_concept.icd10_code = first_answers.icd10_code
	
        LEFT OUTER JOIN
		
    (SELECT DISTINCT
    (person.person_id) AS person_id,
            visit.visit_id AS visit_id,
            person.gender AS gender
   FROM person 
     JOIN visit  ON person_id = visit.patient_id 
     JOIN visit_type vt ON visit.visit_type_id = vt.visit_type_id AND vt.name != 'IPD'

    WHERE
        cast(visit.date_started AS DATE) BETWEEN DATE('#startDate#') AND DATE('#endDate#')) second_concept ON first_concept.person_id = second_concept.person_id
		-- ON 
		-- first_concept.person_id = second_concept.person_id 
		and first_concept.visit_id = second_concept.visit_id
)
union

-- ==========================================Pneumonia==========================================================
(SELECT 
DISTINCT(first_answers.answer_name) AS 'ICD name',first_answers.icd10_code AS 'ICD CODE',
IFNULL(SUM(CASE WHEN second_concept.gender = 'F' AND second_concept.person_id IS NOT NULL THEN 1 ELSE 0 END), 0) AS 'FEMALE PATIENT',
IFNULL(SUM(CASE WHEN second_concept.gender = 'M' AND second_concept.person_id IS NOT NULL THEN 1 ELSE 0 END),0) AS 'MALE PATIENT'
FROM
(SELECT 
    CASE WHEN concept_full_name IN ('Pneumonia, unspecified','Viral pneumonia, unspecified','Pneumonia due to Streptococcus pneumoniae','Pneumonia due to Haemophilus influenzae',
'Bacterial pneumonia, unspecified','Pneumonia due to other infectious organisms, not elsewhere classified','Congenital pneumonia')
    THEN 'Pneumonia' ELSE concept_full_name END AS answer_name,
    CASE WHEN icd10_code IN ('J18.9','J12.9','J13','J14','J15.9','J16','P23')
 THEN 'J18.9' ELSE icd10_code END AS icd10code,
         icd10_code
    FROM
        diagnosis_concept_view
    WHERE
        icd10_code IN ('J18.9','J12.9','J13','J14','J15.9','J16','P23')) first_answers
        
        LEFT OUTER JOIN
		
    (SELECT DISTINCT(p.person_id),dcv.concept_full_name,icd10_code,v.visit_id AS visit_id,p.gender AS gender FROM person p
    INNER JOIN visit v ON p.person_id = v.patient_id AND v.voided = 0
    INNER JOIN encounter e ON v.visit_id = e.visit_id AND e.voided = 0
    INNER JOIN obs o ON e.encounter_id = o.encounter_id AND o.voided = 0 AND DATE(o.obs_datetime) BETWEEN '#startDate#' AND '#endDate#'
    INNER JOIN obs o1 ON o.encounter_id = o1.encounter_id AND o1.obs_group_id = o.obs_group_id AND o1.value_coded = 18
    INNER JOIN concept_name cn ON o.concept_id = cn.concept_id AND cn.concept_name_type = 'FULLY_SPECIFIED' AND cn.name IN ('Coded Diagnosis') AND o.voided = 0 AND cn.voided = 0
    JOIN diagnosis_concept_view dcv ON dcv.concept_id = o.value_coded AND dcv.icd10_code IN ('J18.9','J12.9','J13','J14','J15.9','J16','P23')
    WHERE p.voided = 0) first_concept ON first_concept.icd10_code = first_answers.icd10_code
	
        LEFT OUTER JOIN
		
    (SELECT DISTINCT
    (person.person_id) AS person_id,
            visit.visit_id AS visit_id,
            person.gender AS gender
   FROM person 
     JOIN visit  ON person_id = visit.patient_id 
     JOIN visit_type vt ON visit.visit_type_id = vt.visit_type_id AND vt.name != 'IPD'

    WHERE
        cast(visit.date_started AS DATE) BETWEEN DATE('#startDate#') AND DATE('#endDate#')) second_concept ON first_concept.person_id = second_concept.person_id
		-- ON 
		-- first_concept.person_id = second_concept.person_id 
		and first_concept.visit_id = second_concept.visit_id
)
union
-- =================================================================================GUDS========================================
(SELECT 
DISTINCT(first_answers.answer_name) AS 'ICD name',first_answers.icd10code AS 'ICD CODE',
IFNULL(SUM(CASE WHEN second_concept.gender = 'F' AND second_concept.person_id IS NOT NULL THEN 1 ELSE 0 END), 0) AS 'FEMALE PATIENT',
IFNULL(SUM(CASE WHEN second_concept.gender = 'M' AND second_concept.person_id IS NOT NULL THEN 1 ELSE 0 END),0) AS 'MALE PATIENT'
FROM
(SELECT 
    CASE WHEN concept_full_name IN ('Female genital prolapse, unspecified','Female genital tract fistula, unspecified','Polyp of female genital tract, unspecified')
	THEN 'Genital User Disease Syndrome (GUDS) ‐ female' ELSE concept_full_name END AS answer_name,
    CASE WHEN icd10_code IN ('N81.9','N82.9','N84.9') THEN 'N76.6' ELSE icd10_code END AS icd10code,icd10_code
    FROM diagnosis_concept_view
    WHERE icd10_code IN ('N81.9','N82.9','N84.9')) first_answers
        
        LEFT OUTER JOIN
		
    (SELECT DISTINCT(p.person_id),dcv.concept_full_name,icd10_code,v.visit_id AS visit_id,p.gender AS gender FROM person p
    INNER JOIN visit v ON p.person_id = v.patient_id AND v.voided = 0
    INNER JOIN encounter e ON v.visit_id = e.visit_id AND e.voided = 0
    INNER JOIN obs o ON e.encounter_id = o.encounter_id AND o.voided = 0 AND DATE(o.obs_datetime) BETWEEN '#startDate#' AND '#endDate#'
    INNER JOIN obs o1 ON o.encounter_id = o1.encounter_id AND o1.obs_group_id = o.obs_group_id AND o1.value_coded = 18
    INNER JOIN concept_name cn ON o.concept_id = cn.concept_id AND cn.concept_name_type = 'FULLY_SPECIFIED' AND cn.name IN ('Coded Diagnosis') AND o.voided = 0 AND cn.voided = 0
    JOIN diagnosis_concept_view dcv ON dcv.concept_id = o.value_coded AND dcv.icd10_code IN ('N81.9','N82.9','N84.9')
    WHERE p.voided = 0) first_concept ON first_concept.icd10_code = first_answers.icd10_code
	
        LEFT OUTER JOIN
		
    (SELECT DISTINCT
    (person.person_id) AS person_id,
            visit.visit_id AS visit_id,
            person.gender AS gender
   FROM person 
     JOIN visit  ON person_id = visit.patient_id 
     JOIN visit_type vt ON visit.visit_type_id = vt.visit_type_id AND vt.name != 'IPD'

    WHERE
        cast(visit.date_started AS DATE) BETWEEN DATE('#startDate#') AND DATE('#endDate#')) second_concept ON first_concept.person_id = second_concept.person_id
		-- ON 
		-- first_concept.person_id = second_concept.person_id 
		and first_concept.visit_id = second_concept.visit_id
)

UNION
(SELECT 
DISTINCT(first_answers.answer_name) AS 'ICD name',first_answers.icd10_code AS 'ICD CODE',
IFNULL(SUM(CASE WHEN second_concept.gender = 'F' AND second_concept.person_id IS NOT NULL THEN 1 ELSE 0 END), 0) AS 'FEMALE PATIENT',
IFNULL(SUM(CASE WHEN second_concept.gender = 'M' AND second_concept.person_id IS NOT NULL THEN 1 ELSE 0 END),0) AS 'MALE PATIENT'
FROM
    (SELECT concept_full_name answer_name,
         icd10_code
    FROM
        diagnosis_concept_view
    WHERE
        icd10_code IN ('A30.9','G03','B24','N34.3','N49.2','N89.8','R10.4','P39.1','N50.8','I88.9',
	'A53.9','J22','J06.9','J15','J40','N39.0','N99.9','N50.9')) first_answers        
        LEFT OUTER JOIN
    (SELECT DISTINCT(p.person_id),dcv.concept_full_name,icd10_code,v.visit_id AS visit_id,p.gender AS gender FROM person p
    INNER JOIN visit v ON p.person_id = v.patient_id AND v.voided = 0
    INNER JOIN encounter e ON v.visit_id = e.visit_id AND e.voided = 0
    INNER JOIN obs o ON e.encounter_id = o.encounter_id AND o.voided = 0 AND DATE(o.obs_datetime) BETWEEN '#startDate#' AND '#endDate#'
    INNER JOIN obs o1 ON o.encounter_id = o1.encounter_id AND o1.obs_group_id = o.obs_group_id AND o1.value_coded = 18
    INNER JOIN concept_name cn ON o.concept_id = cn.concept_id AND cn.concept_name_type = 'FULLY_SPECIFIED' AND cn.name IN ('Coded Diagnosis') AND o.voided = 0 AND cn.voided = 0
    JOIN diagnosis_concept_view dcv ON dcv.concept_id = o.value_coded AND dcv.icd10_code IN ('A30.9','G03','B24','N34.3','N49.2','N89.8','R10.4','P39.1','N50.8','I88.9',
	'A53.9','J22','J06.9','J15','J40','N39.0','N99.9','N50.9')
    WHERE p.voided = 0) first_concept ON first_concept.icd10_code = first_answers.icd10_code
        LEFT OUTER JOIN
    (SELECT DISTINCT(person.person_id) AS person_id,
            visit.visit_id AS visit_id,
            person.gender AS gender
   FROM person 
     JOIN visit  ON person_id = visit.patient_id 
     JOIN visit_type vt ON visit.visit_type_id = vt.visit_type_id AND vt.name != 'IPD'
    WHERE
        cast(visit.date_started AS DATE) BETWEEN DATE('#startDate#') AND DATE('#endDate#')) second_concept ON first_concept.person_id = second_concept.person_id
        AND first_concept.visit_id = second_concept.visit_id
GROUP BY first_answers.icd10_code)