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

table(d$drv) # Ris doing this under the hood

p1 <- ggplot(d) +
  aes(x=drv,fill=fl) +
  geom_bar(color="black",fill="cornsilk")
print(p1)
  

p1 <- ggplot(d) +
aes(x=drv,fill=fl) +
  geom_bar()
print(p1)

p1 <- ggplot(d) +
  aes(x=drv,fill=fl) +
  geom_bar(alpha=0.3, position="identity") # alpha controls transparency
print(p1)


# better to use position
p1 <- ggplot(d) +
  aes(x=drv,fill=fl) +
  geom_bar(position="fill") 
print(p1)

# better to use position=dodge
p1 <- ggplot(d) +
  aes(x=drv,fill=fl) +
  geom_bar(position="dodge", color="black", linewidth=0.5) 
print(p1)

# more typical....
d_tiny <- tapply(X=d$hwy,INDEX=as,factor(d$fl),FUN=mean)
#calculate means
print(d_tiny)

d_tiny <- cbind(fl=row.names(d_tiny),d_tiny)
d_tiny <- data.frame(hwy=d_tiny)


######## FIX THIS
p1 <- ggplot(d) +
  aes(x=fl,y=hwy) +
  geom_boxplot(fill="thistle",outlier.shape=NA) +
  #geom_point()
  geom_point(position=position_jitter(width=0.1, height=0.7),
             color="gray60", size=2)

print(p1)


