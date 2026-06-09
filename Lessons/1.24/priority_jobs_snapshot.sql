-- CREATE A TEMP Table
CREATE OR REPLACE TEMP TABLE src_priority_jobs as
    SELECT
    jpf.job_id,
    jpf.job_title_short,
    cd.name as company_name,
    jpf.job_posted_date as job_posted_date,
    jpf.salary_year_avg as salary_year_avg,
    r.priority_lvl as priority_lvl,
    CURRENT_TIMESTAMP as updated_at
FROM data_jobs.job_postings_fact jpf
LEFT JOIN data_jobs.company_dim cd 
on jpf.company_id = cd.company_id
INNER JOIN staging.priority_roles r 
on jpf.job_title_short = r.role_name;


-- Update Statement
-- UPDATE main.priority_jobs_snapshot as tgt
-- SET priority_lvl = src.priority_lvl,
--     updated_at = src.updated_at
-- FROM src_priority_jobs as src
-- where tgt.job_id = src.job_id
-- AND tgt.priority_lvl IS DISTINCT FROM src.priority_lvl;


-- -- INSERT STatement
-- INSERT INTO main.priority_jobs_snapshot(
--     job_id,
--     job_title_short,
--     company_name,
--     job_posted_date,
--     salary_year_avg,
--     priority_lvl,
--     updated_at
-- )
-- SELECT
--     src.job_id,
--     src.job_title_short,
--     src.company_name,
--     src.job_posted_date as job_posted_date,
--     src.salary_year_avg as salary_year_avg,
--     src.priority_lvl as priority_lvl,
--     src.updated_at
-- FROM src_priority_jobs as src
-- WHERE NOT EXISTS (
--     select 1 from main.priority_jobs_snapshot tgt
--     where tgt.job_id = src.job_id       
-- );


-- -- DELETE Statement
-- DELETE FROM main.priority_jobs_snapshot as tgt
-- WHERE NOT EXISTS(
--     SELECT 1 from src_priority_jobs as src
--     WHERE src.job_id = tgt.job_id
-- );

--MERGE Statement
MERGE INTO 
    main.priority_jobs_snapshot as tgt
USING
    src_priority_jobs as src
ON 
    tgt.job_id = src.job_id

WHEN MATCHED AND tgt.priority_lvl IS DISTINCT FROM src.priority_lvl THEN
UPDATE SET
    priority_lvl = src.priority_lvl,
    updated_at = src.updated_at

WHEN NOT MATCHED THEN
    INSERT (
        job_id,
        job_title_short,
        company_name,
        job_posted_date,
        salary_year_avg,
        priority_lvl,
        updated_at
    )
    VALUES (
        src.job_id,
        src.job_title_short,
        src.company_name,
        src.job_posted_date,
        src.salary_year_avg,
        src.priority_lvl,
        src.updated_at
    )

WHEN NOT MATCHED BY SOURCE THEN DELETE;


--FINAL Check QUERY
SELECT 
    job_title_short,
    count(*) as job_count,
    min(priority_lvl) as priority_lvl,
    min(updated_at) as updated_at
from main.priority_jobs_snapshot
GROUP BY job_title_short
ORDER BY job_count DESC;



