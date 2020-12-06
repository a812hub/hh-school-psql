/*
 * Название вакансии, город, в котором опубликована вакансия, имя работодателя для первых 10 вакансий, 
 * у которых не указана зарплата, сортировать по дате создания вакансии от новых к более старым.
 */

SELECT
    position_name,
    area_name,
    company_name
FROM area
INNER JOIN vacancy ON area.area_id = vacancy.area_id
INNER JOIN company ON company.company_id = vacancy.company_id
WHERE
    compensation_from IS NULL
    AND compensation_to IS NULL
ORDER BY time_stamp DESC
LIMIT 10;


/* Средняя максимальная зарплата в вакансиях, средняя минимальная и средняя средняя (compensation_to - compensation_from) до вычета налогов. */

SELECT
    avg(
        CASE WHEN compensation_gross IS TRUE
            THEN compensation_to
            ELSE compensation_to / 0.87
        END
        ) AS avg_salary_max,
    avg(
        CASE WHEN compensation_gross IS TRUE
             THEN compensation_from
             ELSE compensation_from / 0.87
        END
        ) AS avg_salary_min,
    avg(
        CASE WHEN compensation_gross IS TRUE
             THEN compensation_to - compensation_from
             ELSE (compensation_to - compensation_from) / 0.87
        END
        ) AS avg_salary_range
FROM vacancy;


/* Топ-5 компаний, получивших максимальное количество откликов на одну вакансию, в порядке убывания откликов. */

WITH count_of_responses AS (
    SELECT DISTINCT
        company_name,
        max(count(response.vacancy_id <> 0)) OVER (PARTITION BY company_name) as max_count_of_responses
    FROM company
    LEFT JOIN vacancy ON vacancy.company_id = company.company_id
    LEFT JOIN response ON response.vacancy_id = vacancy.vacancy_id
    GROUP BY company_name, response.vacancy_id
)
SELECT
    company_name
FROM count_of_responses
ORDER BY count_of_responses.max_count_of_responses DESC, company_name
LIMIT 5;


/* Медианное количество вакансий на компанию. */

WITH count_of_vacancies AS (
    SELECT
        company.company_id,
        count(vacancy.vacancy_id <> 0) AS count
    FROM company
    LEFT JOIN vacancy ON vacancy.company_id = company.company_id
    GROUP BY company.company_id
)
SELECT
    percentile_cont(0.50) WITHIN GROUP (ORDER BY count) AS median_cont
FROM count_of_vacancies;


/* Минимальное и максимальное время от создания вакансии до первого отклика для каждого города. */

SELECT DISTINCT
    area.area_name,
    max(response.time_stamp - vacancy.time_stamp) OVER (PARTITION BY vacancy.area_id) AS max_time_to_response,
    min(response.time_stamp - vacancy.time_stamp) OVER (PARTITION BY vacancy.area_id) AS min_time_to_response
FROM area
LEFT JOIN vacancy ON area.area_id = vacancy.area_id
LEFT JOIN response ON response.vacancy_id = vacancy.vacancy_id;
