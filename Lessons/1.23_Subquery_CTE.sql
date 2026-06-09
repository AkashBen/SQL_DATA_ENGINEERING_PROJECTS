-- subquery:
-- Scenario 1 - subquery in 'SELECT'
-- SHow each job's salary next to the overall market median:

select
job_title_short,
salary_year_avg,
(
    SELECT median(salary_year_avg)
    FROM job_postings_fact
) as market_median_salary
from job_postings_fact
where salary_year_avg IS NOT NULL
LIMIT 10;



-- Scenario 2 - Subquery in FROM
-- Stage only jobs that are remote before aggregating to determine the remote median salary per job

select
job_title_short,
median(salary_year_avg),
(
    SELECT median(salary_year_avg)
    FROM job_postings_fact
    where job_work_from_home = TRUE
) as market_remote_median_salary
from (
    select job_title_short,
    salary_year_avg
    from job_postings_fact
    where job_work_from_home = TRUE
) as clean_jobs
where salary_year_avg IS NOT NULL
group by job_title_short
LIMIT 10;


-- Scenario 3 - subquery in 'HAVING'
-- Keep only job titles whose median salary is above the overall median:

select
job_title_short,
median(salary_year_avg) as median_sal,
(
    SELECT median(salary_year_avg)
    FROM job_postings_fact
    where job_work_from_home = TRUE
) as market_remote_median_salary
from (
    select job_title_short,
    salary_year_avg
    from job_postings_fact
    where job_work_from_home = TRUE
) as clean_jobs
where salary_year_avg IS NOT NULL
group by job_title_short
HAVING median_sal > market_remote_median_salary
LIMIT 10;



-- WHERE EXISTS

select * from range(3) as src(key);

select * from range(2) as tgt(key);

select * from range(3) as src(key)
where NOT EXISTS (
    select 1 from range(2) as tgt(key)
    where src.key=tgt.key
);


select * from 
job_postings_fact as tgt
where NOT EXISTS(
    select 1 from skills_job_dim as src
    where tgt.job_id = src.job_id
)
order by job_id;
