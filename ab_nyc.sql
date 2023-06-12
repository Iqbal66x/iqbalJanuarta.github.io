--- seeing to dataset

select *
from portfolio.dbo.ab_nyc

--- standardize date format

select last_review,convert(date,last_review) as last_name_clean
from portfolio.dbo.ab_nyc

update portfolio.dbo.ab_nyc
set last_review = convert(date,last_review)

alter table portfolio.dbo.ab_nyc
add review_date date

update portfolio.dbo.ab_nyc
set review_date = convert(date,last_review)

--- change messy letters to lowercase
select lower(name)as name
from portfolio.dbo.ab_nyc

update portfolio.dbo.ab_nyc
set name = lower(name)

--- delete duplicate dataset

with CTE as (
select *,
ROW_NUMBER() over (
PARTITION BY  id,
				 name,
				 host_id,
				 host_name							
				order by
					id) as RN
  from portfolio.dbo.ab_nyc
)
delete from CTE
where RN > 1;

select *
from portfolio.dbo.ab_nyc

--- delete unused column

 alter table portfolio.dbo.ab_nyc
 drop column last_review

 select *
 from portfolio.dbo.ab_nyc