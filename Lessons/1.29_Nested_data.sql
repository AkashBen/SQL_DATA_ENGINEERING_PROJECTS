-- array set
select 'python' as skills
UNION ALL
select 'sql'
UNION ALL
select 'r';

with skills as(
    select 'python' as skills
UNION ALL
select 'sql'
UNION ALL
select 'r'
), skills_array as(
    select array_agg(skills order by skills) as skill from skills
)

select skill[1] as first_skill,
skill[2]as second_skill,
skill[3] as third_skill
 from skills_array;


 -- Array FInal Example
 -- Build a flat skill table for co-workers to access job tiltles, salary info, and skills in one table
create TEMP TABLE job_skills_array as
SELECT 
    jpf.job_id,
    jpf.job_title_short,
    jpf.salary_year_avg,
    array_agg(sd.skills) as skills_array
FROM job_postings_fact jpf 
LEFT JOIN skills_job_dim sjd 
on jpf.job_id = sjd.job_id
LEFT JOIN skills_dim sd 
on sd.skill_id = sjd.skill_id
GROUP BY ALL
order by job_id;

with flat_skill as (
select job_id,
job_title_short,
salary_year_avg,
UNNEST(skills_array) as skills
from job_skills_array
)
select 
skills, median(salary_year_avg) as salary_median
from flat_skill
group by skills
order by salary_median desc;

-- STRUCT FINAL EXAMPLE
-- Build a flat skill & type table for co-workers to acess job titles, salary info, skills and type in one table
create TEMP TABLE job_skills_array_struct as
SELECT 
    jpf.job_id,
    jpf.job_title_short,
    jpf.salary_year_avg,
    array_agg(
        STRUCT_PACK(
            skill_type:= sd.type,
            skill_name:= sd.skills
        )
    ) AS skills_type
FROM job_postings_fact jpf 
LEFT JOIN skills_job_dim sjd 
on jpf.job_id = sjd.job_id
LEFT JOIN skills_dim sd 
on sd.skill_id = sjd.skill_id
GROUP BY ALL
order by job_id;


with flat_skill as (
select 
    job_id,
    job_title_short,
    salary_year_avg,
    UNNEST(skills_type).skill_type as skill_type,
    UNNEST(skills_type).skill_name as skill_name
FROM job_skills_array_struct
)
select 
skill_type, median(salary_year_avg) as salary_median
from flat_skill
group by skill_type
order by salary_median desc;






  

