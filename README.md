# BAO-Health-and-Wellness-Analysis

![ ](https://github.com/Abidemiseyi/BAO-Health-and-Wellness-Analysis/blob/main/front%20page.png)

## Project Objectives:
This analysis aims to assess and categorize an organization's employee stress levels. The primary goals are to:
*	Understand key factors contributing to stress.
*	Evaluate patterns related to stress severity and duration.
*	Identify correlations between stress, source, and coping mechanisms.
*	Provide actionable insights for stress management interventions.

## Problem Statement:
The organization is facing high employee stress levels, negatively affecting well-being and productivity. Despite wellness initiatives, the company lacks clarity on the key causes of stress and how physiological indicators like cortisol and heart rate align with reported stress levels. The organization needs insights into stress patterns and effective coping mechanisms to develop targeted interventions and reduce employee stress.

## DataSet Description:
|Column Name|Decsription|
|:----------|:---------|
|ID|Unique identifier for each record|
|First Name|	The first name of the individual|
|Last Name|	The last name of the individual|
|Date of Birth|	The birth date of the individual|
|Gender|	The gender of the individual|
|Date|	The date the stress level was reported|
|Time|	The time the stress level was reported|
|Self-Reported Stress Score|	The individual's perceived level of stress|
|Stress Source|	The primary cause of stress for the individual|
|Physical Symptoms|	Physical symptoms experienced due to stress|
|Emotional Symptoms|	Emotional symptoms experienced due to stress|
|Coping Mechanisms|	Methods used to cope with stress|
|Duration of Stress (days)|	The duration of stress experienced in days|
|Severity|	The severity of the stress experienced|
|Heart Rate|	The heart rate of the individual at the time of reporting in beats per minute|
|Cortisol Level|	The cortisol level of the individual at the time of reporting in Âµg/dL|
|Sleep Quality|	The quality of sleep reported by the individual|
|Mood|	The mood of the individual at the time of reporting|

## Data Preprocessing
1. Data Cleaning: The data was cleaned using SQL;
2. Renaming Columns: Columns were renamed for clarity and consistency of headings.
3. Data Standardization:
* Updated gender data: 'M' to 'Male' and 'F' to 'Female'.
* Corrected data entries in the 'Physical Symptoms' column: 'Stomach age' changed to 'stomach ache' and ‘Arthritis Pain’ changed to ‘Arthritis’
4. Removing Duplicates: Eliminated duplicate records to ensure data accuracy.
5. Handling Missing Data:
* Updated missing values in the ' Level ' with the average to retain employee data.
* Removed records with null values after.
6. Adding New Columns: Added columns for 'Age', 'Age Group', ‘Time of the day’, ‘Stress Category’, and ‘Stress Rate Category’ by modifying the SQL view.

## Exploratory Data Analysis (EDA)
The refined data, processed in SQL, was then imported into Excel for in-depth analysis and visualization.
The Excel workflow encompassed three main stages:
* First, descriptive statistics was computed to understand the data's fundamental characteristics.
* Next, various charts and graphs were generated to illustrate key trends and patterns visually.
* Finally, interactive dashboards was constructed to present the findings in an engaging and accessible format, enabling efficient communication of the most significant insights from the analysis.

## Statistical Analysis
For statistical analysis, the following methods were used:
*	Descriptive Statistics: Generated summary statistics for various variables, including cortisol levels, stress severity, and heart rate, to quantify key metrics.
*	Comparative Analysis: Compared stress severity across different stress durations to assess how stress is distributed among workers over time.
*	Trend Analysis: Analyzed cortisol levels by time of day to identify fluctuations and deviations from typical patterns.
*	Categorical Analysis: Examined emotional and physical symptoms as well as their coping mechanisms in relation to heart rate and cortisol level to understand the impact of different symptoms and their corresponding psychological and physiological responses. 

![ ](https://github.com/Abidemiseyi/BAO-Health-and-Wellness-Analysis/blob/main/Dashboard.png)

## Tools Used
* SQL: Used for data cleaning and preprocessing.
* Excel: Used for analysis, visualization, and creating interactive dashboards.

## Analysis
### Analysis Questions
*	How is stress severity distributed among the employees?
* What are the patterns of cortisol levels throughout the day?
*	What are the patterns of heart rate throughout the day?
*	What are the top stress sources among the employees?
*	What are the top stress coping mechanisms among employees?
*	How do physical symptoms correlate with heart rate?
*	What are the stress level score across age group?

### Approach
Each question was addressed using descriptive statistics, visualizations, and statistical tests to determine significance and identify key trends.

### Insights
* Severity Distribution: In the analysis of stress severity among 5,000 employees, 39% are experiencing mild stress, 40% are dealing with moderate stress, and 21% are facing severe stress. This distribution highlights that while most employees are managing mild to moderate levels of stress, a significant portion is under severe stress, which may require targeted interventions.
  
![ ](https://github.com/Abidemiseyi/BAO-Health-and-Wellness-Analysis/blob/main/Chart%201.png)

* Stress Symptoms Analysis (Emotional Symptoms): The analysis of emotional symptoms reveals that although cortisol level declines slowly during the course of the day, Emotional states like anger, anxiety, and mood swings are closely linked to changes in cortisol levels and heart rate due to the body's stress response. Anger and acute stress trigger the release of cortisol and activate the sympathetic nervous system, leading to elevated heart rate and blood pressure. Chronic stress, including prolonged anger or depression, can cause sustained high cortisol levels and an increase in resting heart rate, while also reducing heart rate variability (HRV), which is essential for the body's adaptability to stress. Over time, these physiological changes increase the risk of health issues such as cardiovascular disease, hypertension, and metabolic disorders. Although the cortisol level is decreasing as expected, the heart beat rate fluctuated in response to stress.

* Stress Symptoms Analysis (Physical Symptoms): Headaches, insomnia, and stomach aches are common stress-related symptoms that are closely linked to elevated cortisol levels and increased heart rate. High cortisol can cause muscle tension, disrupt sleep cycles, and interfere with digestion, leading to these symptoms. For example, elevated cortisol can trigger tension headaches, cause insomnia by disrupting the body's natural rhythm, and slow digestion, leading to stomach discomfort. Increased heart rate, a part of the body's stress response, further exacerbates these issues by maintaining a heightened state of alertness and reducing blood flow to non-essential functions like digestion.
In this case though, as the cortisol level was reducing, the heart beat rate was increasing implying that the Chronic stress or emotional factors kept the sympathetic nervous system overactive, leading to increased heart rate and continued symptoms despite lower cortisol.

![ ](https://github.com/Abidemiseyi/BAO-Health-and-Wellness-Analysis/blob/main/Chart%202.png)

* Cortisol Levels by Time of Day: Cortisol levels generally decrease by 8 AM, rise to a peak around noon, drop again by 2 PM, and then rise slightly from 3 PM to 7 PM. This pattern shows a midday peak with fluctuations throughout the day, which may differ from the typical cortisol rhythm that peaks in the early morning.
  
![ ](https://github.com/Abidemiseyi/BAO-Health-and-Wellness-Analysis/blob/main/Chart%203.png)

* Elevated Risk Profiles: Analysis identified a subset of employees experiencing both elevated heart rates and poor sleep quality due to stress. Among these individuals, a significant portion faces work related issues, financial issues and family issues. This highlights a potential link between high heart rates, poor sleep, and specific stress sources, indicating a need for targeted wellness interventions and support for affected employees.

## Recommendations
* Severity Distribution: Focus on intensive support for employees with severe stress, offer coping workshops for those with moderate stress, and implement preventive measures to manage mild stress effectively.
* Stress Symptoms Analysis: Increase support anxiety and mood swing with more counseling options. Address anger and loneliness with targeted programs. For Physical Symptoms focus on reducing fatigue through wellness programs and better work setups and rest breaks, and provide extra support for conditions like stomach aches that significantly impact heart rate.
* Cortisol Levels by Time of Day: Investigate potential factors causing the midday peak in cortisol levels and the fluctuations throughout the day. Consider adjusting work schedules or wellness programs to align with natural cortisol rhythms and address any underlying issues contributing to these variations.
* Elevated Risk Profiles: Focus wellness programs on employees with high heart rates and poor sleep, particularly those facing financial, work, and family issues. Ensure support is inclusive and addresses various stress sources to benefit all affected employees.

## Conclusion
This project investigated employee well-being by analyzing various symptoms and their effects. The results indicated that while mild to moderate stress is common, a substantial number of employees experience severe stress. Heart rate patterns fluctuated monthly, with significant peaks and dips, and cortisol levels followed a typical midday increase.
Emotional and physical symptoms were associated with different heart rate changes, and prolonged stress intensified these effects. The study also highlighted a group of employees with elevated heart rates and poor sleep, emphasizing the need for targeted wellness programs. Overall, the findings suggest that customized health initiatives addressing both stress and its physical consequences could greatly improve employee well-being

### Connect with me on socials:
[LinkedIn](https://www.linkedin.com/in/bilikis-adewole-gmnse-b34729230/) | 
[Twitter](https://x.com/AdewoleBidemi)
