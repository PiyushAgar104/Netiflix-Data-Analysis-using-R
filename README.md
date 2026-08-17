🎬 Netflix Data Analysis

An exploratory data analysis (EDA) project built in R to analyze Netflix's content catalog and discover patterns across content type, ratings, genres, countries, directors, release/addition trends, duration, seasons, and missing data.

📌 Project Overview

This project explores the Netflix Titles Dataset and converts raw Netflix catalog data into meaningful insights using R, dplyr, ggplot2, tidyr, stringr, and treemapify.

The analysis focuses on:

🎬 Movies vs TV Shows

⭐ Content ratings

🎭 Genre distribution

📈 Year-wise content addition

📅 Monthly content addition

🌍 Country-wise content

🎥 Top directors

📺 TV show seasons

⏱️ Movie duration

📊 Genre-wise average movie duration

🧹 Missing-value analysis

🌳 Treemap visualization

📊 Key Visualizations

1. Movies vs TV Shows

Compares the number of Movies and TV Shows available in the dataset.

2. Top 10 Netflix Ratings

Shows the most common content ratings such as:

TV-MA

TV-14

TV-PG

R

PG-13

3. Movies vs TV Shows by Rating

Compares Movies and TV Shows within the major rating categories.

4. Top 20 Content Genres

Identifies the most common genres/categories in the Netflix catalog.

5. 🌳 Genre Treemap

A treemap showing the relative contribution of the top Netflix genres based on the number of titles.

6. 📈 Netflix Content Added by Year

Analyzes how many titles were added to Netflix each year.

7. 📅 Monthly Content Addition

Shows the monthly content-addition pattern for the latest available year in the dataset.

8. 🌍 Top Countries by Content

Identifies countries contributing the most titles to the Netflix catalog.

9. 🎥 Top Directors

Highlights directors with the highest number of titles in the dataset.

10. 📺 TV Shows by Number of Seasons

Analyzes how many Netflix TV Shows have one, two, three, or more seasons.

11. ⏱️ Movie Duration Distribution

Shows the distribution of movie durations in minutes.

12. 🎭 Genre vs Average Movie Duration

Compares average movie duration across different genres.

13. 🧹 Missing Values Analysis

Identifies columns containing the highest number of missing values.

🛠️ Technologies Used

Technology

Purpose

R

Data analysis & visualization

dplyr

Data manipulation

ggplot2

Data visualization

tidyr

Data cleaning & reshaping

stringr

String processing

treemapify

Treemap visualization

scales

Visualization scaling

📂 Project Structure

Netflix-Data-Analysis/
│
├── netflix_titles.csv
├── Netflix_Data_Analysis_Complete.R
├── README.md
└── visualizations/

⚙️ Installation

1. Install R

Download and install R from the official R website.

2. Install Required Packages

Run the following in R/RStudio:

install.packages(c(
  "dplyr",
  "ggplot2",
  "tidyr",
  "stringr",
  "treemapify",
  "scales"
))

3. Load the Dataset

Place:

netflix_titles.csv

in the same working directory as the R script.

4. Run the Project

Open:

Netflix_Data_Analysis_Complete.R

in RStudio and run the script.

📁 Dataset

The project uses the Netflix Titles Dataset, containing information about Netflix movies and TV shows.

Important columns include:

show_id
type
title
director
cast
country
date_added
release_year
rating
duration
listed_in
description

🔍 Example Analysis Questions

This project answers questions such as:

What percentage of Netflix content is Movies vs TV Shows?

Which ratings are most common?

Which genres dominate the Netflix catalog?

Which countries produce the most Netflix content?

Which directors have the most titles?

How many seasons do Netflix TV Shows typically have?

What is the typical duration of Netflix movies?

Which genres have longer movies on average?

How has Netflix content addition changed over time?

Which columns contain the most missing data?

💡 Key Insights

The analysis can be used to identify:

The dominant content type on Netflix.

The most common content ratings.

The most represented genres.

Major content-producing countries.

Directors with multiple Netflix titles.

Typical TV show season counts.

Typical movie duration.

Content addition patterns across years and months.

Data-quality issues through missing-value analysis.

Note: Exact numerical insights depend on the version of the Netflix dataset being analyzed.

🚀 Future Improvements

Possible extensions for this project:

🌍 Interactive country map

📊 Interactive Plotly visualizations

📈 Netflix dashboard using Shiny

🔀 Sankey diagram for Country → Genre → Rating

🕸️ Actor–Director network analysis

☁️ Genre/title word cloud

🤖 Machine learning for content recommendation

📊 Interactive KPI dashboard

👨‍💻 Author

Piyush Agar

B.Tech — Artificial Intelligence & Data Science

⭐ If You Like This Project

If you found this project useful, consider giving the repository a ⭐ on GitHub!
