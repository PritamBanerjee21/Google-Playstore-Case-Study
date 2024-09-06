# Google Playstore Data Case Study

## Table of Contents
- [Overview](#overview)
- [Project Structure](#project-structure)
- [Data Cleaning](#data-cleaning)
- [Data Loading](#data-loading)
- [Case Study](#case-study)
- [How to Run the Project](#how-to-run-the-project)
- [Conclusions](#conclusions)
- [Technologies Used](#technologies-used)


## Overview
This project provides a **comprehensive analysis of Google Playstore data** with more than 10,000 records. The case study is divided into three major parts: **Data Cleaning**, **Data Loading**, and **Case Study Analysis**.

The data contains features such as:
Unnamed:0, App, Category, Rating, Reviews, Size, Installs, Price, Content, Rating, Genres, Last Updated, Current Ver, Android Ver

This project emphasizes data cleaning processes, challenges in data loading into **MySQL**, and a thorough case study through **SQL queries**, including **Window Functions**, **CTEs**, **Triggers**, **Custom Functions**, and **Joins**.

## Project Structure
The project is organized into the following sections:
1. **Data Cleaning:** Cleaning and preparing the dataset.
2. **Data Loading:** Loading the dataset into **MySQL**.
3. **Case Study:** SQL analysis and insights.

## Data Cleaning
The **Data Cleaning** part was performed using **Python** in a **Jupyter Notebook**. Key steps include:
- **Handling null values**: Removed nulls to ensure data integrity.
- **Data type adjustments**: Corrected inappropriate data types to enable accurate queries.
- **Dropped unnecessary columns**: Removed the irrelevant "Unnamed:0" column.
- **Character cleaning**: Removed unwanted characters within the records.
  
The clean dataset contains **9,360 records** and is saved in a CSV file named `cleaned.csv`.

## Data Loading
The **Data Loading** section involved loading the clean dataset into a **MySQL** database. This step was challenging due to format mismatches with MySQL standards. Key steps include:
- Activated the **"In File" feature** in MySQL by modifying the server configuration.
- Initially attempted data loading, which partially succeeded but led to data loss due to format issues.
- **Truncated** the table to retain the schema and ensure clean data load.
- Successfully loaded the complete dataset using the **IN FILE** statement, resulting in the proper import of all records.

## Case Study
The **Case Study** part of the project involved answering **10 key business questions** using **SQL**. This section demonstrates advanced **SQL techniques** to gain insights into the dataset:
- **Window Functions**: Analyzed trends and rankings within the dataset.
- **Common Table Expressions (CTEs)**: Simplified complex queries by breaking them down.
- **Triggers**: Automated responses to certain data changes.
- **Custom Functions**: Created reusable functions for repetitive tasks.
- **Joins**: Performed multiple-table analysis to extract meaningful insights.

The case study highlights the depth of SQL knowledge, allowing for complex data analysis.

## How to Run the Project
To replicate this project, follow these steps:

1. Clone the repository:
    ```bash
    git clone https://github.com/your-repository-url
    ```

2. Navigate to the `data_cleaning` folder and run the **Jupyter Notebook** for the cleaning process.
   
3. Ensure that **MySQL Server** is installed and configure the **"In File" feature** as per MySQL documentation.

4. Load the cleaned CSV into **MySQL** following the steps in the `data_loading` folder.

5. Execute the SQL queries in the **case study** section to reproduce the analysis.

## Conclusions
This case study showcases how to tackle real-world data challenges, starting from cleaning the raw data, loading it into a database, and finally analyzing it using **advanced SQL techniques**. It demonstrates proficiency in handling complex datasets and conducting insightful analysis.

## Technologies Used
- **Python**: For data cleaning and manipulation.
- **Jupyter Notebook**: For documenting the cleaning process.
- **MySQL**: For database management and SQL querying.
- **SQL**: To perform detailed analysis using various SQL techniques.
