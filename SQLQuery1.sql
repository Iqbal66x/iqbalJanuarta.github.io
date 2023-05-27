--- cleaning dataset in sql

--- Look the dataset

select *
from portfolio..house

-- standardize date format

select saledate,CONVERT(date,saledate) 
from portfolio..house

update house
set saledate = CONVERT(date,saledate)

alter table house
add saledate date

update house
set saledate = CONVERT(date,saledate)


-- Populate Property Address data

select *
from portfolio..house
where PropertyAddress is null
order by ParcelID



select a.ParcelID,a.PropertyAddress,a.ParcelID,b.PropertyAddress,ISNULL( a.PropertyAddress,b.PropertyAddress)
from portfolio.dbo.house a
join portfolio.dbo.house b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null


update a
set PropertyAddress = ISNULL( a.PropertyAddress,b.PropertyAddress)
from portfolio.dbo.house a
join portfolio.dbo.house b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

-- Change Y and N to Yes and No in "Sold as Vacant" field

select distinct SoldAsVacant,count(SoldAsVacant)
from portfolio.dbo.house
group by SoldAsVacant

select SoldAsVacant,
	case when SoldAsVacant = 'N' then 'No'
	when SoldAsVacant = 'Y' then 'Yes'
	else SoldAsVacant
	end
from portfolio.dbo.house

update house
set SoldAsVacant = case when SoldAsVacant = 'N' then 'No'
	when SoldAsVacant = 'Y' then 'Yes'
	else SoldAsVacant
	end
from portfolio.dbo.house

--- Breaking out Address into Individual Columns (Address, City, State)

Select PropertyAddress
From portfolio.dbo.house

Select
PARSENAME(REPLACE(PropertyAddress, ',', '.') , 2),
PARSENAME(REPLACE(PropertyAddress, ',', '.') , 1)
from Portfolio.dbo.house

alter table house
add PropertySplitAddress Nvarchar(100)

update house
set PropertySplitAddress = PARSENAME(REPLACE(PropertyAddress, ',', '.') , 2)

alter table house
add PropertySplitcity Nvarchar(100)

update house
set PropertySplitcity = PARSENAME(REPLACE(PropertyAddress, ',', '.') , 1)

select *
from portfolio.dbo.house

select OwnerAddress
from portfolio.dbo.house

Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3),
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2),
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
from Portfolio.dbo.house


alter table house
add ownerSplitAddress Nvarchar(100)

update house
set ownerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)

alter table house
add ownerSplitcity Nvarchar(100)

update house
set ownerSplitcity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)

alter table house
add ownerSplitstate Nvarchar(100)

update house
set ownerSplitstate = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

select *
from portfolio.dbo.house

--- delete duplicate values

with CTE as (
select *,
ROW_NUMBER() over (
PARTITION BY  PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference							
				order by
					UniqueID) as RN
  from portfolio.dbo.house
)
delete from CTE
where RN > 1;

select *
from portfolio.dbo.house

--- delete unused columns

 alter table portfolio.dbo.house
 drop column owneraddress,taxdistrict,propertyaddress,saledate

 select *
 from portfolio.dbo.house