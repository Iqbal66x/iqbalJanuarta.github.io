#analyst data game sale

#objective
#knowing how many revenue game sale year by year
#growth game year by year
#what is the game with the highest sales

#using library

library(tidyverse)
library(janitor)
library(skimr)
library(readr)

#import file csv to get dataset

game_sales <- read_csv("raw data/VideoGameSale/vgsales.csv")

#view dataset

View(game_sales)

#know the structure of the data

str(game_sales)

#knowing how many revenue game sale year by year
#selecting tabel

RG_sales <- game_sales %>% 
  select(Year, Global_Sales) %>% 
  group_by(Year) %>% 
  summarise(Global_Sales = sum(Global_Sales))

head(RG_sales)

#delete N\A and '2017','2020'values in year column

RGC_sales <- RG_sales[!(RG_sales$Year %in% c('2017', '2020', 'N/A')), ]

#delete 1980-1990 values in year column

RGC_sales1 <- RGC_sales[!(RGC_sales$Year %in% 1980:1989), ]

View(RGC_sales1)

#growth game year by year
#Shows the percentage of sales

PG_sales <- RGC_sales1 %>% 
  mutate(percent = Global_Sales / sum(Global_Sales))*100

#visualisasion sale game year by year

ggplot(data = PG_sales) +
  geom_bar(mapping = aes(x = Year, y = Global_Sales), stat = 'identity') +
  xlab('Year') +
  ylab('Global Sales') +
  labs(title='Global Sales by Year', subtitle ='1990-2016' )

#what is the game with the highest sales
#Top 10 selling games

highest <- head(game_sales,10) %>% 
  select(Name, Global_Sales) %>% 
  arrange(desc(Global_Sales))

view(highest)

#visualization of the top 10 best-selling games
ggplot(data = highest) +
  geom_bar(mapping = aes(x = Name, y = Global_Sales), stat = 'identity') +
  xlab('Name') +
  ylab('Global Sales') +
  labs(title='best selling game', subtitle = 'top 10 best-selling games' )
  
