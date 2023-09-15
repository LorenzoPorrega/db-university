-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT `degrees`.`name` AS `Immatricolat* in CdL`, `students`.`name` AS `Name`, `students`.`surname` AS `Surname`
FROM `degrees`
INNER JOIN `students`
ON `students`.`degree_id` = `degrees`.`id`
WHERE `degrees`.`name` =  "Corso di Laurea in Economia";

-- 2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze
SELECT `departments`.`name` AS `Dipartimento`, `degrees`.`id` AS `ID corso`, `degrees`.`name` AS `Nome CdL`
FROM `departments`
INNER JOIN `degrees`
ON `departments`.`id` = `degrees`.`department_id`
WHERE `departments`.`name` = "Dipartimento di Neuroscienze";

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT `teachers`.`name` AS "Nome", `teachers`.`surname` AS "Cognome", `courses`.`name` AS "Nome corso di appartenenza", `courses`.`id` AS "ID corso"
FROM `teachers`
INNER JOIN `course_teacher`
ON `course_teacher`.`teacher_id` = `teachers`.`id`
INNER JOIN `courses`
ON `courses`.`id` = `course_teacher`.`course_id`
WHERE `teachers`.`name` = "Fulvio"
AND `teachers`.`surname` = "Amato";

-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome
SELECT `students`.`name` AS "Name", `students`.`surname` AS "Cognome", `degrees`.`name` AS "CdL di appartenenza", `degrees`.`id` AS "ID CdL", `departments`.`name` AS "Dipartimento di afferenza", `departments`.`id` AS "ID dipartimento"
FROM `students`
INNER JOIN `degrees`
ON `students`.`degree_id` = `degrees`.`id`
INNER JOIN `departments`
ON `departments`.`id` = `degrees`.`department_id`
ORDER BY `students`.`name`, `students`.`surname` ASC;

-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
SELECT `degrees`.`name` AS "Nome CdL", `degrees`.`id` AS "ID CdL", `courses`.`name` AS "Insegnamento", `courses`.`id` AS "ID Insegnamento", CONCAT(`teachers`.`name`, " ", `teachers`.`surname`) AS "Professore", `teachers`.`id` AS "ID Professore"
FROM `degrees`
INNER JOIN `courses`
ON `degrees`.`id` = `courses`.`degree_id`
INNER JOIN `course_teacher`
ON `courses`.`id` = `course_teacher`.`course_id`
INNER JOIN `teachers`
ON `course_teacher`.`teacher_id` = `teachers`.`id`;

-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)
SELECT `departments`.`name` AS "Dipartimento di afferenza", `departments`.`id` AS "ID dipartimento", CONCAT(`teachers`.`name`, " " ,`teachers`.`surname`) AS "Professore",  `degrees`.`name` AS "CdL", `degrees`.`id` AS "ID CdL"
FROM `departments`
INNER JOIN `degrees`
ON `degrees`.`department_id` = `departments`.`id`
INNER JOIN `courses`
ON `courses`.`degree_id` = `degrees`.`id`
INNER JOIN `course_teacher`
ON `course_teacher`.`course_id` = `courses`.`id`
INNER JOIN `teachers`
ON `teachers`.`id` = `course_teacher`.`teacher_id`
WHERE `departments`.`name` = "Dipartimento di Matematica";

-- 7. BONUS: Selezionare per ogni studente il numero di tentativi sostenuti per ogni esame, stampando anche il voto massimo. Successivamente, filtrare i tentativi con voto minimo 18
SELECT `courses`.`name` AS "Nome Insegnamento", CONCAT(`students`.`name`, " " , `students`.`surname`)  AS "Nome studente", MAX(IF(`exam_student`.`vote` >= 18, `exam_student`.`vote`, CONCAT("INSUFFICIENTE", " (", `exam_student`.`vote`, ")" ))) AS "Voto massimo ottenuto", COUNT(`exam_student`.`student_id`) AS "Numero di tentativi" 
FROM `exam_student`
INNER JOIN `exams`
ON `exam_student`.`exam_id` = `exams`.`id`
INNER JOIN `students`
ON `exam_student`.`student_id` = `students`.`id`
INNER JOIN `courses`
ON `courses`.`id` =  `exams`.`course_id`
GROUP BY `courses`.`name`, `exam_student`.`student_id`, IF(`exam_student`.`vote` >= 18, `exam_student`.`vote`, "")
ORDER BY `students`.`name`, `students`.`surname` ASC;