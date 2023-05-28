### correlation between Sleep Health and Lifestyle and its impact on the body

### load library

library(tidyverse)
library(skimr)
library(janitor)


### import dataset

Sleep <- read_csv("C:/Users/iqbal/Downloads/Sleep_health_and_lifestyle_dataset.csv")

View(sleep)

### correlation between sleep time and sleep quality

ggplot(data = sleep) + geom_point(mapping = aes(x = QualityofSleep, y = SleepDuration)) +
  geom_smooth(mapping = aes(x = QualityofSleep, y = SleepDuration))

### relationship between Physical Activity Levels and Stress Levels

ggplot(data = sleep) + geom_point(mapping = aes(x = StressLevel, y = PhysicalActivityLevel)) +
  geom_smooth(mapping = aes(x = StressLevel, y = PhysicalActivityLevel))

### correlation between sleep time and sleep quality, sleep disorder

ggplot(data = sleep) + geom_point(mapping = aes(x = QualityofSleep, y = SleepDuration)) +
  geom_smooth(mapping = aes(x = QualityofSleep, y = SleepDuration,color=SleepDisorder))

### correlation between Quality of Sleep and Heart Rate

ggplot(data = sleep) + geom_point(mapping = aes(x = QualityofSleep, y = HeartRate)) +
  geom_smooth(mapping = aes(x = QualityofSleep, y = HeartRate))

### correlation between Quality of Sleep and Stress Level

ggplot(data = sleep) + geom_point(mapping = aes(x = QualityofSleep, y = StressLevel)) +
  geom_smooth(mapping = aes(x = QualityofSleep, y = StressLevel))
              
              
### correlation between Physical Activity Level and Daily Steps,BMI Category

ggplot(data = sleep) + geom_point(mapping = aes(x = PhysicalActivityLevel, y = DailySteps)) +
  geom_smooth(mapping = aes(x = PhysicalActivityLevel, y = DailySteps)) + facet_wrap(~BMICategory)

### Quality Sleep of Occupation 

average_quality <- mean(sleep$QualityofSleep)

average_quality_by_occupation <- sleep %>%
  group_by(Occupation) %>%
  summarize(avg_quality = mean(QualityofSleep))

average <- aggregate(QualityofSleep ~ Occupation, data = sleep, FUN = mean)

ggplot(data = average) + geom_col(mapping = aes(x = QualityofSleep, y = Occupation))

### quality sleep by age

ggplot(data = sleep) + geom_smooth(mapping = aes(x = QualityofSleep, y = Age,color = Gender))
