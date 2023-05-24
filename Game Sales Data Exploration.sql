-- Data exploration using SQL
--income sales in milion

-- Looking at the table 

select *
from portfolio..GameSales

--revenue global game sales by year

select year,
	sum(global_sales) as total_global_sales_revenue
from portfolio..gamesales
group by year
order by year

--how many game published by year

select year,					
	count(*) as game_published
from portfolio..gamesales
group by year
order by year

--global game sales revenue by publisher

select publisher,
	sum(global_sales) as total_global_sales_revenue
from portfolio..gamesales
group by publisher
order by total_global_sales_revenue desc

-- top 3 highest publisher game revenue year per year

select year,publisher,
	sum(global_sales) as total_global_sales_revenue
from portfolio..GameSales
where Publisher in ('nintendo','electronic arts','activision')
group by publisher,Year
order by year

--how much the average global_game revenue per year

select year,
	format(sum(global_sales) / count(*), 'N2') as average_global_sales_revenue
from portfolio..gamesales
group by year
order by year

-- how much do the most popular platforms earn

select platform,			
	sum(Global_Sales) as revenue
from portfolio..gamesales
group by Platform
order by revenue desc

--how many games are published by the platform year over year

select year,platform,			
	count(*) as game_published
from portfolio..gamesales
group by year,platform
order by year


