# RLabs

# R Lab In-Class Assignment 1

Introduction
R has several built-in datasets. To see a list of these, with a title (short description), you may use the command data().
In this assignment we will work with the dataset mtcars. The dataset can be loaded with data(mtcars) and can be viewed through the data viewer with fix(mtcars).
To get a short description of the dataset and the variables in it, type ?mtcars. Once the dataset is loaded, you can extract each variable and assign it to a new object by means of the $ operator, as in:

Assign variable mpg of mtcars to X:

X <- mtcars$mpg

Tasks: 
1. Create a vector named kpl where the consumption is measured in lt/100km
2. Find the average weight of the cars, in lbs
3. The variables vs and am are actually categorical (factors). Are they coded as such? If not, convert them to such, with appropriate labels.
4. How many cars have more than 200 hp horsepower?
5. Which car is the fastest? (in terms of 1/4 mile)
6. How many Toyotas are in the database?
7. Save your script.

# R Lab In-Class Assignment 2

Introduction
This assignment is to be done on an individual basis. The scoring will be 0-10, and it will have a wight of 40% of the overall R Labs grade (which counts for 10% of the overall course grade). The data to be used for this assignment can be found in the Toilets_AUS.csv. It includes data published by the Australian government's department of health on details of public and private toilet facilities across the country. A selection of the variables (but all the toilets) is included in the dataset. The full dataset can be accessed via https://data.gov.au/dataset/national-public-toilet-map. The variables in the dataset are mostly self-explanatory, but feel free to explore to get a better grip. Please answer the questions below. Make sure you name the Data as indicated below so the script is run-able. Submit the script as a solution. 

Questions
1. Load the data in an object named TAUS. What kind of object is the data, and in which format is each variable coded? 
2. How many toilets are in Australia? (obviously, not including private toilets, that is, how many toilets
are in the database)
3. How many veried toilets are located more west than 120◦?
4. Which is the city with the most toilets and in which state is it located?
5. Transform the variables Parking, Showers and DrinkingWater into logical vectors. Create a matrix by putting these three vectors together as columns. By means of the apply function, create a vector that counts how many of these characteristics each toilet has (parking, shower and drinking water). How many toilets have all of them?

# R Lab In-Class Assignment 3

Introduction
This assignment is to be done on an individual basis. The scoring will be 0-10, and it will have a weight of 60% of the overall R Labs grade (which counts for 10% of the overall course grade). The data to be used for this assignment can be found in the file Drugs.txt. It includes data published by OECD on pharmaceutical drug spending by countries with indicators such as a share of total health spending, in USD per capita (using economy-wide PPPs) and as a share of GDP. Plus, total spending by
each countries in the specific year. The variables in the dataset are:

Variable name - Description

a. LOCATION - Country code
b. TIME - Date (Year)
c. PC_HEALTHXP - % of Health spending that is spent on pharmaceutical drugs
d. PC_GDP - % of GDP
e. USD_CAP - in USD per capita (using economy-wide PPPs)
f. TOTAL_SPEND - Total spending in millions USD

Questions
1. Load the data in an object named Drugs. You will notice there is an additional variable called FLAG_CODES. Remove this variable from the dataset.
2. How many countries are there? Make a table with the countrys' acronyms and the number of datapoints (years) per country, sorted in ascending order (the country with the least datapoints appears first) Hint: table().
3. Make a selection of countries based on the number of datapoints available. Specically, select the countries that have a number of points in the top 25% of the distribution of number of data points, thus representing the countries with the most information available. (Hint: functions subset(), quantile() and %in% operator might come handy here). 
4. Using only the data selected in Q3, create a graph with 4 plots (in the same window). Each plot should depict the development of the drug spending for all countries in the reduced dataset, over the available years. Each graph should depict one of the metrics (4 metrics= 4 graphs). In each graph, a separate line should represent a country. The legend should show which line represents each country. The main title of each plot should mention "Drug spending in XX (type of metric)".
(Hints: par(mfrow=..), define the x-axis limits by the range found in the dataset, that is, smallest year found in the dataset up to largest year found in the dataset.)
5. Your client is a multinational pharmaceutical company. They are interested in the probability that Greece (GRC) will increase its drug expenditure in at least 4 of the 5 following consecutive years, in order to assess the investing opportunities. Assume that we are at the year following the last record for Greece. Estimate the probability of drug expenditure increase in any given year by the number of years where the expenditure was higher than the year before (note: this is not an appropriate way of estimating this probability, only use it for this assignment!). (Hint: functions diff() and
dbinom()). Create a list with the following elements, named accordingly:

$Data The data for Greece
$Years The range (in years) of available data points for Greece, a vector with two elements, the minimum and maximum years
$Data.points The number of available data points for Greece
$YearlyProbs The yearly probabilities of increase in expenditure, in all the four metrics available, thus a vector with 4 elements and names according to the metric
$FiveYeProbs The requested probabilities for all metrics, thus a vector with 4 elements and names according to the metric

6. Your client asks for a function that can calculate the above probabilities for a variable amount of years and for any country desired. Create a function, that it will take as arguments (and default values):

a. DATA=NULL Data in the same form as the dataset (without the FLAG_CODES variable)
b. METRIC="pc.gdp" The metric in which the required probability needs to be reported. Possible values should be "pc.gdp" (% of GDP), "pc.tot" (% of total health expenditure), "per.ca" (absolute expenditure per capita), and "total" (total absolute spending).
c. nofY=5 The number of following consecutive years that the probability needs to be estimated. Every time the probability estimated should be of the form "The probability of increasing drug expenditure in at least nofY-1 out of the following nofY years". 

The outcome of the function should be a sentence of the form: "Based on (XX) datapoints from years (minYear) to (maxYear), the probability that (countrycode) will increase its drug expenditure, in terms of (metric chosen), in at
least (nofY-1) years in the period (maxYear+1) to (maxYear+1+nofY) is (estimated probability)".

If the number of available datapoints for the calculation of the yearly increase probability is less than 10 (thus, less than 11 years of data), the function should return : "Unable to calculate probability (n< 10)", without any other output.
Hint: Use paste()
