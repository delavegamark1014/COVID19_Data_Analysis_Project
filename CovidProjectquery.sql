
--covid 19 data exploration
--bringing up the CovidDeaths table
Select *
From public."CovidDeaths"
Where continent!='NA' 
Order by country,dates


--bringing up the CovidVaccinations table
Select *
From public."CovidVaccinations"
Where continent!='NA'
Order by country,dates


--total cases vs total deaths
--percentage of deaths due to positive covid cases in the United States
Select country,dates,total_cases,total_deaths,(total_deaths/nullif(total_cases,0))*100 as PercentDeaths
From public."CovidDeaths"
Where country='United States'
Order by 1,2


--Effectiveness of lockdown in the U.S (March 15  - July 31 2020)
--Calculates the average daily new cases before and during the lockdown
--Create 2 CTEs to use in final calculations
With pre_lockdown AS (
    SELECT dates,new_cases
    FROM public."CovidDeaths"
    WHERE country = 'United States'
        AND dates between '2020-01-20' and  '2020-03-14'
),
during_lockdown AS (
    SELECT dates,new_cases
    FROM public."CovidDeaths"
    WHERE country = 'United States'
        AND dates between '2020-03-15' and '2020-07-31'
)
SELECT
    AVG(pre_lockdown.new_cases) AS avg_pre_lockdown_new_cases,
    AVG(during_lockdown.new_cases) AS avg_during_lockdown_new_cases,
	((AVG(during_lockdown.new_cases) - AVG(pre_lockdown.new_cases)) / AVG(pre_lockdown.new_cases)) * 100 AS percentage_change	
FROM pre_lockdown, during_lockdown


--shows countries with highest death count per population
Select country,max(total_deaths) as TotalDeathCount
From public."CovidDeaths"
Where continent !='NA'
Group by country
Order by TotalDeathCount desc


--Positive cases per capita
--Shows total number of cases(MOST RECENT)in proportion to population in each country, ordered by desc
--total cases vs population
Select country,population,max(total_cases) as LastCaseCount,Max((total_cases/population))as CasesperCapita
From public."CovidDeaths"
Group by country,population
Order by CasesperCapita desc

--Positive cases per Capita in the U.S (overtime)
--total cases vs population
Select country,dates,total_cases,population,(total_cases/population)as CasesperCapita
From public."CovidDeaths"
Where country='United States'
Order by 1,2


--Positive cases per Capita by country overtime
Select country,dates,total_cases,population,(total_cases/population)as CasesperCapita
From public."CovidDeaths"
where continent!='NA'
Order by 1,2


--Positive Cases per Capita by continent overtime
Select country,dates,total_cases,population,(total_cases/population)as CasesperCapita
From public."CovidDeaths"
where continent='NA'
--continent='NA' because data used also includes/tracks actual continents in the country column, and nulls its corresponding continent column
Order by 1,2


--Percent of population fully vaccinated in each continent (overtime)
--population vs full vaccinations
--Full join to get the population from coviddeaths, and people_fully_vaccinated from covidvaccinations
Select vac.country,vac.dates,vac.people_fully_vaccinated,dea.population,dea.total_cases
,(nullif(vac.people_fully_vaccinated,0)/dea.population)*100 as PercentVaccinated
From public."CovidVaccinations" vac
Full join public."CovidDeaths" dea
	on vac.dates=dea.dates
	and vac.country=dea.country
where vac.continent='NA'
--continent='NA' because data used also includes/tracks actual continents in the country column, and nulls its corresponding continent column
Order by 1,2


--case fatality rate worldwide
Select Sum(new_cases) as total_cases, Sum(new_deaths) as total_deaths, Sum(new_deaths)/Sum(new_cases)*100 as DeathPercentage
From public."CovidDeaths"
Where continent!='NA' 
Order by 1,2


--Shows total number people vaccinated; and percent of people vaccinated
--Used to reconcile new_vaccinations column with people_vaccinated column to check if they match
--Using CTE to perform Calculation on Partition By
With PopulationvsTotalVaccinated (Continent, country, dates, Population, total_vaccinations, New_Vaccinations, RollingTotalVaccinated)
as
(
Select dea.continent, dea.country, dea.dates, dea.population, vac.total_vaccinations,vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (Partition by dea.country Order by dea.country, dea.dates) as RollingTotalVaccinated
--, (RollingTotalVaccinated/population)*100
From public."CovidDeaths" dea
Inner Join public."CovidVaccinations" vac
	On dea.country = vac.country
	and dea.dates = vac.dates
Where dea.continent!='NA' 
Order by country,dates
)
Select *, (RollingTotalVaccinated/Population)*100 as PercentVaccinated
From PopulationvsTotalVaccinated
