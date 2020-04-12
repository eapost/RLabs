#Graded Assignment 1

#1st question 
#Loaded from my local file - please change the path with your local path 

TAUS <- read.csv(file = "/Users/XXXX/Desktop/Toilets_AUS.csv", 
                 header = TRUE,
                 sep = ",",
                 stringsAsFactors = FALSE)
class(TAUS)
sapply(TAUS, class)

# 2nd question
nrow(TAUS)

# 3rd question
nrow(subset(TAUS, TAUS$Status == "Verified" & TAUS$Longitude < 120))

#4th question
frequency <- as.data.frame(table(TAUS$Town))
state <- subset(frequency$Var1, frequency$Freq == max(frequency$Freq))
unique(subset(TAUS$State, TAUS$Town == town))
state

#5th question
TAUS$Parking <- as.logical(TAUS$Parking)
mode(TAUS$Parking)
TAUS$Showers <- as.logical(TAUS$Showers)
mode(TAUS$Showers)
TAUS$DrinkingWater <- as.logical(TAUS$DrinkingWater)
mode(TAUS$DrinkingWater)
matrix <- cbind(TAUS$Parking,TAUS$Showers,TAUS$DrinkingWater)
dimnames(matrix) <- list(NULL, c("Parking", "Showers","Drinking Water"))
m <-apply(matrix, 1, sum)
length(subset(m, m==3))

#6th question
Longitude <- TAUS$Longitude
Latitude <- TAUS$Latitude
State <- TAUS$State

unique_state <- unique(TAUS$State)
returnedData <- cbind(unique_state, statecolors = c("#FF4040", "#0000FF", "#000000", "#7FFF00", "#FFD700", "#97FFFF", "#696969", "#8B3E2F"))
returnedData[,1]
combinedData <- data.frame(subset(TAUS, select = c(State)),
           matchRetVal = match(TAUS$State, returnedData))
combinedData
plot(Longitude, Latitude, col = combinedData$matchRetVal[match(TAUS$State, combinedData$State)],
     main = 'Toilets in Australia', cex = 1)

legend(x = 'topleft', 
       legend = as.character(returnedData[,1]),
       col = returnedData[,2], pch = par("pch"), bty = 'n', xjust = 1, cex=0.45)

#7th question

install.packages("geosphere")
library(geosphere)

longlat1 = purrr::map2(TAUS$Longitude, TAUS$Latitude, function(x,y) c(x,y))
longlat2 = purrr::map2(144.9836900, -33.6350736, function(x,y) c(x,y))

distance_list = purrr::map2(longlat1, longlat2, function(x,y) geosphere::distHaversine(x, y))
distance_numeric <- as.numeric(distance_list)
combined_distance <- cbind(TAUS$Name, TAUS$Showers, TAUS$Parking, distance_numeric)
withShowers <- subset(combined_distance,combined_distance[,2] == TRUE)
withParking <- subset(withShowers, withShowers[,3] == TRUE)
minDistance <- min(withParking[,4])
nameLessDistanceWithCriteria <- subset(withParking[,1], withParking[,4] == minDistance)
nameLessDistanceWithCriteria
