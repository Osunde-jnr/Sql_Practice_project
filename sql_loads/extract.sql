SELECT 
job_title_short,
EXTRACT(MONTH FROM job_posted_date)
FROM job_postings_fact
LIMIT 100