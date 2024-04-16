# Using color in ggplot
# 16 April




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
library(scales)

remotes::install_github("clauswilke/colorblindr")
# update all of recommended packages when prompted
# if an error is generated, restart RStudio and re-run this line of code

d <- mpg


# Be intentional choosing color
# Often black, gray, white used to indicate control
# some colors are symbolic
# some colors have meaning in specific areas of study
# hexadecimal color code reflects RBG scale

# colorbrewer is online resource for color pallettes
# includes color sets that can be used with colorblind



my_cols <- c("thistle", "tomato", "cornsilk", "cyan", "chocolate")
demoplot(my_cols,"map")
# make a map

# can also make a barplot
# just use character string to call different types of maps
demoplot(my_cols,"bar")
demoplot(my_cols,"scatter")
demoplot(my_cols,"heatmap")
demoplot(my_cols,"spine")
demoplot(my_cols,"perspective")

# gray function vs colors

# built in grays (0= black, 100=white)
my_grays <- c("gray20","gray50","gray80")
demoplot(my_grays,"bar")

my_grays2 <- gray(seq(from=0.1,to=0.9,length.out=10))
demoplot(my_grays2,"heatmap")

#p1 <- ggplot(d,des#################
             +
##############

p1_des<- colorblindr::edit_colors(p1,desaturate)
plot(p1_des)


p2_des<- colorblindr::edit_colors(p2,desaturate)
plot(p2_des)

# set up some data
x1 <- rnorm(n=100,mean=0)
x2 <- rnorm(n=100,mean=2.7)
d_frame <- data.frome(v1=c(x1,x2))
lab <- rep(c("Control", "Treatment"), each=100)
d_frame <- cbind(d_frame,lab)
str(d_frame)


h1 <- ggplot(d_frame) +
  aes(x=v1,fill=lab)
hi + geom_hist(position)#########

# boxplot of no color

p_fil <- ggplot(d) +
  aes(x=as.factor(cyl),
      geom_boxplot()
plot(p_fil)
      fill)


# contimuous variables
# scatterplot with no color
p_col <- ggplot(d) +
  aes(x=displ,y=cty,col=as.factor(cyl)) +
  geom_point(size=3)
plot(p_col)


# CONTINUOUS CLASSIFCATION
p_grad <- ggplot(d) +
aes(x=displ,y=cty,col=hwy) +
  geom_point(size=3)
plot(p_grad)

# custom sequentioal
p_grad + scale_color_gradient(low-"green",high="red")

################

# custom diverging gradient (n-color)
p_grad + scalle_color_gradient(colors=c("blue","green","yelow","purple","orange"))

library(weanderson)
print(wes_palettes)

demoplot(wes_palettes$BottleRocket1,"pie")

demoplot(wes_palettes[[2]][1:3],"bar")

##################################

library(RColorBrewer)

demoplot(brewer.pal(4,"Accent"),"bar")

demoplot(brewer.pal(11,"Spectral"),"heatmap")

my_cals <- c()

#####
#####


# nice for seeingf hex values
library(scales)
show_col(my_cols)


# Viridis palettes

### Making a heat map

# build a test data set
xVar <- 1:30
yVar <- 1:5
myData <- expand.grid(xVar=xVar,yVar=yVar)
head(myData)

zVar <- myData$xVar + myData$yVar + 2*rnorm(n=150)
myData <- cbind(myData,zVar)
head(myData)

# default gradiemt colorp4 <- ggplot(myData) +
p4 <- ggplot(myData) +
  aes(x=xVar,y=yVar,fill=zVar) +
  geom_tile()
print(p4)

# user defined
p4 + scale_fill_gradient2(midpoint=19, low="brown",mid=grey(0.8),high="darkblue")


#viridis scale
p4 + scale_fill_viridis_c()
p4 + scale_fill_viridis_c(option="inferno")


p4 <- p4 + geom_tile() + scale_fill_viridis_c()
########
#####

(midpoint=19, low="brown",mid=grey(0.8),high="darkblue")
