-- 1. Contare quanti iscritti ci sono stati ogni anno
SELECT COUNT(`students`.`id`) AS "Numero di Iscritti" , YEAR(`students`.`enrolment_date`) AS "Anno di Iscrizione"
FROM `students`
GROUP BY YEAR(`students`.`enrolment_date`);

-- 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT COUNT(`teachers`.`id`) AS "Insegnanti avendo stesso indirizzo" , `teachers`.`office_address` AS "Indirizzo ufficio"
FROM `teachers`
GROUP BY `teachers`.`office_address`;

-- 3. Calcolare la media dei voti di ogni appello d'esame
SELECT `exam_id` AS "ID appello", ROUND(AVG(`vote`), 1) AS "Media dei voti dell'appello"
FROM `exam_student`
GROUP BY `exam_id`;

-- 4. Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT `departments`.`name` AS "Nome dipartimento", COUNT(`degrees`.`id`) AS "Numero di CdL afferenti"
FROM `degrees`
INNER JOIN `departments`
ON `degrees`.`department_id` = `departments`.`id`
GROUP BY `degrees`.`department_id`;