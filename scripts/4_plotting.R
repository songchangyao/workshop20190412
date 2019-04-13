library(tidyverse)
#ggplot2 is a part of tidyverse
interviews_plotting <- read_csv("data_output/interviews_plotting.csv")

ggplot(data=interviews_plotting)
  
#ggplot(data = interviews_plotting, 
#    mapping=aes(x = no_membrs, y = number_items))  #mapping= 可省略 
ggplot(data = interviews_plotting, aes(x = no_membrs, y = number_items))


ggplot(data = interviews_plotting, aes(x = no_membrs, y = number_items))+
  geom_point()

# Assign plot to a variable
interviews_plot <- ggplot(data = interviews_plotting, 
                          aes(x = no_membrs, y = number_items))
# Draw the plot
interviews_plot +
  geom_point()


#Building your plots iteratively
ggplot(data = interviews_plotting, aes(x = no_membrs, y = number_items)) +
  geom_point(alpha = 0.5)
ggplot(data = interviews_plotting, aes(x = no_membrs, y = number_items)) +
  geom_jitter(alpha = 0.5)   #make randomness
ggplot(data = interviews_plotting, aes(x = no_membrs, y = number_items)) +
  geom_jitter(alpha = 0.5, color = "blue")
ggplot(data = interviews_plotting, aes(x = no_membrs, y = number_items)) +
  geom_jitter(aes(color = village), alpha = 0.5)

ggplot(data = interviews_plotting, aes(x = village, y = rooms))+
  geom_jitter(aes(color=respondent_wall_type),alpha = 0.5)

##boxplot
ggplot(data = interviews_plotting, aes(x = respondent_wall_type, y = rooms)) +
  geom_boxplot()

ggplot(data = interviews_plotting, aes(x = respondent_wall_type, y = rooms)) +
  geom_boxplot(alpha = 1) +
  geom_jitter(alpha = 0.5, color = "tomato")

##barplots
ggplot(data=interviews_plotting,aes(x=respondent_wall_type))+
  geom_bar()
ggplot(data=interviews_plotting,aes(x=respondent_wall_type))+
  geom_bar(aes(fill=village),position="dodge")  #stack（默认）, fill(比例图)

#Adding Labels and Titles
ggplot(data=interviews_plotting,aes(x=respondent_wall_type))+
  geom_bar(aes(fill=village),position="dodge") +
  ylab("Percent") +
  xlab("Wall Type") +
  ggtitle("Count of wall type by village")+
  theme_minimal()   #for changing the backgroud

##faceting
ggplot(interviews_plotting, aes(x = respondent_wall_type, y = village)) +
  geom_bar(stat = "identity", position = "dodge") +
  ylab("Percent") +
  xlab("Wall Type") +
  ggtitle("Proportion of wall type by village") +
  facet_wrap(~ village)+
  theme_bw() +    #changing the backgroud
  theme(panel.grid = element_blank())  #网格设置





