CREATE TEMP TABLE jobs_2023 as
SELECT * EXCLUDE (job_id, job_posted_date)
 from job_postings_fact
 where EXTRACT(YEAR from job_posted_date) =2023;

 CREATE TEMP TABLE jobs_2024 as
SELECT * EXCLUDE (job_id, job_posted_date)
 from job_postings_fact
 where EXTRACT(YEAR from job_posted_date) =2024;

-- Which unique job postings appeared in either 2023 or 2024?

select 'jobs23' as table_name,
count(*) from jobs_2023
UNION
select 'jobs24' as table_name,
count(*) from jobs_2024;

-- which job postings aprreaed across both years, counting duplicates?
select * from jobs_2023
UNION ALL
select * from jobs_2024;

-- WHich job postings appeared in 2023 but not in 2024?
select * from jobs_2023
EXCEPT
select * from jobs_2024;

-- whcih job postings from 2023 remain after substarcting matching 2024 postings, one-for-one?
select * from jobs_2023
EXCEPT ALL
select * from jobs_2024;
