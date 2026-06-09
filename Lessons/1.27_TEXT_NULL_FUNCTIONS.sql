select
    job_title_short,
    salary_year_avg,
    salary_hour_avg,
    COALESCE(salary_year_avg, salary_hour_avg*2080) as cleaned_salary,
    case 
        WHEN COALESCE(salary_year_avg, salary_hour_avg*2080) is Null THEN 'missing'
        WHEN COALESCE(salary_year_avg, salary_hour_avg*2080) < 75000 THEN 'Low'
        When COALESCE(salary_year_avg, salary_hour_avg*2080) < 150000 THEN 'Medium'
        ELSE 'High'
    END as salary_bucket
    from job_postings_fact
    order by cleaned_salary DESC;