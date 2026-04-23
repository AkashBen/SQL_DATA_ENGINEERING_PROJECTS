/*
1. What are the most in-demand skills for data Analyst?
- Join job postings to inner join table similar to query 2
- Identify the top 10 in-demand skills for data engineers
- Focus on remote job postings
- Why? Retrieves the top 10 skills with the highest demand in the remote job market,
    providing insights into the most valuable skills for data engineers seeking remote work
*/

  SELECT
    sd.skills AS skills,
    count(jpf.*) AS demand_count
FROM job_postings_fact AS jpf 
INNER JOIN skills_job_dim AS sjd 
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd 
    ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short = 'Data Analyst'
    AND jpf.job_work_from_home = True

GROUP BY 
    sd.skills
ORDER BY  
    count(jpf.*) DESC
LIMIT 10;

/*
SQL and Python dominate by a wide margin → They’re essentially non-negotiable core skills for remote data analyst roles. SQL especially is far ahead, meaning querying and working with databases is the foundation of the role.
Excel is still extremely relevant → Despite modern tools, it’s nearly as in-demand as Python. That tells you many analyst workflows still rely on spreadsheets for reporting, ad-hoc analysis, and business use.
Visualization tools are critical → Tableau and Power BI both rank high, showing that communicating insights visually is just as important as analyzing data.
Programming beyond Python is secondary → Languages like R and Go appear, but with much lower demand. They’re useful differentiators, not core requirements.
Cloud (AWS) is emerging but not dominant → Amazon Web Services shows up, but lower in rank, suggesting analysts are increasingly expected to work with cloud data—but it’s not yet a baseline skill.
Bottom line

If you’re targeting remote data analyst roles, the strongest stack is:
SQL + Python + Excel + (Tableau or Power BI)

┌──────────┬──────────────┐
│  skills  │ demand_count │
│ varchar  │    int64     │
├──────────┼──────────────┤
│ sql      │        15293 │
│ python   │         9973 │
│ excel    │         9274 │
│ tableau  │         8213 │
│ power bi │         5946 │
│ r        │         4714 │
│ sas      │         3430 │
│ looker   │         2153 │
│ go       │         1714 │
│ aws      │         1658 │
└──────────┴──────────────┘
  10 rows       2 columns
  
  */

/*
2. What are the most in-demand skills for FUll time data Analyst in UK?
- Join job postings to inner join table similar to query 2
- Identify the top 10 in-demand skills for data engineers
- Focus on remote job postings
- Why? Retrieves the top 10 skills with the highest demand in the remote job market,
    providing insights into the most valuable skills for data engineers seeking remote work
*/

   SELECT
    sd.skills AS skills,
    count(jpf.*) AS demand_count
FROM job_postings_fact AS jpf 
INNER JOIN skills_job_dim AS sjd 
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd 
    ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short = 'Data Analyst'
    AND jpf.job_schedule_type = 'Full-time'
    AND jpf.job_country = 'United Kingdom'
GROUP BY 
    sd.skills
ORDER BY  
    count(jpf.*) DESC
LIMIT 10;


/*

Here’s what your UK full-time Data Analyst results are really telling you:

📊 Key insights
SQL + Excel dominate the market
The gap between SQL (9678) and everything else confirms these two are the core, must-have skills. If you’re missing either, you’re underqualified for a large portion of roles.
Clear preference for Power BI over Tableau
Power BI significantly outranks Tableau, which strongly suggests UK companies favor the Microsoft ecosystem for reporting and dashboards.
Python is important—but secondary
It’s solidly in the top 4, but still behind BI tools. This indicates many roles expect basic to intermediate Python, not heavy programming.
Analytics is tightly tied to Microsoft stack
The appearance of Microsoft Azure plus Power BI and Excel shows a consistent pattern:
→ UK roles lean toward end-to-end Microsoft-based data workflows
Visualization + communication matter a lot
Microsoft PowerPoint making the top 10 is a strong signal that analysts are expected to present insights, not just generate them.
Legacy and niche tools still exist
R and SAS appear but at much lower demand—these are industry-specific or legacy, not core requirements.

┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │         9678 │
│ excel      │         8508 │
│ power bi   │         5967 │
│ python     │         5102 │
│ tableau    │         3561 │
│ r          │         2490 │
│ sas        │         1390 │
│ azure      │         1295 │
│ go         │          924 │
│ powerpoint │          919 │
└────────────┴──────────────┘
  10 rows         2 columns

  */


  /*
3. What are the most in-demand skills for data engineers?
- Join job postings to inner join table similar to query 2
- Identify the top 10 in-demand skills for data engineers
- Focus on remote job postings
- Why? Retrieves the top 10 skills with the highest demand in the remote job market,
    providing insights into the most valuable skills for data engineers seeking remote work
*/



SELECT
    sd.skills AS skills,
    count(jpf.*) AS demand_count
FROM job_postings_fact AS jpf 
INNER JOIN skills_job_dim AS sjd 
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd 
    ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = True

GROUP BY 
    sd.skills
ORDER BY  
    count(jpf.*) DESC
LIMIT 10;

/*

Here's the breakdown of the most demanded skills for data engineers:
SQL and Python are by far the most in-demand skills, with around 29,000 job postings each - nearly double the next closest skill.
Cloud platforms round out the top skills, with AWS leading at ~18,000 postings, followed by Azure at ~14,000.
Apache Spark completes the top 5 with nearly 13,000 postings, highlighting the importance of big data processing skills.

Key takeaways:
- SQL and Python remain the foundational skills for data engineers
- Cloud platforms (AWS, Azure) are critical for modern data engineering
- Big data tools like Spark continue to be highly valued
- Data pipeline tools (Airflow, Snowflake, Databricks) show growing demand
- Java and GCP round out the top 10 most requested skills

┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        29221 │
│ python     │        28776 │
│ aws        │        17823 │
│ azure      │        14143 │
│ spark      │        12799 │
│ airflow    │         9996 │
│ snowflake  │         8639 │
│ databricks │         8183 │
│ java       │         7267 │
│ gcp        │         6446 │
└────────────┴──────────────┘
  10 rows         2 columns
  */