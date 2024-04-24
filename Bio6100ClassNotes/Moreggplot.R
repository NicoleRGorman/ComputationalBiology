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

# converting color plots to black and white
p1 <- ggplot(d,aes(x=as.factor(cyl),y=cty,fill=as.factor(cyl))) + geom_boxplot()
plot(p1)

# default colors look identical in black white
p1_des<- colorblindr::edit_colors(p1,desaturate)
plot(p1_des)


# custom colors not pretty, but convert ok to bw
p2 <- p1 + scale_fill_manual(values=c("red","blue","green","yellow"))
plot(p2)

p2_des<- colorblindr::edit_colors(p2,desaturate)
plot(p2_des)

###using alpha transparency for histograms

# set up some data
x1 <- rnorm(n=100,mean=0)
x2 <- rnorm(n=100,mean=2.7)
d_frame <- data.frame(v1=c(x1,x2))
lab <- rep(c("Control", "Treatment"), each=100)
d_frame <- cbind(d_frame,lab)
str(d_frame)


h1 <- ggplot(d_frame) +
  aes(x=v1,fill=lab)
h1 + geom_histogram(position="identity",alpha=0.5,color="black")

# Color Customizations

d <- mpg
# --------- discrete classification
# scale_fill_manual for boxplots,bars
# scale_color_manual for points, lines

# boxplot no color
p_fil <- ggplot(d) +
  aes(x=as.factor(cyl),y=cty)
p_fil + geom_boxplot()


# boxplot default ggplot fill
p_fil <- ggplot(d) +
  aes(x=as.factor(cyl),y=cty,fill=as.factor(cyl)) +
  geom_boxplot()
plot(p_fil)

# create custom color palette
my_cols <- c("red","brown","blue","orange")

# boxplot with custom colors for fill
p_fil + scale_fill_manual(values=my_cols)

# continuous variables
# scatterplot with no color....si this the same as below??
p_col <- ggplot(d) +
  aes(x=displ,y=cty,col=as.factor(cyl)) +
  geom_point(size=3)
plot(p_col)

# scatterplot with no color
p_col <- ggplot(d) +
  aes(x=displ,y=cty)
p_col + geom_point(size=3)

# scatterplot default ggplot colors
p_col <- ggplot(d) +
  aes(x=displ,y=cty,col=as.factor(cyl)) +
  geom_point(size=3)
plot(p_col)

# scatterplot with custom colors for point color
p_col + scale_color_manual(values=my_cols)

# CONTINUOUS CLASSIFCATION

# default color gradient
p_grad <- ggplot(d) +
          aes(x=displ,y=cty,col=hwy) +
          geom_point(size=3)
plot(p_grad)

# custom sequentioal
p_grad + scale_color_gradient(low="green",high="red")

################

## custom diverging gradient (3-colors)
mid <- median(d$cty)
p_grad + scale_color_gradient2(midpoint=mid,
                               low="blue",
                               mid="white",
                               high="red")


# custom diverging gradient (n-colors
p_grad + scale_color_gradientn(colors=c("blue","green","yellow","purple","orange"))

##Tour of color palettes
library(weanderson)
print(wes_palettes)

demoplot(wes_palettes$BottleRocket1,"pie")

demoplot(wes_palettes[[2]][1:3],"bar")

##################################

library(RColorBrewer)

demoplot(brewer.pal(4,"Accent"),"bar")
demoplot(brewer.pal(11,"Spectral"),"heatmap")

display.brewer.all()
display.brewer.all(colorblindFriendly=TRUE)
demoplot(brewer.pal(11,"Spectral"),"heatmap")

my_cols <- c("grey75",brewer.pal(3,"Blues"))
p_fil + scale_fill_manual(values=my_cols)

# nice for seeing hex values
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

# default gradient colorp4 <- ggplot(myData) +
p4 <- ggplot(myData) +
  aes(x=xVar,y=yVar,fill=zVar) +
  geom_tile()
print(p4)

# user defined divergent palette
p4 + scale_fill_gradient2(midpoint=19,
                          low="brown",
                          mid=grey(0.8),
                          high="darkblue")


#viridis scale
p4 + scale_fill_viridis_c()
p4 + scale_fill_viridis_c(option="inferno")

# options viridis, cividis, magma, inferno, plasma
p4 <- p4 + geom_tile() + scale_fill_viridis_c()

#desaturated viridis
p4 <- p4 + geom_tile() + scale_fill_viridis_c()
p4des<-edit_colors(p4, desaturate)
plot(p4des)


