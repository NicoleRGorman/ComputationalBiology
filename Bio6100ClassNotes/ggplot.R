# ggplot basics
# 4 April 2024
# NRG
# Preliminaries

# Colros: different character strings built into R
# pch symbol types: 21 = circle
# Ity line types: different codes for lines

library(ggplot2)
library(ggthemes)
library(patchwork)

# skeleton of a ggplot call

# p1<- ggplot(data= <DATA>) +
#   aes(<mappings>) +
#   <GEOM_FUNCTION>(aes(<MAPPINGS>),
#                   stat=<STAT>,
#                   position=<POSITOIN>) +
#   <COORDINATE_FUNCTION> +
#   <FACET_FUNCTION>

# #first three call are core, last two are optional
# stats often are not the actual data but the results of a calculation
# coordinates is optional, but has to do with x,y axis

# print(p1)
# ggsave(plot=p1,
#        filename="Myplot",
#        width=5,
#        height=3,
#        units="in",
#        device="pdf")


# Basic graph Types ----


d <- mpg #built in R dataset
str(d)
table(d$fl) #sorts data and gives counts


# basic histogram plot
ggplot(data=d) +
  aes(x=hwy) +
  geom_histogram()

# add color to the graph
ggplot(data=d) +
  aes(x=hwy) +
  geom_histogram(fill="khaki",color="black")

ggplot(data=d) +
  aes(x=hwy, fill="red") + #don't assign here, make red a group
  geom_histogram()

# basic density plot
ggplot(data=d) +
  aes(x=hwy) +
  geom_density(fill="mintcream", color="blue")

# basic scatter plot
ggplot(data=d) +
  aes(x=displ,y=hwy) +
  geom_point() +
  geom_smooth(method="lm",col="red")

# basic scatter plot
ggplot(data=d) +
  aes(x=displ,y=hwy) +
  geom_point() +
  geom_smooth(method="lm",col="red")

ggplot(data=d) +
  aes(x=displ,y=hwy) +
  geom_point() +
  geom_smooth() +
  geom_smooth(method="lm",col="red")

# basic boxplot
ggplot(data=d) +
  aes(x=fl,y=cty) +
  geom_boxplot(fill="thistle")

ggplot(data=d) +
  aes(x=fl,y=cty, fill=fl) +
  geom_boxplot()
# not a great use of color unless there is an association between things that are colored the same way


# Themes and fonts ----
p1 <- ggplot(data=d) +
  aes(x=fl,y=cty) +
  geom_point ()
print(p1)

p1 + theme_classic ()
p1 + theme_linedraw ()
p1 + theme_dark ()
p1 + theme_base ()
p1 + theme_par ()
p1 + theme_void ()

p1 + theme_solarized ()
p1 + theme_economist ()
p1 + theme_void ()

# use theme parameters to modify font and font size
p1+ theme_classic(base_size=40,base_family = "serif")


# defaults; theme_gray, base_size=16, base_family="Helvetica")
# font families (Mac): Times, Arial, etc ???????????????????

# use coordinate_flip to invert entire plot
p2 <- ggplot(data=d) +
  aes(x=fl,fill=fl) +
  geom_bar()
print(p2)

p2 + coord_flip()
theme_grey(base_size) ######???????????????????????????



p1 <- ggplot(data=d, mapping=aes(displ,y=cty)) +
  geom_point(size=7,shape=21,color="black",fill="steelblue") +
  labs(title="My graph title here",
       subtitle="An extended subtitle that will print below the main totle",
       x="X axis",
       y="y axis") +
       xlim(0,4) + ylim(0,20)
print(p1)


# Basic barplot

ggplot(data=d) +
  aes(x=fl) +
  geom_bar(color="black",fill="thistle")

# build a bar plot with specified values

x_treatment <- c("Control","Low", "High")
y_response <- c(12,2.5,22.9)
summary_data <- data.frame(x_treatment,y_response)

#not used as open, sparse
#ggplot((data=summary_data) +
#         aes(x=x_treatment,y=y_response) +
#         geom_col(fill=c("grey50","goldenrod","goldenrod"),col="black")

# basic
my_vec <- seq(1,100,by=0.1)

#plot
d_frame <- data.frame(x=my_vec##########)
                      ggplot(data=d_frame) +
                      aes(x=x,y=y) +
                      geom_line()

# Plot probs
d_frame <- data.frame(x=my_vec,y=dgamma(my_vec,shape=5,scale=3))
ggplot(data-d_frame)
###more hgere


#plot own function
# something goes here












