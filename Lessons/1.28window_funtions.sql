select count(*) from job_postings_fact;


select 
    job_id,
    job_title_short,
    count(*) over(partition by job_title_short) as cnt_fun
    from job_postings_fact
    order by job_id;


    select 
    job_id,
    job_title_short,
    salary_hour_avg,
    avg(salary_hour_avg) over(partition by job_title_short)
    from job_postings_fact;
   