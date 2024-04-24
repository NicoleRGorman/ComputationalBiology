#ggplot III
#11 April, 2024
#NRG


# ggplot continues

install.packages("remotes")
library(remotes)
library(ggplot2)
library(ggthemes)
library(patchwork)
library(colorblindr)
library(cowplot)
library(colorspace)
library(wesanderson)
library(ggsci)

remotes::install_github("clauswilke/colorblindr")
# update all of recommended packages when prompted
# if an error is generated, restart RStudio and re-run this line of code

# load data
d <- mpg

# Bar Plots

# use to plot the counts of rows for a categorical variable
table(d$drv) # R is doing this under the hood

p1 <- ggplot(d) +
  aes(x=drv,fill=fl) +
  geom_bar(color="black",fill="cornsilk")
print(p1)

# aesthetic mapping gives multiple groups for each bar
p1 <- ggplot(d) +
aes(x=drv,fill=fl) +
  geom_bar()
print(p1)

# stacked, but need to adjust color transparency, which is "alpha"
p1 <- ggplot(d) +
  aes(x=drv,fill=fl) +
  geom_bar(alpha=0.3, position="identity") # alpha controls transparency
print(p1)


# better to use position = fill for stacking, but with equivalent height
p1 <- ggplot(d) +
  aes(x=drv,fill=fl) +
  geom_bar(position="fill")
print(p1)

# best to use position=dodge
# best to use position = dodge for multiple bars
p1 <- ggplot(d) +
  aes(x=drv,fill=fl) +
  geom_bar(position="dodge", color="black", linewidth=0.5)
print(p1)

# more typical....has heights as the values themselves
d_tiny <- tapply(X=d$hwy,INDEX=as,factor(d$fl),FUN=mean) #calculate means
print(d_tiny)

d_tiny <- data.frame(hwy=d_tiny) # create a single-column data frame
print(d_tiny)

d_tiny <- cbind(fl=row.names(d_tiny),d_tiny)
print(d_tiny)


p2 <- ggplot(d_tiny) +
  aes(x=fl,y=hwy,fill=fl) +
  geom_col()
print(p2)

###Use a box plot instead of standard “means” bars!
# basic boxplot is simple and informative
p1 <- ggplot(d) +
  aes(x=fl,y=hwy,fill=fl) +
  geom_boxplot()
print(p1)

# now overlay the raw data
p1 <- ggplot(d) +
  aes(x=fl,y=hwy) +
  geom_boxplot(fill="thistle",outlier.shape=NA) +
  #geom_point()
  geom_point(position=position_jitter(width=0.1, height=0.7),
             color="gray60", size=2)

print(p1)


