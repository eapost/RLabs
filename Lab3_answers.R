# APOSTOLAKI ELEFTHERIA

# Question 1
# Loaded from my local file - please change the path with your local path 
  
  Drugs <- read.table("/Users/eleftheriaapostolaki/Desktop/Drugs.txt", 
                    header = TRUE,
                    sep = ",",
                    stringsAsFactors = FALSE)

  Drugs$FLAG_CODES <- NULL

# Question 2
  
  uniqueLocs <- unique(Drugs$LOCATION)
  locations <- as.data.frame(uniqueLocs)
  # Number of countries
  nrow(locations)
  # Years per country
  install.packages("dplyr")
  library("dplyr")
  dt<-Drugs %>% group_by(Drugs$LOCATION) %>% summarize(count=n())
  dt[order(dt$count),]

# Question 3

  n <- 25
  top25 <- Drugs[Drugs$TIME >= quantile(Drugs$TIME,prob=1-n/100),]
  top25
  
# Question 4
# Please note that the plot delays to be loaded
  
  install.packages("tidyverse")
  install.packages("gridExtra")
  library("ggplot2")
  library("gridExtra")
  
  plot1 <- ggplot(top25, aes(x = top25$TIME, y = top25$PC_HEALTHXP)) + labs(title = "Drug spending in percentage of health", x = "Year", y = "Percentage of health spending")
  plot2 <- ggplot(top25, aes(x = top25$TIME, y = top25$PC_GDP)) + labs(title = "Drug spending in percentage of GDP", x = "Year", y = "Percentage of GDP spending")
  plot3 <- ggplot(top25, aes(x = top25$TIME, y = top25$USD_CAP)) + labs(title = "Drug spending in USD per capita", x = "Year", y = "Spending in USD per capita")
  plot4 <- ggplot(top25, aes(x = top25$TIME, y = top25$TOTAL_SPEND)) + labs(title = "Drug spending in total", x = "Year", y = "Total spending in millions USD")
  
  grid.arrange(plot1 + geom_line(aes(color = top25$LOCATION)), plot2 + geom_line(aes(color = top25$LOCATION)), plot3 + geom_line(aes(color = top25$LOCATION)), plot4 + geom_line(aes(color = top25$LOCATION)), nrow = 2, ncol=2)

# Question 5 
  
  Data <- Drugs[Drugs$LOCATION %in% c("GRC"), ]
  
  duration = Data$TIME 
  Years <- c(max(duration),min(duration))
  Years
  
  points <- nrow(Data)
  points
  
  # Yearly probabilities of increase
  gdp <- diff(Data$PC_GDP, differences = 1)
  healthhxp <- diff(Data$PC_HEALTHXP, differences = 1)
  usdcap <- diff(Data$USD_CAP, differences = 1)
  totalspend <- diff(Data$TOTAL_SPEND, differences = 1)
  
  YearlyProbs <- data.frame(gdp=gdp,
                            healthhxp=healthhxp,
                            usdcap=usdcap, totalspend=totalspend)
  
  # Probability of 1st metric
  positive_gdp <- YearlyProbs$gdp[which(YearlyProbs$gdp > 0)]
  gdp_prob <- length(positive_gdp) / length(gdp)
  prob1 <- dbinom(4, size=5, prob=gdp_prob) + dbinom(5, size=5, prob=gdp_prob)
  prob1
  
  # Probability of 2nd metric
  positive_healthhxp <- YearlyProbs$healthhxp[which(YearlyProbs$healthhxp > 0)]
  healthhxp_prob <- length(positive_healthhxp) / length(healthhxp)
  prob2 <- dbinom(4, size=5, prob=healthhxp_prob) + dbinom(5, size=5, prob=healthhxp_prob) 
  prob2
  
  # Probability of 3rd metric
  positive_usdcap <- YearlyProbs$usdcap[which(YearlyProbs$usdcap > 0)]
  usdcap_prob <- length(positive_usdcap) / length(usdcap)
  prob3 <- dbinom(4, size=5, prob=usdcap_prob) + dbinom(5, size=5, prob=usdcap_prob) 
  prob3
  
  # Probability of 4th metric
  positive_totalspend <- YearlyProbs$totalspend[which(YearlyProbs$totalspend > 0)]
  totalspend_prob <- length(positive_totalspend) / length(totalspend)
  prob4 <- dbinom(4, size=5, prob=totalspend_prob) + dbinom(5, size=5, prob=totalspend_prob)
  prob4
  
# Question 6 
  
  Data2 <- Drugs[Drugs$LOCATION %in% c("GRC"), ]

  prob <- function(DATA = NULL, METRIC = "pc.gdp", nofY=5) {
    
    if (METRIC == "pc.gdp") {
      dataMetric <- DATA$PC_GDP
    } 
    else if (METRIC == "pc.tot") {
     dataMetric <- DATA$PC_HEALTHXP
    } 
    else if (METRIC == "per.ca") {
     dataMetric <- DATA$USD_CAP
    } 
    else if (METRIC == "total") {
      dataMetric <- DATA$TOTAL_SPEND
    }
    else {
      return ("Invalid metric provided")
    }
    
    loc <- DATA$LOCATION[1]
    metricData <- diff(dataMetric, differences = 1)
    
                      if (length(metricData) > 10) {
                          duration2 = DATA$TIME 
                          minduration <- min(duration2)
                          maxduration <- max(duration2)
                          nbryears <- maxduration - minduration
                          positive_metric <- metricData[which(metricData > 0)]
                          metric_prob <- length(positive_metric) / length(metricData)
                          total_prob <- dbinom(nofY-1, size=nofY, prob=metric_prob) + dbinom(nofY, size=nofY, prob=metric_prob)  
                          paste (" Based on ", nbryears , " datapoints from years ", minduration ," to ", maxduration , " the probability that ", loc ," will increase its drug expenditure, in terms of ", METRIC ,", in at least ", nofY - 1 ," years in the period ", maxduration+1 ," to ", maxduration+1+nofY ," is ", total_prob , sep='')
                      } else {
                          paste ("Unable to calculate probability (n < 10)”, without any other output.", sep='')
                      }
  }
  
  
  
  