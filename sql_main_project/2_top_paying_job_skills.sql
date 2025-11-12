WITH top_paying_jobs AS (
  SELECT 
  job_id,
  job_title,
  salary_year_avg,
  name AS company_name
  FROM 
  job_postings_fact
  LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
  WHERE job_title_short = 'Data Analyst' AND job_location = 'Anywhere'
  AND salary_year_avg IS NOT NULL
  ORDER BY salary_year_avg DESC
  LIMIT 10
)

SELECT
top_paying_jobs.*,
skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC

/* Here’s a quick summary of insights from the **skills data** for the top 10 data analyst roles in 2023 👇

---

### 🔍 **Overview**

* **Total records:** 66 skill entries
* **Unique skills:** 28 distinct skills
* This suggests each job posting lists multiple overlapping competencies.

---

### 🧠 **Top 10 Most Common Skills**

| Rank | Skill         | Frequency | Insight                                                                                      |
| ---- | ------------- | --------- | -------------------------------------------------------------------------------------------- |
| 1️⃣  | **SQL**       | 8         | Core requirement across nearly all data roles; essential for querying and manipulating data. |
| 2️⃣  | **Python**    | 7         | Widely used for analysis, automation, and machine learning tasks.                            |
| 3️⃣  | **Tableau**   | 6         | Strong demand for data visualization and dashboarding expertise.                             |
| 4️⃣  | **R**         | 4         | Still relevant in statistics-heavy or academic-style analytics roles.                        |
| 5️⃣  | **Snowflake** | 3         | Reflects a shift toward cloud-based data warehousing.                                        |
| 6️⃣  | **Pandas**    | 3         | Core Python library for data manipulation — aligns with Python’s dominance.                  |
| 7️⃣  | **Excel**     | 3         | Surprisingly still in demand, especially for business reporting.                             |
| 8️⃣  | **Azure**     | 2         | Cloud integration skills increasingly valued.                                                |
| 9️⃣  | **Bitbucket** | 2         | Collaboration/version control in data projects.                                              |
| 🔟   | **Go**        | 2         | Likely appears in data engineering or analytics automation roles.                            |

---

### 📊 **Trends & Insights**

* **Python + SQL** remain the **foundational duo** — they appear in most analyst roles, signaling that every data analyst benefits from combining programming and querying skills.
* **Visualization tools (Tableau, Excel)** are still highly valued — business communication remains a key part of analytics.
* **Cloud & DevOps influence** is rising — skills like **Azure**, **Snowflake**, and **Bitbucket** show that analysts increasingly operate within integrated data ecosystems.
* **Hybrid roles** are emerging — the presence of **Go**, **Bitbucket**, and **Databricks** suggests crossover with data engineering.

---

Would you like me to visualize this (e.g., a bar chart of the most frequent skills or a word cloud)? It would make these patterns easier to see at a glance.
*/