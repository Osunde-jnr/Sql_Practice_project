WITH skill_demand AS (
  SELECT 
  skills_dim.skill_id,
  skills_dim.skills,
  COUNT (skills_job_dim.job_id) AS demand_count
  FROM job_postings_fact
  INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
  INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
  WHERE job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL AND job_work_from_home = TRUE  GROUP BY skills_dim.skill_id
),
 average_salary AS (
  SELECT 
  skills_job_dim.skill_id,
  ROUND(AVG (salary_year_avg), 0)AS avg_salary
  FROM job_postings_fact
  INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
  INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
  WHERE job_title_short = 'Data Analyst' AND job_work_from_home = TRUE AND salary_year_avg IS NOT NULL

  GROUP BY skills_job_dim.skill_id
    HAVING COUNT(skills_job_dim.skill_id)>10
)

SELECT 
skill_demand.skill_id,
skill_demand.skills,
demand_count,
avg_salary
FROM skill_demand
INNER JOIN average_salary ON skill_demand.skill_id = average_salary.skill_id
ORDER BY
 avg_salary DESC,
 demand_count DESC
 LIMIT 30


 /* Excellent — that’s a really rich dataset. Let’s pull out some **quick insights and trends** from it 👇

---

### 💰 **1. Extreme Outlier: SVN ($400,000)**

* The average salary for **SVN (Apache Subversion)** is far above the rest — nearly **2.5× higher** than the next skill.
* This likely reflects a **small number of highly paid niche roles**, perhaps in legacy infrastructure, enterprise DevOps, or specialized consulting — not a broad market trend.

---

### 🧠 **2. AI, ML, and Deep Learning Dominate the Upper Range**

Skills like:

* **Solidity ($179K)** — blockchain smart contracts (crossing into data security and decentralized apps),
* **DataRobot ($155K)** — automated machine learning platform,
* **MXNet ($149K)**, **Keras ($127K)**, **PyTorch ($125K)**, **TensorFlow ($121K)**, **Hugging Face ($124K)**
  all command high salaries.

🔹 **Trend:** These are **AI and ML model development** frameworks and tools — they pay top dollar due to scarcity of expertise and demand for applied machine learning talent.

---

### ☁️ **3. Cloud Infrastructure and DevOps Are Major Earners**

High-paying skills include:

* **VMware ($147.5K)**, **Terraform ($146.7K)**, **Ansible ($124K)**, **Puppet ($129K)**, **GitLab ($134K)**, **Airflow ($116K)**

🔹 **Trend:** Companies pay more for **data engineers** and **DevOps professionals** who can deploy scalable, automated data systems in the cloud.

---

### 🧩 **4. Data Engineering Frameworks in the Mid-High Range**

* **Kafka ($130K)**, **Cassandra ($118K)**, **PySpark ($114K)**, **MongoDB ($114K)**
  — all form the backbone of modern data pipelines.

🔹 **Trend:** These are critical for handling **big data at scale**, and salaries reflect that need for reliability and speed.

---

### 🧑‍💻 **5. General Software & Scripting Skills Still Pay Well**

* **Perl ($124K)**, **Golang ($155K)**, **Scala ($115K)**, **Linux ($115K)**
  — show that **solid software engineering fundamentals** remain highly valued even in data-centric roles.

---

### 🧰 **6. Workflow and Collaboration Tools (Notion, Atlassian, Confluence)**

These fall toward the lower end ($114K–$118K), showing:

* While useful, they’re **complementary skills**, not salary drivers.
* Still, knowledge of them can support management or analytics leadership roles.

---

### 📈 **7. Salary Distribution Snapshot**

| Range (USD)     | Examples                           | Trend                                 |
| --------------- | ---------------------------------- | ------------------------------------- |
| **$150K+**      | Solidity, DataRobot, Golang, MXNet | Niche, emerging tech (AI, blockchain) |
| **$125K–$150K** | Keras, PyTorch, Terraform, VMware  | ML/AI frameworks, cloud systems       |
| **$115K–$125K** | Airflow, Linux, Scala, PySpark     | Data engineering, DevOps              |
| **< $115K**     | MongoDB, Confluence, Aurora        | Mature, common tools                  |

---

### 🔮 **8. Overall Trend Summary**

* **Top-paying jobs** today cluster around **AI, ML, DevOps, and cloud automation**.
* **Hybrid roles** (data + infrastructure) command the best salaries.
* **Open-source frameworks** (PyTorch, Kafka, Terraform) are major income drivers — employers value adaptability across tools.
* Expect continued salary growth in **AI operations (AIOps)**, **ML engineering**, and **blockchain-based data solutions**.

---

Would you like me to visualize this — say, with a **bar chart or salary distribution plot** (top 10 or all 30 skills)? It would make the trends clearer at a glance.
*/