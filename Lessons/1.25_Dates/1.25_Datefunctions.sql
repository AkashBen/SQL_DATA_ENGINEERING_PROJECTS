select job_posted_date,
job_posted_date::Date as date,
job_posted_date::Time as time,
job_posted_date::TIMESTAMP as timestamp,
job_posted_date::TIMESTAMPTZ as timestamptz,
FROM job_postings_fact
limit 10;


select job_posted_date,
Extract(YEAR from job_posted_date) as date,
Extract(MONTH from job_posted_date) as month,
Extract(DAY from job_posted_date) as day,
Extract(HOUR from job_posted_date) as hr,
Extract(MINUTE from job_posted_date) as min,
Extract(Decade from job_posted_date) as dec
FROM job_postings_fact
limit 10;


select job_posted_date,
date_trunc('MONTH', job_posted_date),
date_trunc('WEEK', job_posted_date)
FROM job_postings_fact
order by random()
limit 10;

select
    '2026-05-01 00:00:00+00'::timestamptz AT TIME ZONE 'UTC';


select job_posted_date,
    job_posted_date at time ZONE 'UTC'
FROM job_postings_fact
limit 10;