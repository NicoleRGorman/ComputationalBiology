# more ggplot
# 09 April 2024
# NRG

library(ggplot2)
library(ggthemes)
library(patchwork)
d <- mpg # load data

# multi panel plots handeled in patchwork

g1 <- ggplot(data=d) +
  aes(x=displ,y=cty) +
  geom_point() +
  geom_smooth()
print(g1)

g2 <- ggplot(data=d) +
  aes(x=fl) +
  geom_bar() +
  theme()
print(g2)

g3 <- ggplot(data=d) +
  aes(x=fl) +
  geom_bar() +
  theme()
print(g3)

g4 <- ggplot(data=d) +
  aes(x=fl,y=cty,fill=fl) +
  geom_boxplot() +
  theme(legend.position="none")
print(g4)

# place two plots horizontally
g1 + g2

# place three plots vertically
g1 + g2 + g3 + plot_layout(ncol=1)

# set spacing/heights
g1 + g2 + plot_layout(ncol=1, heights==c(2,1))

g1 + g2 + plot_layout(ncol=2, widths==c(2,1))

# add a spacer plot
g1 + plot_spacer() + g2

# nested plot layout
g1 + {
  g2 + {
    g3 +
      g4 +
        plot_layout(ncol=1)
    }
  } +
plot_layout()


# - operator for suntrack placement
g1 + g2 + g3 + plot_layout((ncol=1))


# /and | for intuitive layouts
(g1 | g2 | g3)/g4

(g1 | g2)/(g3 | g4)

# annotate figures
g1 + g2 + plot_annotation("This is a title", caption = "made in patchwork")

# change styling
g1 + g2 + plot_annotation("This is a title",
                          caption = "made in patchwork",
                          theme=theme(plot.title = element_text(size=16))
                          )

# add tags to plots
g1 / (g2 | g3) +
  plot_annotation(tage_levels = 'A')


# can flip parts of the graphs

g3a <- g3 + scale_x_reverse()
g3b <- g3 + scale_y_reverse()
g3c <- g3 + scale_x_reverse() + scale_y_reverse()

(g3 | g3a)/(g3b | g3c)

# ccord_flip controls whats going to be on the x/y
(g3 + ccord_flip() | g3a + ccord_flip())/(g3b + ccord_flip() | g3c + ccord_flip())


# ggsave, creates and stores object
# need to give figure a file name

ggsave(filename="MyPlot.pdf", plot=g3, devise="pdf", width=20,height=20,units="cm",dpi=300)

# mapping of discrete variable to point color
m1 <- ggplot(data=mpg) +
  aes(x=displ,y=cty,color=class) +
  geom_point(size=3)
print(m1)


# mapping of discrete variable to point shape (<= 6)
# problem bc only can do 6 points, dropped SUV

m1 <- ggplot(data=mpg) +
  aes(x=displ,y=cty,shape=class) +
  geom_point(size=3)
print(m1)



# mapping of discrete variable to point size (not advised)

m1 <- ggplot(data=mpg) +
  aes(x=displ,y=cty,size=class) +
  geom_point(size = 0.5, 5, 20, 30, 40)
print(m1)



# mapping of discrete variable to point size (not advised)

m1 <- ggplot(data=mpg) +
  aes(x=displ,y=cty,size=hwy) +
  geom_point()
print(m1)


# mapping of discrete variable to point color

m1 <- ggplot(data=mpg) +
  aes(x=displ,y=cty,color=hwy) +
  geom_point(size=5)
print(m1)



# mapping two variables to different aesthetics...bad idea
m1 <- ggplot(data=mpg) + aes(x=displ,y=cty,shape=class, color=hwy) +
  geom_point(size=5)
print(m1)


# use all 3 (size,shape,color) to indicate 5 attributes
m1 <- ggplot(data=mpg) +
  aes(x=displ,
      y=cty,shape=drv,
      color=fl,
      size=hwy) +
  geom_point()
print(m1)


#mapping a variable to the same aesthetic in two different geoms
m1 <- ggplot(data=mpg) +
  aes(x=displ,y=cty,color=drv) +
  geom_point(size=2) +
  geom_smooth(method="lm")
print(m1)


# Faceting variables for more effective grouping

# basic faceting with variables split by row, col, or both
m1 <- ggplot(data=mpg) +
  aes(x=displ,y=cty) +
  geom_point()

m1 + facet_grid(class~fl)

# basic faceting with variables split by row, col, or both
m1 <- ggplot(data=mpg) +
  aes(x=displ,y=cty) +
  geom_point()

m1 + facet_grid(class~fl)
m1 + facet_grid(fl~class)

# allows the different axis scales to be optimized for the individual plats within the grid
m1 + facet_grid(fl~class, scales="free_y")
m1 + facet_grid(fl~class, scales="free")

m1 + facet_grid(.~class)
m1 + facet_grid(class~.)

# use facet wrap when variables are not crossed
#only specify one group
# works fine for a single factor
m1 + facet_wrap(~class)

#drops empty categories/plots
m1 + facet_wrap(~class + fl)

# add to call (drop=FALSE) if want to show empty plots
m1 + facet_wrap(~class+ fl, drop=FALSE)

# use
m1 <- ggplot(data=mpg) +
      aes(x=displ,y=cty,color=drv) +
  geom_point()

m1 + facet_grid(.~class)

m1 <- ggplot(data=mpg) +
aes(x=displ,y=cty,color=drv) +
  geom_smooth(se=FALSE,method="lm")

m1 + facet_grid(.~class)

#boxplot
m1 <- ggplot(data=mpg) +
  aes(x=displ,y=cty) +
  geom_boxplot()

m1 + facet_grid(.~class)

# add a group and fill
m1 <- ggplot(data=mpg) +
  aes(x=displ,y=cty,fill=drv) +
  geom_boxplot()

m1 + facet_grid(.~class)

#fine scale manipulation to deal with groupmiings inside facet plots
p1 <- ggplot(data=d) +
  aes(x=displ,y=cty) +
  geom_point() +
  geom_smooth()
print(p1)


# break into groups
p1 <- ggplot(data=d) +
  aes(x=displ,y=cty,group=drv) +
  geom_point() +
geom_smooth()
print(p1)

# break out the drive types (note what color affects)
p1 <- ggplot(data=d) +
  aes(x=displ,y=cty,color=drv) +
  geom_point() +
  geom_smooth()
print(p1)

# break out the drive types (note what fill affects)
p1 <- ggplot(data=d) +
  aes(x=displ,y=cty,fill=drv) +
  geom_point() +
  geom_smooth()
print(p1)

# use if both
p1 <- ggplot(data=d) +
  aes(x=displ,y=cty,color=drv,fill=drv) +
  geom_point() +
  geom_smooth()
print(p1)


# subset on the fly
p1 <- ggplot(data=d) +
  aes(x=displ,y=cty,color=drv) +
  geom_point(data=d[d$drv=="4",]) + geom_smooth()
#comma with nothing means only subsetting on the rows
print(p1)

# instead of subsetting, just map an aesthetic
p1 <- ggplot(data=d) +
  aes(x=displ,y=hwy) +
  geom_point(aes(color=drv)) + geom_smooth(color="black")
print(p1)


# map the smoother not the points
p1 <- ggplot(data=d) +
  aes(x=displ,y=hwy) +
  geom_point() + geom_smooth(aes(color=drv))
print(p1)

p1 <- ggplot(data=d) +
  aes(x=displ,y=hwy) +
  geom_point() + geom_smooth(aes(color=drv))
print(p1)

p1 <- ggplot(data=d[d$drv=="4",]) +
  aes(x=displ,y=hwy) +
  geom_point() + geom_smooth(aes(color=drv))
print(p1)



