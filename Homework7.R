# Homework #7
# 28_February_2024
# NRG

# Call in the libraries
library(tidyverse)
library(ggplot2)
library(MASS)

# Read in the data
z <- read.csv("/Users/nicolegorman/Documents/UVM_Research/UVM Rotation Project/ACC Trials/CBIO_ACCTrials.csv",header=TRUE,sep=",")

# Use regular expressions to subset genotype and then add this column to my dataset
# SEARCH: (\w+_)(\w+),(.*) REPLACE: \2

vecg <- read.csv("/Users/nicolegorman/Documents/UVM_Research/UVM Rotation Project/ACC Trials/CBIO_ACCTrials_Genotypes.csv",header=TRUE,sep=",")

# subset the genotype column
genotype <- vecg$Genotype

# add vecg as a column to the dataset
z$Genotype <- genotype

# I tried this way, but did not get anywhere, might need this later
# #rownames(dataMatrix) <- c("0","10","100")
# colnames(dataMatrix) <-c("WT",
#                          "CCDC22",
#                          "CCDC93",
#                          "CCDC22CCDC93",
#                          "CCDC22RFP",
#                          "CCDC93RFP")
# str(dataMatrix)
# print(dataMatrix)

# predictor variables are vec1 and vc2...these would be treatments
# column names are response variable

# Sample size, n = 10 plants/genotype/treatment
# There are 3 independent biological replicates, but only the first replicate is included with this dataset

# get the structure and summary metrics of the new dataset
str(z)
summary(z)

# take a peek to make sure that the genotype column is all there
head (z)
tail (z)

# Remove NAs here
z<-na.omit(z)

# Use myVar so I can run the code with any response variable by changing the 
# variable name to myVar
z$myVar <- z$Length

# define variables for easier downstream analysis
ID <- seq_len(nrow(z)) # creates a sequence from 1:n (if n > 0!)
varA <- z$Plant.ID
varB <- z$Genotype
myVar <- z$Length

head(ID)
head (varA)
head(varB)
head (myVar)

# Plot histogram of data
p1 <- ggplot(data=z, aes(x=myVar, y=..density..)) +
  geom_histogram(color="grey60",fill="cornsilk",size=0.2) 
print(p1)

# Add empirical density curve
p1 <-  p1 +  geom_density(linetype="dotted",size=0.75)
print(p1)

# Get maximum likelihood parameters for the normal distribution
normPars <- fitdistr(z$myVar,"normal")
print(normPars)

str(normPars)
normPars$estimate["mean"] # get a named attribute, I think this might be redundant with below

# Specify the sample sizes, means, and variances for each group that would be reasonable if your hypothesis were true. I am going to use the actual parameters from my data set. 
# I will use the null hypothesis, that ACC has no effect on root growth in mutant plants.

m_length <- mean(z$myVar)
print(m_length)

sd_length <- sd(z$myVar)
print(sd_length)

#Plot normal probability density
#meanML <- normPars$estimate["mean"]
sdML <- normPars$estimate["sd"]

xval <- seq(0,max(z$myVar),len=length(z$myVar))

stat <- stat_function(aes(x = xval, y = ..y..), fun = dnorm, colour="red", n = length(z$myVar), args = list(mean = m_length, sd = sd_length))
p1 + stat

# Assume that each of the treatments follows a normal distribution  
# Get maximum likelihood (ML) parameters for normal distribution for each treatment
# First get the maximum likelihood parameters for a normal distribution fitted to these data by calling fitsdir 
# Fit normal distributions for each group defined by 'Genotype'

# Fit normal distributions for each treatment (genotype)
# norm_pars <- tapply(z$Length, z$Genotype, function(x) fitdistr(x, "normal"))

# Fit normal distributions for each treatment (genotype)
norm_pars <- tapply(z$Length, z$Plant.ID, function(x) fitdistr(x, "normal"))

# mean         sd    
######### 0nM
# $`1_1_0nM_WT`
# 10.700000    4.472109 
# ( 1.999988) ( 1.414205)
# $`1_2_0nM_ccdc22`
# 11.328000    4.436014 
# ( 1.983846) ( 1.402791)
# $`1_1_0nM_ccdc93`
# 13.874000    4.813488 
# ( 2.152657) ( 1.522158)
# $`1_2_0nM_ccdc22ccdc93`
# 13.704000    5.159452 
# ( 2.307377) ( 1.631562)
# $`1_2_0nM_ccdc22RFP`
# 14.682000    5.267760 
# ( 2.355814) ( 1.665812)
# $`1_1_0nM_ccdc93RFP`
# 14.800200    5.222040 
# ( 2.335368) ( 1.651354)




######### 100nM
# $`1_1_100nM_WT`
# 6.7160000   1.9861279 
# (0.8882234) (0.6280688)
# $`1_1_100nM_ccdc22`
# 7.6620000   3.1125706 
# (1.3919839) (0.9842813)
# $`1_1_100nM_ccdc22ccdc93`
# 9.934000   3.391782 
# (1.516851) (1.072576)
# $`1_1_100nM_ccdc22RFP`
# 10.2300000    2.3405384 
# ( 1.0467206) ( 0.7401432)
# $`1_1_100nM_ccdc93`
# 9.5980000   3.1054880 
# (1.3888165) (0.9820415)
# $`1_1_100nM_ccdc93RFP`
# 7.1680000   1.8515218 
# (0.8280257) (0.5855026)

######### 10nM
# $`1_1_10nM_WT`
# 13.582000    5.310267 
# ( 2.374824) ( 1.679254)
# $`1_1_10nM_ccdc22`
# 7.300000   3.756972 
# (1.680169) (1.188059)
# $`1_1_10nM_ccdc22ccdc93`
# 8.1960000   1.8234100 
# (0.8154537) (0.5766129)
# $`1_1_10nM_ccdc22RFP`
# 12.638000    4.624255 
# ( 2.068030) ( 1.462318)
# $`1_1_10nM_ccdc93`
# 9.972000   3.797154 
# (1.698139) (1.200765)
# $`1_1_10nM_ccdc93RFP`
# 10.2852000    2.2828781 
# ( 1.0209341) ( 0.7219095)

######### 1000nM (1uM)
# $`1_1_1uM_WT`
# mean          sd    
# 10.0180000    1.8260164 
# ( 0.8166194) ( 0.5774371)
# $`1_1_1uM_ccdc22`
# 8.3880000   1.7285069 
# (0.7730118) (0.5466019)
# $`1_1_1uM_ccdc93`
# 10.4520000    2.5107003 
# ( 1.1228193) ( 0.7939531)
# $`1_1_1uM_ccdc22ccdc93`
# 8.1420000   2.2386013 
# (1.0011330) (0.7079079)
# $`1_1_1uM_ccdc22RFP`
# 9.9660000   1.9445884 
# (0.8696464) (0.6149328)
# $`1_1_1uM_ccdc93RFP`
# 9.6238000   2.0015200 
# (0.8951069) (0.6329362)


$`1_10_100nM_ccdc93RFP`
mean         sd    
8.1948000   1.8154685 
(0.8119022) (0.5741015)

$`1_10_100nM_WT`
mean         sd    
7.1600000   1.9220302 
(0.8595580) (0.6077993)

$`1_10_10nM_ccdc93`
mean         sd    
11.552000    4.270557 
( 1.909851) ( 1.350469)

$`1_10_10nM_ccdc93RFP`
mean          sd    
10.6876000    2.8626680 
( 1.2802240) ( 0.9052551)

$`1_10_10nM_WT`
mean         sd    
15.174000    4.059668 
( 1.815539) ( 1.283780)

$`1_10_1uM_WT`
mean          sd    
13.5380000    3.0781709 
( 1.3765999) ( 0.9734031)

$`1_2_0nM_ccdc22`
mean         sd    
11.328000    4.436014 
( 1.983846) ( 1.402791)

$`1_2_0nM_ccdc22ccdc93`
mean         sd    
13.704000    5.159452 
( 2.307377) ( 1.631562)

$`1_2_0nM_ccdc22RFP`
mean         sd    
14.682000    5.267760 
( 2.355814) ( 1.665812)

$`1_2_0nM_ccdc93`
mean        sd   
9.984000   4.830460 
(2.160247) (1.527526)

$`1_2_0nM_ccdc93RFP`
mean         sd    
10.320800    3.930116 
( 1.757601) ( 1.242812)

$`1_2_0nM_WT`
mean         sd    
12.440000    3.992408 
( 1.785459) ( 1.262510)

$`1_2_100nM_ccdc22`
mean         sd    
3.6560000   0.9720000 
(0.4346916) (0.3073734)

$`1_2_100nM_ccdc22ccdc93`
mean          sd    
10.8520000    2.9137220 
( 1.3030561) ( 0.9213998)

$`1_2_100nM_ccdc22RFP`
mean         sd    
9.5880000   1.6050844 
(0.7178156) (0.5075723)

$`1_2_100nM_ccdc93`
mean         sd    
10.130000    3.606267 
( 1.612772) ( 1.140402)

$`1_2_100nM_ccdc93RFP`
mean         sd    
6.4824000   2.0978501 
(0.9381871) (0.6633985)

$`1_2_100nM_WT`
mean          sd    
10.6240000    2.6083757 
( 1.1665011) ( 0.8248408)

$`1_2_10nM_ccdc22`
mean         sd    
11.616000    4.475219 
( 2.001379) ( 1.415188)

$`1_2_10nM_ccdc22ccdc93`
mean         sd    
10.334000    4.781584 
( 2.138389) ( 1.512070)

$`1_2_10nM_ccdc22RFP`
mean        sd   
9.832500   4.109181 
(2.054591) (1.452815)

$`1_2_10nM_ccdc93`
mean         sd    
11.854000    4.470448 
( 1.999245) ( 1.413680)

$`1_2_10nM_ccdc93RFP`
mean         sd    
13.640600    5.158623 
( 2.307006) ( 1.631300)

$`1_2_10nM_WT`
mean         sd    
10.526000    3.697105 
( 1.653396) ( 1.169127)

$`1_2_1uM_ccdc22`
mean         sd    
4.4520000   1.7891160 
(0.8001170) (0.5657682)

$`1_2_1uM_ccdc22ccdc93`
mean         sd    
9.1680000   2.3340728 
(1.0438291) (0.7380986)

$`1_2_1uM_ccdc22RFP`
mean         sd    
7.2550000   1.3150000 
(0.9298454) (0.6575000)

$`1_2_1uM_ccdc93`
mean         sd    
8.2700000   3.0592810 
(1.3681520) (0.9674296)

$`1_2_1uM_ccdc93RFP`
mean         sd    
10.885200    3.198021 
( 1.430198) ( 1.011303)

$`1_2_1uM_WT`
mean          sd    
13.4060000    2.5824763 
( 1.1549185) ( 0.8166507)

$`1_3_0nM_ccdc22`
mean         sd    
11.466000    5.558408 
( 2.485796) ( 1.757723)

$`1_3_0nM_ccdc22ccdc93`
mean         sd    
14.814000    5.903618 
( 2.640178) ( 1.866888)

$`1_3_0nM_ccdc22RFP`
mean         sd    
13.512000    4.034285 
( 1.804187) ( 1.275753)

$`1_3_0nM_ccdc93`
mean         sd    
14.276000    5.554294 
( 2.483956) ( 1.756422)

$`1_3_0nM_ccdc93RFP`
mean         sd    
6.1645000   0.3715000 
(0.2626902) (0.1857500)

$`1_3_0nM_WT`
mean         sd    
14.928000    4.727432 
( 2.114172) ( 1.494945)

$`1_3_100nM_ccdc22`
mean          sd    
10.9540000    2.1904940 
( 0.9796187) ( 0.6926950)

$`1_3_100nM_ccdc22RFP`
mean         sd    
8.1100000   1.9063263 
(0.8525350) (0.6028333)

$`1_3_100nM_ccdc93`
mean          sd    
12.1820000    2.8840000 
( 1.2897640) ( 0.9120009)

$`1_3_100nM_ccdc93RFP`
mean          sd    
10.2700000    2.2733633 
( 1.0166790) ( 0.7189006)

$`1_3_100nM_WT`
mean         sd    
8.5920000   2.7397109 
(1.2252360) (0.8663727)

$`1_3_10nM_ccdc22`
mean         sd    
10.800000    5.907118 
( 2.641743) ( 1.867995)

$`1_3_10nM_ccdc22ccdc93`
mean        sd   
8.478000   3.676898 
(1.644359) (1.162737)

$`1_3_10nM_ccdc22RFP`
mean         sd    
8.1440000   2.7682384 
(1.2379939) (0.8753939)

$`1_3_10nM_ccdc93`
mean         sd    
10.714000    4.752745 
( 2.125492) ( 1.502950)

$`1_3_10nM_ccdc93RFP`
mean         sd    
15.496600    5.306956 
( 2.373343) ( 1.678207)

$`1_3_10nM_WT`
mean         sd    
14.394000    4.611349 
( 2.062258) ( 1.458237)

$`1_3_1uM_ccdc22`
mean         sd    
9.0880000   1.7553165 
(0.7850014) (0.5550798)

$`1_3_1uM_ccdc22ccdc93`
mean          sd    
10.3520000    2.3925501 
( 1.0699809) ( 0.7565908)

$`1_3_1uM_ccdc93`
mean          sd    
12.0780000    2.9518293 
( 1.3200982) ( 0.9334504)

$`1_3_1uM_ccdc93RFP`
mean         sd    
9.4992000   2.9094921 
(1.3011644) (0.9200622)

$`1_3_1uM_WT`
mean          sd    
10.0140000    2.4453270 
( 1.0935835) ( 0.7732803)

$`1_4_0nM_ccdc22`
mean         sd    
14.468000    5.829780 
( 2.607157) ( 1.843538)

$`1_4_0nM_ccdc22ccdc93`
mean          sd    
11.3200000    3.0330117 
( 1.3564041) ( 0.9591225)

$`1_4_0nM_ccdc22RFP`
mean         sd    
10.394000    4.726050 
( 2.113554) ( 1.494508)

$`1_4_0nM_ccdc93`
mean         sd    
15.608000    4.547076 
( 2.033514) ( 1.437912)

$`1_4_0nM_ccdc93RFP`
mean         sd    
16.683000    4.373195 
( 1.955752) ( 1.382926)

$`1_4_0nM_WT`
mean         sd    
10.714000    5.758731 
( 2.575383) ( 1.821071)

$`1_4_100nM_ccdc22`
mean         sd    
7.2260000   2.0305723 
(0.9080996) (0.6421234)

$`1_4_100nM_ccdc22ccdc93`
mean         sd    
6.9540000   2.7329735 
(1.2222229) (0.8642421)

$`1_4_100nM_ccdc22RFP`
mean         sd    
7.8880000   2.9150808 
(1.3036638) (0.9218295)

$`1_4_100nM_ccdc93`
mean         sd    
9.4480000   1.7165477 
(0.7676635) (0.5428200)

$`1_4_100nM_ccdc93RFP`
mean         sd    
11.351600    3.316179 
( 1.483040) ( 1.048668)

$`1_4_100nM_WT`
mean         sd    
12.280000    4.903321 
( 2.192832) ( 1.550566)

$`1_4_10nM_ccdc22`
mean         sd    
12.804000    3.357848 
( 1.501675) ( 1.061845)

$`1_4_10nM_ccdc22ccdc93`
mean          sd    
11.1780000    3.0391275 
( 1.3591391) ( 0.9610565)

$`1_4_10nM_ccdc22RFP`
mean         sd    
14.884000    5.267005 
( 2.355476) ( 1.665573)

$`1_4_10nM_ccdc93`
mean          sd    
3.86000000   0.16000000 
(0.07155418) (0.05059644)

$`1_4_10nM_ccdc93RFP`
mean         sd    
7.6276000   0.7601401 
(0.3399450) (0.2403774)

$`1_4_10nM_WT`
mean         sd    
12.282000    4.885887 
( 2.185035) ( 1.545053)

$`1_4_1uM_ccdc22`
mean         sd    
4.9000000   1.7575096 
(0.7859822) (0.5557733)

$`1_4_1uM_ccdc22ccdc93`
mean         sd    
8.9900000   2.1615828 
(0.9666892) (0.6835525)

$`1_4_1uM_ccdc22RFP`
mean        sd   
8.980000   2.518881 
(1.126478) (0.796540)

$`1_4_1uM_ccdc93`
mean         sd    
7.5820000   1.7776996 
(0.7950114) (0.5621580)

$`1_4_1uM_ccdc93RFP`
mean         sd    
9.7614000   1.9325926 
(0.8642817) (0.6111394)

$`1_4_1uM_WT`
mean          sd    
13.4080000    2.9810092 
( 1.3331479) ( 0.9426779)

$`1_5_0nM_ccdc22`
mean         sd    
12.640000    4.760487 
( 2.128955) ( 1.505398)

$`1_5_0nM_ccdc22ccdc93`
mean         sd    
11.630000    4.642883 
( 2.076360) ( 1.468208)

$`1_5_0nM_ccdc22RFP`
mean         sd    
10.326000    4.441165 
( 1.986149) ( 1.404420)

$`1_5_0nM_ccdc93`
mean         sd    
15.072000    4.845507 
( 2.166977) ( 1.532284)

$`1_5_0nM_ccdc93RFP`
mean         sd    
15.736200    4.793552 
( 2.143742) ( 1.515854)

$`1_5_0nM_WT`
mean         sd    
11.834000    4.698019 
( 2.101018) ( 1.485644)

$`1_5_100nM_ccdc22`
mean         sd    
7.3120000   2.2102887 
(0.9884711) (0.6989546)

$`1_5_100nM_ccdc22ccdc93`
mean         sd    
9.6440000   2.2947470 
(1.0262421) (0.7256627)

$`1_5_100nM_ccdc22RFP`
mean        sd   
9.080000   2.552638 
(1.141574) (0.807215)

$`1_5_100nM_ccdc93`
mean         sd    
12.842000    2.830713 
( 1.265933) ( 0.895150)

$`1_5_100nM_ccdc93RFP`
mean          sd    
11.5810000    2.6110553 
( 1.1676994) ( 0.8256882)

$`1_5_100nM_WT`
mean          sd    
11.1820000    2.9332330 
( 1.3117817) ( 0.9275697)

$`1_5_10nM_ccdc22`
mean         sd    
10.582000    4.385692 
( 1.961341) ( 1.386878)

$`1_5_10nM_ccdc22ccdc93`
mean        sd   
9.092500   3.175495 
(1.587748) (1.122707)

$`1_5_10nM_ccdc22RFP`
mean         sd    
14.264000    4.894489 
( 2.188882) ( 1.547773)

$`1_5_10nM_ccdc93`
mean         sd    
12.974000    4.748838 
( 2.123745) ( 1.501714)

$`1_5_10nM_ccdc93RFP`
mean         sd    
12.290400    4.383818 
( 1.960503) ( 1.386285)

$`1_5_10nM_WT`
mean         sd    
15.030000    4.236961 
( 1.894827) ( 1.339845)

$`1_5_1uM_ccdc22`
mean          sd    
10.9020000    2.3084228 
( 1.0323581) ( 0.7299874)

$`1_5_1uM_ccdc22ccdc93`
mean         sd    
6.8180000   2.1801046 
(0.9749724) (0.6894096)

$`1_5_1uM_ccdc22RFP`
mean          sd    
12.8360000    2.6572512 
( 1.1883589) ( 0.8402966)

$`1_5_1uM_ccdc93`
mean         sd    
4.8400000   1.1553701 
(0.5166972) (0.3653601)

$`1_5_1uM_ccdc93RFP`
mean          sd    
11.4902000    2.4617520 
( 1.1009290) ( 0.7784743)

$`1_5_1uM_WT`
mean          sd    
12.6200000    2.2169348 
( 0.9914434) ( 0.7010563)

$`1_6_0nM_ccdc22`
mean        sd   
9.974000   3.811465 
(1.704539) (1.205291)

$`1_6_0nM_ccdc22ccdc93`
mean        sd   
6.815000   3.658418 
(1.829209) (1.293446)

$`1_6_0nM_ccdc22RFP`
mean        sd   
7.596000   3.740987 
(1.673020) (1.183004)

$`1_6_0nM_ccdc93`
mean         sd    
15.064000    5.217193 
( 2.333200) ( 1.649821)

$`1_6_0nM_ccdc93RFP`
mean         sd    
15.275200    5.118053 
( 2.288863) ( 1.618471)

$`1_6_0nM_WT`
mean         sd    
12.488000    4.821960 
( 2.156446) ( 1.524838)

$`1_6_100nM_ccdc22`
mean         sd    
3.9980000   1.8259617 
(0.8165949) (0.5774198)

$`1_6_100nM_ccdc22ccdc93`
mean          sd    
11.4520000    2.5406645 
( 1.1362197) ( 0.8034287)

$`1_6_100nM_ccdc22RFP`
mean         sd    
11.286000    3.552569 
( 1.588757) ( 1.123421)

$`1_6_100nM_ccdc93`
mean          sd    
10.3880000    2.6000723 
( 1.1627877) ( 0.8222151)

$`1_6_100nM_ccdc93RFP`
mean         sd    
9.9170000   2.7640452 
(1.2361186) (0.8740678)

$`1_6_100nM_WT`
mean         sd    
8.7700000   2.1359026 
(0.9552047) (0.6754317)

$`1_6_10nM_ccdc22`
mean         sd    
12.372000    4.055532 
( 1.813689) ( 1.282472)

$`1_6_10nM_ccdc22ccdc93`
mean          sd    
11.4140000    3.0267712 
( 1.3536132) ( 0.9571491)

$`1_6_10nM_ccdc22RFP`
mean         sd    
13.646000    4.107026 
( 1.836718) ( 1.298756)

$`1_6_10nM_ccdc93`
mean         sd    
11.164000    4.436434 
( 1.984033) ( 1.402924)

$`1_6_10nM_ccdc93RFP`
mean        sd   
9.931200   4.008129 
(1.792490) (1.267482)

$`1_6_10nM_WT`
mean         sd    
15.270000    4.512104 
( 2.017874) ( 1.426852)

$`1_6_1uM_ccdc22`
mean         sd    
8.0340000   2.2231923 
(0.9942418) (0.7030351)

$`1_6_1uM_ccdc22RFP`
mean          sd    
12.0360000    1.7782306 
( 0.7952489) ( 0.5623259)

$`1_6_1uM_ccdc93`
mean         sd    
5.8800000   1.9594183 
(0.8762785) (0.6196225)

$`1_6_1uM_ccdc93RFP`
mean         sd    
9.8204000   1.8829721 
(0.8420907) (0.5954481)

$`1_6_1uM_WT`
mean         sd    
8.4960000   1.8055204 
(0.8074533) (0.5709557)

$`1_7_0nM_ccdc22`
mean         sd    
10.996000    5.868688 
( 2.624557) ( 1.855842)

$`1_7_0nM_ccdc22ccdc93`
mean         sd    
10.436000    4.532309 
( 2.026910) ( 1.433242)

$`1_7_0nM_ccdc22RFP`
mean         sd    
14.708000    4.563461 
( 2.040842) ( 1.443093)

$`1_7_0nM_ccdc93`
mean         sd    
17.004000    4.775398 
( 2.135623) ( 1.510113)

$`1_7_0nM_ccdc93RFP`
mean         sd    
13.043000    4.646970 
( 2.078188) ( 1.469501)

$`1_7_0nM_WT`
mean         sd    
12.814000    5.479805 
( 2.450643) ( 1.732867)

$`1_7_100nM_ccdc22`
mean         sd    
4.5660000   2.3199362 
(1.0375070) (0.7336282)

$`1_7_100nM_ccdc22ccdc93`
mean          sd    
10.1260000    2.6909225 
( 1.2034171) ( 0.8509444)

$`1_7_100nM_ccdc22RFP`
mean         sd    
9.9760000   2.0269741 
(0.9064904) (0.6409855)

$`1_7_100nM_ccdc93`
mean         sd    
10.612000    3.347037 
( 1.496840) ( 1.058426)

$`1_7_100nM_ccdc93RFP`
mean          sd    
11.2156000    2.2398883 
( 1.0017085) ( 0.7083149)

$`1_7_100nM_WT`
mean         sd    
9.1280000   1.5749336 
(0.7043317) (0.4980377)

$`1_7_10nM_ccdc22`
mean         sd    
10.388000    5.905836 
( 2.641170) ( 1.867589)

$`1_7_10nM_ccdc93`
mean         sd    
14.198000    4.243100 
( 1.897572) ( 1.341786)

$`1_7_10nM_ccdc93RFP`
mean          sd    
13.7317500    2.8102992 
( 1.4051496) ( 0.9935908)

$`1_7_10nM_WT`
mean         sd    
13.898000    5.187791 
( 2.320051) ( 1.640524)

$`1_7_1uM_ccdc22`
mean        sd   
8.972000   3.250399 
(1.453623) (1.027867)

$`1_7_1uM_ccdc22RFP`
mean         sd    
8.9340000   2.8487232 
(1.2739878) (0.9008454)

$`1_7_1uM_ccdc93`
mean         sd    
9.7820000   1.2883074 
(0.5761486) (0.4073986)

$`1_7_1uM_ccdc93RFP`
mean          sd    
10.5468000    2.2460588 
( 1.0044680) ( 0.7102662)

$`1_7_1uM_WT`
mean         sd    
5.5600000   1.0960109 
(0.4901510) (0.3465891)

$`1_8_0nM_ccdc22`
mean         sd    
11.098000    5.478826 
( 2.450206) ( 1.732557)

$`1_8_0nM_ccdc22ccdc93`
mean        sd   
7.268000   3.910946 
(1.749028) (1.236750)

$`1_8_0nM_ccdc93`
mean         sd    
14.562000    5.674372 
( 2.537656) ( 1.794394)

$`1_8_0nM_ccdc93RFP`
mean         sd    
11.003200    4.008287 
( 1.792561) ( 1.267532)

$`1_8_0nM_WT`
mean         sd    
12.806000    5.078884 
( 2.271346) ( 1.606084)

$`1_8_100nM_ccdc22`
mean        sd   
6.140000   3.201656 
(1.431824) (1.012452)

$`1_8_100nM_ccdc22ccdc93`
mean          sd    
10.0780000    2.4052227 
( 1.0756483) ( 0.7605982)

$`1_8_100nM_ccdc22RFP`
mean         sd    
8.3100000   0.8069387 
(0.4034693) (0.2852959)

$`1_8_100nM_ccdc93`
mean         sd    
9.1840000   2.3347085 
(1.0441134) (0.7382997)

$`1_8_100nM_ccdc93RFP`
mean         sd    
8.7422000   2.4736551 
(1.1062522) (0.7822384)

$`1_8_100nM_WT`
mean         sd    
8.9900000   2.3760892 
(1.0626194) (0.7513854)

$`1_8_10nM_ccdc22`
mean         sd    
10.190000    3.903496 
( 1.745696) ( 1.234394)

$`1_8_10nM_ccdc22ccdc93`
mean         sd    
11.374000    4.602389 
( 2.058251) ( 1.455403)

$`1_8_10nM_ccdc93`
mean         sd    
13.370000    4.886352 
( 2.185243) ( 1.545200)

$`1_8_10nM_ccdc93RFP`
mean        sd   
9.320200   4.467057 
(1.997729) (1.412608)

$`1_8_10nM_WT`
mean         sd    
16.620000    5.087451 
( 2.275177) ( 1.608793)

$`1_8_1uM_ccdc22`
mean          sd    
12.7800000    2.6326337 
( 1.1773496) ( 0.8325119)

$`1_8_1uM_ccdc93`
mean         sd    
10.304000    2.452881 
( 1.096962) ( 0.775669)

$`1_8_1uM_ccdc93RFP`
mean          sd    
13.2594000    1.9367606 
( 0.8661457) ( 0.6124575)

$`1_8_1uM_WT`
mean          sd    
10.9520000    2.3388578 
( 1.0459690) ( 0.7396118)

$`1_9_0nM_ccdc22`
mean         sd    
13.768000    4.950715 
( 2.214027) ( 1.565553)

$`1_9_0nM_ccdc93`
mean         sd    
13.488000    3.814621 
( 1.705951) ( 1.206289)

$`1_9_0nM_WT`
mean         sd    
14.410000    4.069187 
( 1.819796) ( 1.286790)

$`1_9_100nM_ccdc22`
mean         sd    
7.9000000   3.0197682 
(1.3504814) (0.9549346)

$`1_9_100nM_ccdc93`
mean          sd    
11.7800000    3.0436820 
( 1.3611760) ( 0.9624968)

$`1_9_100nM_ccdc93RFP`
mean          sd    
11.3258000    2.8698248 
( 1.2834246) ( 0.9075183)

$`1_9_100nM_WT`
mean          sd    
14.2020000    3.0192277 
( 1.3502397) ( 0.9547636)

$`1_9_10nM_ccdc22`
mean         sd    
11.680000    5.609189 
( 2.508506) ( 1.773781)

$`1_9_10nM_ccdc93`
mean         sd    
13.014000    4.382532 
( 1.959928) ( 1.385878)

$`1_9_10nM_ccdc93RFP`
mean         sd    
4.0922000   2.7778609 
(1.2422972) (0.8784368)

$`1_9_10nM_WT`
mean         sd    
14.890000    4.776660 
( 2.136187) ( 1.510512)

$`1_9_1uM_ccdc22`
mean         sd    
9.6760000   1.7423731 
(0.7792129) (0.5509868)

$`1_9_1uM_ccdc93RFP`
mean          sd    
10.6146000    2.2099493 
( 0.9883194) ( 0.6988473)

$`1_9_1uM_WT`
mean          sd    
10.1200000    2.8994275 
( 1.2966634) ( 0.9168795)



# View the ML parameters for each treatment
print(norm_pars)
summary(norm_pars)
str (norm_pars)

# Using the methods we have covered in class, write code to create a random data set that has these attributes. 
# Organize these data into a data frame with the appropriate structure.

r <- rnorm(1000,10.8,4.6)
mean(r)  
sd(r)   


regData <- data.frame(ID,varA,varB,myVar)
head(regData)
str(regData)




