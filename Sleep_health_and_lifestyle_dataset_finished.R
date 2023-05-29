### correlation between Sleep Health and Lifestyle and its impact on the body

### load library

library(tidyverse)
library(skimr)
library(janitor)


### import dataset

Sleep <- read_csv("C:/Users/iqbal/Downloads/Sleep_health_and_lifestyle_dataset.csv")

View(sleep)

### correlation between sleep time and sleep quality
# Adequate sleep and good quality sleep are very important for physical and mental health
# Sleep time affects sleep quality

ggplot(data = sleep) + geom_point(mapping = aes(x = QualityofSleep, y = SleepDuration)) +
  geom_smooth(mapping = aes(x = QualityofSleep, y = SleepDuration))

### relationship between Physical Activity Levels and Stress Levels
# people who have more physical activity have less stress levels
# It is generally recognized that physical activity can help reduce stress

ggplot(data = sleep) + geom_point(mapping = aes(x = StressLevel, y = PhysicalActivityLevel))

### correlation between sleep time and sleep quality, sleep disorder
# sleep time and sleep quality if you have a sleep disorder
# People with sleep disorders have poor sleep quality and sleep duration

ggplot(data = sleep) + geom_point(mapping = aes(x = QualityofSleep, y = SleepDuration))

### correlation between Quality of Sleep and Heart Rate
# people who have better quality sleep have lower heart rates 
# This normal range is usually between 60 and 100 beats per minute at rest

ggplot(data = sleep) + geom_smooth(mapping = aes(x = QualityofSleep, y = HeartRate))


### correlation between Quality of Sleep and Stress Level
# People with good quality sleep have lower stress levels
# High stress levels can negatively impact sleep quality, whereas poor sleep can increase stress levels

ggplot(data = sleep) + geom_point(mapping = aes(x = QualityofSleep, y = StressLevel)) +
  geom_smooth(mapping = aes(x = QualityofSleep, y = StressLevel))
                            
### correlation between Physical Activity Level and Daily Steps on body weight
# Heavier people have lower levels of physical activity and daily stepss

ggplot(data = sleep) + geom_point(mapping = aes(x = PhysicalActivityLevel, y = DailySteps)) +
  geom_smooth(mapping = aes(x = PhysicalActivityLevel, y = DailySteps)) + facet_wrap(~BMICategory)

### sleep quality from various occupations

average_quality <- mean(sleep$QualityofSleep)

average_quality_by_occupation <- sleep %>%
  group_by(Occupation) %>%
  summarize(avg_quality = mean(QualityofSleep))

average <- aggregate(QualityofSleep ~ Occupation, data = sleep, FUN = mean)

ggplot(data = average) + geom_col(mapping = aes(x = QualityofSleep, y = Occupation))

### quality sleep by age
# Sleep quality generally tends to change with age
# women have higher sleep quality

ggplot(data = sleep) + geom_smooth(mapping = aes(x = Age, y = QualityofSleep,color = Gender))

# conclusion
# Adequate sleep duration affects sleep quality
# sufficient physical activity can reduce stress
# good quality sleep and sufficient activity can suppress stress and stabilize heart rate
