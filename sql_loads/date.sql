SELECT 
job_title_short AS job_title,
job_location AS job_location,
job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST'  AS job_date,
FROM job_postings_fact
LIMIT 100