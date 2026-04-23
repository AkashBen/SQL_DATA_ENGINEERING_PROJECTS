
/*
1. What are the highest-paying skills for data Analyst?
- Calculate the median salary for each skill required in data engineer positions
- Focus on Full time positions with specified salaries in UK
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing 
    how common those skills are, providing a more complete picture for skill development priorities
*/

SELECT
    sd.skills AS skills,
    round(median(jpf.salary_year_avg), 0) as median_salary,
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
HAVING demand_count > 100
ORDER BY  
    median_salary Desc
LIMIT 25;


/*
Here's a breakdown of the highest-paying skills for Data Analysts:

Key Insights:
High salary ≠ high demand

Skills like C++, MongoDB, NoSQL top the salary list but have low demand counts
→ These are specialized/niche skills, not typical for most data analyst roles

Best “value” skills (high demand + strong pay)
Amazon Web Services (AWS), SQL variants, DAX, Azure
→ These sit in the sweet spot of good salaries + solid demand
Especially DAX + SQL Server + Azure → strong alignment with BI roles

Python is high demand, but not highest paying
Python has the highest demand (5102) but relatively lower median salary
→ It’s a baseline skill, not a premium differentiator

Cloud & big data = salary boost
Tools like Redshift, Spark, Hadoop, Databricks
→ Consistently associated with higher salaries
→ Signal: working with large-scale data systems pays more

Enterprise + compliance skills matter
GDPR appearing with strong salary and demand
→ UK market values data governance + compliance knowledge

BI ecosystem still strong
DAX, SSRS, Qlik
→ Reinforces that reporting + dashboarding roles are well-paid and common

Bottom line
Highest paying skills → niche / engineering-heavy

Most valuable career skills →

SQL + Cloud (AWS/Azure) + BI tools (DAX/SQL Server)
------------------------------------------------------------

  skills   │ median_salary │ demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ c++        │      177283.0 │          127 │
│ mongodb    │      165000.0 │          174 │
│ nosql      │      163782.0 │          158 │
│ pandas     │      139219.0 │          268 │
│ numpy      │      139219.0 │          159 │
│ aws        │      138088.0 │          703 │
│ mysql      │      131750.0 │          251 │
│ redshift   │      122925.0 │          149 │
│ javascript │      111175.0 │          220 │
│ hadoop     │      111175.0 │          154 │
│ oracle     │      111175.0 │          513 │
│ java       │      111150.0 │          282 │
│ gdpr       │      105000.0 │          576 │
│ dax        │      105000.0 │          763 │
│ express    │      104757.0 │          230 │
│ spark      │      102325.0 │          204 │
│ sql server │       98500.0 │          760 │
│ matlab     │       98500.0 │          163 │
│ ssrs       │       98500.0 │          476 │
│ c#         │       94250.0 │          141 │
│ azure      │       93938.0 │         1295 │
│ qlik       │       91500.0 │          381 │
│ sheets     │       90675.0 │          327 │
│ databricks │       89375.0 │          421 │
│ python     │       89100.0 │         5102 │
└────────────┴───────────────┴──────────────┘
  25 rows                         3 columns
*/




/*
3. What are the highest-paying skills for data engineers?
- Calculate the median salary for each skill required in data engineer positions
- Focus on remote positions with specified salaries
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing 
    how common those skills are, providing a more complete picture for skill development priorities
*/

SELECT
    sd.skills AS skills,
    round(median(jpf.salary_year_avg), 0) as median_salary,
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
HAVING demand_count > 100
ORDER BY  
    median_salary Desc
LIMIT 25;

/*
Here's a breakdown of the highest-paying skills for Data Engineers:

Key Insights:
- Rust remains the top-paying skill at $210K median salary, though demand is still relatively limited (232 postings).
- Terraform and Golang both have high median salaries at $184K, with strong demand (Terraform: 3,248 postings; Golang: 912 postings).
- Other notable skills with both high pay and moderate-to-high frequency include:
  - Spring: $175.5K median salary (364 postings)
  - Neo4j: $170K median salary (277 postings)
  - GDPR: $169.6K median salary (582 postings)
  - GraphQL: $167.5K median salary (445 postings)
  - Kubernetes: $150.5K median salary (4,202 postings)
  - Airflow: $150K median salary (9,996 postings)
- Bitbucket, Ruby, Redis, Ansible, and Jupyter all appear in the top 25 for pay, each with hundreds of postings.
- Most skills on the list are no longer extreme statistical outliers with just a handful of postings; instead, many show consistently strong demand.

Takeaway: While the very top-paying skill (Rust) still has less demand than major cloud and data tools, most of the top-paying skills have both solid salaries and significant demand. This suggests that learning tools like Terraform, Golang, Spring, Neo4j, and especially core data engineering tools (Airflow, Kubernetes) provides a strong balance between compensation and marketability.

┌────────────┬───────────────┬──────────────┐
│   skills   │ median_salary │ demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ rust       │      210000.0 │          232 │
│ golang     │      184000.0 │          912 │
│ terraform  │      184000.0 │         3248 │
│ spring     │      175500.0 │          364 │
│ neo4j      │      170000.0 │          277 │
│ gdpr       │      169616.0 │          582 │
│ zoom       │      168438.0 │          127 │
│ graphql    │      167500.0 │          445 │
│ mongo      │      162250.0 │          265 │
│ fastapi    │      157500.0 │          204 │
│ bitbucket  │      155000.0 │          478 │
│ django     │      155000.0 │          265 │
│ crystal    │      154224.0 │          129 │
│ atlassian  │      151500.0 │          249 │
│ c          │      151500.0 │          444 │
│ typescript │      151000.0 │          388 │
│ kubernetes │      150500.0 │         4202 │
│ airflow    │      150000.0 │         9996 │
│ ruby       │      150000.0 │          736 │
│ css        │      150000.0 │          262 │
│ node       │      150000.0 │          179 │
│ redis      │      149000.0 │          605 │
│ vmware     │      148798.0 │          136 │
│ ansible    │      148798.0 │          475 │
│ jupyter    │      147500.0 │          400 │
└────────────┴───────────────┴──────────────┘

*/


