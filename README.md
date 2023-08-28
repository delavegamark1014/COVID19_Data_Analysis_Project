# COVID-19 Data Analysis Project

This repository contains SQL queries for analyzing COVID-19 data using PostgreSQL and Pgadmin4, as well as a Tableau visualization. The project focuses on exploring COVID-19 cases, deaths, vaccinations, and related metrics to gain insights into the pandemic's impact.

## Introduction

This project aims to analyze COVID-19 data using SQL queries with PostgreSQL, as well as visualize the results through Tableau. The provided SQL queries through the file `CovidProjectquery.sql` can be used to extract valuable insights from COVID-19 datasets related to cases, deaths, vaccinations, and more.

## Database Schema

The data used for analysis is stored in two main tables: `CovidDeaths` and `CovidVaccinations`. The schema includes columns for `country`, `continent`, `dates`, `total_cases`, `total_deaths`,`population`, `people_fully_vaccinated`, and other relevant attributes.


## Tableau Visualizations

The Tableau visualization complements the SQL analysis by providing interactive and visually appealing representations of the COVID-19 data. The following sheets have been created:

- **Positive Cases Geographic Map**: Visualizes the distribution of positive COVID-19 cases across different countries on a map.
- **Total Deaths**: Presents the total death count due to Covid-19 in the top 15 countries
- **Positive Cases Trendlines**: Shows the trend of positive COVID-19 cases over time in each continent with trendlines for easy identification of patterns.
- **PercentVaccinated**: Shows the percent of population fully vaccinated in each continent each year

## Usage

1. Make sure you have PostgreSQL, Pgadmin4, and Tableau Desktop installed.
2. Create a database and load the COVID-19 data into the `CovidDeaths` and `CovidVaccinations` tables.
3. Open and execute the SQL queries provided in this repository using Pgadmin4 or any PostgreSQL client.
4. Explore the interactive visualizations in Tableau to gain insights from the COVID-19 data.
Here is the link to the Tableau visualization: https://public.tableau.com/views/COVID-19Impact_16931977025800/COVID-19ImpactDashboard?:language=en-US&:display_count=n&:origin=viz_share_link

## Contributing

Contributions to this project are welcome. If you have improvements or additional analyses to add, feel free to fork this repository and submit a pull request.



