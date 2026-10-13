# HR Employee Attrition Analysis

Analysis of 1,470 employee records to understand why employees leave and who is at risk.

## Tools
MySQL, Power BI, Python (Pandas, Matplotlib, Seaborn)

## Files
- `HR-Employee-Attrition.csv` - dataset (1,470 rows, 35 columns)
- `hr_attrition_eda.ipynb` - EDA in Python
- `hr_attrition_queries.sql` - 24 MySQL queries
- `HR_Attrition_Dashboard.pbix` - 6-page Power BI dashboard

## What I did
- Ran EDA on categorical and numeric columns and compared attrition across groups
- Wrote SQL using CTEs, RANK, NTILE and PERCENT_RANK
- Calculated attrition by department, job role, tenure and income decile
- Built a risk score to list the 50 highest-risk employees and created a summary view
- Built a Power BI dashboard with an insights and recommendations page

## Key findings
- Overall attrition is 16.1% (237 of 1,470 employees)
- Overtime employees leave far more often: about 30.5% vs 10.4%
- Sales (20.6%) and HR (19.0%) have higher attrition than R&D (13.8%)
