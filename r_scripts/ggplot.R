# learning the basics of ggplot
# Sof Antelo
# 2/19/26

################################

# p1 <- ggplot(data = <DATA>) +
#   aes(<MAPPINGS>) +
#   <GEOM_FUNCTION>(aes(<MAPPINGS>),
#                   stat=<STAT>,
#                   position=<POSITION>) +
#                   <COORDINATE_FUNCTION> +
#                   <FACET_FUNCTION> #makes multiple plots all together

library(ggplot2)
library(ggthemes)
library(patchwork)

#load dataset
d <- mpg

###first call to ggplot: histogram
ggplot(data = d) + 
    aes(x = hwy) +
    geom_histogram()

##change color of histogram
#########cornflowerblue is the best r color
ggplot(data = d) + 
    aes(x = hwy) +
    geom_histogram( fill = "cornflowerblue", color ="black" )

### Density plot
ggplot(data = d) +
  aes(x = hwy) +
  geom_density(fill = "cornflowerblue")

### scatter plot
ggplot(data = d) +
  aes(x = displ, y = hwy) +
  geom_point() +
  geom_smooth() +
  geom_smooth() +
  geom_smooth(method = "lm", col = "lightpink2")


###boxplot
ggplot(data = d) +
  aes(x = fl, y = cty) +
  geom_boxplot(fill = "paleturquoise1", color = "cornflowerblue")

### barplot
ggplot(data = d) +
  aes(x = fl) +
  geom_bar()

#barplot with y reponse
x_treatment <- c("control", "low", "high")
y_response <- c(12, 2.5, 22)
summary_data <- data.frame(x_treatment, y_response)

ggplot(data = summary_data) +
  aes(x = x_treatment, y = y_response) +
  geom_col(fill = c("seashell4","cornflowerblue", "plum3"),)

#plotting curves 
 # basic curves and functions
 my_vec <- seq(1,100,by=0.1)
 
 # plot simple mathematical functions
 d_frame <- data.frame(x=my_vec,y=sin(my_vec))
 ggplot(data=d_frame) +
   aes(x=x,y=y) +
   geom_line()

 # plot probability functions
 d_frame <- data.frame(x=my_vec,y=dgamma(my_vec,shape=5, scale=3))
 ggplot(data=d_frame) +
   aes(x=x,y=y) +
   geom_line()

#themes and fonts
p1 <- ggplot(data = d, mapping = aes(x=displ, y = cty))+
  geom_point()
p1

p1 + theme_classic()
#if there's a lot of things to add, its best to just add it to the object
p1 + theme_minimal() 
p1 + theme_linedraw()
p1 + theme_base() #base r graphics
p1 + theme_par() #takes parameters and uses those

#changing font and font size
p1 + theme_classic(base_size = 25, base_family = "serif")

#adding additional fonts
library(extrafont)
font_import() #imports all system fonts

p1 + theme_classic(base_size=25,
                  base_family = "")

p1 <- ggplot(data=d, mapping=aes(x=fl, fill=fl))+
      geom_bar()
p1
#uses default colors and includes a key
p1 + coord_flip() + theme_grey(base_size=20,base_family="sans")

 # use x and/or y limits to clip data set

 p1 <- ggplot(data=d) +
  aes(x=displ,y=cty) + 
  geom_point() +
 labs(title="My graph title here",
      subtitle="An extended subtitle",
      x="Displacement",
      y="City Mileage",
      caption="Add a caption here") +
   theme_bw(base_size=25,base_family="Monaco")
  #    xlim(0,4) + ylim(0,20)
 print(p2)


 p1 <- ggplot(data=d) +
  aes(x=displ,y=cty) + 
 geom_point(size=4,
            shape=21,
            color="black",fill="cyan") +
   xlim(4,7) + 
   ylim(-10,40) +
   theme_bw(base_size=25,base_family="Monaco")
 print(p1)


########################
#2/24/26
#GGplot Part 2
########################

#multi panel plots- 
# simpler way to show complex data

p2 <- ggplot(data=d, mapping=aes(x=fl, fill=fl))+
  geom_bar()+
  labs(fill= "Fuel Type", x ="Fuel Type", y= "Count", title= "My Plot")
p2
