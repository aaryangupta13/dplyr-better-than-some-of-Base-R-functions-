#install.packages("hflights")
#install.packages("dplyr")

library(hflights)                       # Loading the 'hflights' external package.
library(dplyr)                          # Loading the 'dplyr' external package.

data(hflights)                          # Loading data of 'hflights' in a data.frame.
head(hflights)                          # Returns the first part of a vector, matrix, table, data frame or function.

flights = tbl_df(hflights)              # The tbl_df class is a subclass of data.frame, created in order to have different default behaviour. Typically leading to code that is more expressive and robust.
flights                                 # Viewing the table after storing it in the variable 'flights'.

print(flights, n= 4)                    # Prints the entire table with 'n' no. of rows, 'n' specifies the no. of rows to return.

data.frame(head(flights))               # Return the first part of the data.frame flights.

colnames(flights)                       # Returns all the column names of the df flights.

#-----------------------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------------------#

# Base R approach to filter rows
flights[(flights$Month == 1) & (flights$DayofMonth == 1),]

# dplyr approach to filter rows
dplyr::filter(flights, Month == 1, DayofMonth == 1)

#-----------------------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------------------#



#-----------------------------------------------------------------------------------------------------------------------------------#

# Base R approach to filter columns
flights[,c("DepTime","ArrTime","FlightNum")]

# dplyr approach to filter columns : just like SQL
dplyr::select(flights, DepTime, ArrTime, FlightNum)
dplyr::select(flights, Year:DayofMonth, contains(c("Taxi","Delay")))

#-----------------------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------------------#



#-----------------------------------------------------------------------------------------------------------------------------------#

# Base R approach for selecting columns with filtered rows
flights[flights$DepDelay > 60, c("UniqueCarrier","DepDelay")]


# dplyr normal approach for selecting columns with filtered rows, which is a little hard for readability

dplyr::filter(select(flights,UniqueCarrier, DepDelay), DepDelay > 60)
# dplyr chaining method for a better readability to select columns with filtered rows
flights %>%
  dplyr::select(UniqueCarrier, DepDelay) %>%
  dplyr::filter(DepDelay > 60)

#-----------------------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------------------#



#-----------------------------------------------------------------------------------------------------------------------------------#

# Base R approach for sorting by a column
flights[order(flights$DepDelay), c("UniqueCarrier","DepDelay")]

# dplyr approach for sorting by a column
flights %>%
  select(UniqueCarrier, DepDelay) %>%
  arrange((DepDelay)) # for ascending order : arrange(desc(DepDelay))

#-----------------------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------------------#



#-----------------------------------------------------------------------------------------------------------------------------------#

# dplyr approach to add a new variable in the df
flights %>%
  select(Distance, AirTime) %>%
  mutate(speed = Distance / AirTime*60) # and assign this whole command to flights to store the variable "speed", otherwise this variable life ends after the command is run and output is generated

#-----------------------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------------------#



#-----------------------------------------------------------------------------------------------------------------------------------#

# dplyr approach to summarise data
flights %>%
  group_by(Dest) %>%
  summarise(Avg_Delay = mean(ArrDelay, na.rm = TRUE)) # As there are a lot of values "NA", and so we remove those by na.rm

# for each carrier, we will calculate the percentage of cancelled and diverted flights
flights %>%
  group_by(UniqueCarrier) %>%
  summarise_each(funs(mean), Cancelled, Diverted) #funs(mean) will calculate the mean of the requested columns

# for each carrier, we will calculate the min and max arrival and departure delays
flights %>%
  group_by(UniqueCarrier) %>%
  summarise_each(funs(min(., na.rm = T), max(., na.rm = T)), matches("Delay")) # The "." in the min and max funs is just the placeholder for the data we are passing in

#-----------------------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------------------#



#-----------------------------------------------------------------------------------------------------------------------------------#

# USING dplyr package only ::

#-----------------------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------------------#

# for each day of the year, count the total number of flights and sort in descending order
flights %>%
  group_by(Month,DayofMonth) %>%
  summarise(flight_count = n()) %>%  # n() is counting the no. of rows in the group, and 1 row represents 1 flight so n() represents the flight count
  arrange(desc(flight_count))

# The same can be done with a simple tally fn which has a simple format and more readable
flights %>%
  group_by(Month,DayofMonth) %>%
  tally(name = "flight_count", sort = TRUE) # summarise(flight_count = n()) can be replaced with tally as it counts rows in the groups, and sort=TRUE is to sort it in a Descending order

#-----------------------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------------------#



#-----------------------------------------------------------------------------------------------------------------------------------#

# for each destination, count the total number of flights and the no. of distinct planes that flew there
flights %>%
  group_by(Dest) %>%
  summarise(flight_count = n(), Plane_count = n_distinct(TailNum))

#-----------------------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------------------#



#-----------------------------------------------------------------------------------------------------------------------------------#

# for each destination, show the number of cancelled and not cancelled flights
flights %>%
  group_by(Dest) %>%
  select(Cancelled) %>%
  table() %>%
  head()

#-----------------------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------------------#



#-----------------------------------------------------------------------------------------------------------------------------------#

# for each carrier, calculate which two days of the year they had their longest departure delays
flights %>%
  group_by(UniqueCarrier) %>%
  select(Month, DayofMonth, DepDelay) %>%
  filter(min_rank(desc(DepDelay)) <= 2) %>%
  arrange(UniqueCarrier, desc(DepDelay))

# same can be done with a top_n() which is more readable and has a simple format, 
flights %>%
  group_by(UniqueCarrier) %>%
  select(Month, DayofMonth, DepDelay) %>%
  top_n(2) %>%  # top_n() replaces filter(min_rank()) and shows the top 2
  arrange(UniqueCarrier, desc(DepDelay))

#-----------------------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------------------#



#-----------------------------------------------------------------------------------------------------------------------------------#

# for each month, calculate the number of flights and the change from the previous month
flights %>%
  group_by(Month) %>%
  summarise(flight_count = n()) %>%
  mutate(change = flight_count - lag(flight_count)) # lag() looks at the previous value of a vector or a column, and lead() looks at the next value

# Same can be done with tally() which is more short and readable
flights %>%
  group_by(Month) %>%
  tally() %>%
  mutate(change = n - lag(n))

#-----------------------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------------------#



#-----------------------------------------------------------------------------------------------------------------------------------#

# Additional convenient 'dplyr' functions which come handy as per the requirement ::

#-----------------------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------------------#

# Randomly sample a fixed number of rows, without replacement
flights %>% sample_n(5)

# Randomly sample a fraction of rows, without replacement
flights %>% sample_frac(0.15) # to sample *with* replacement, we can do sample_frac(0.15, replace = TRUE)

#-----------------------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------------------#



#-----------------------------------------------------------------------------------------------------------------------------------#

# Base R approach to view the structure of the table
str(flights)

# dplyr approach to view the structure of the table : better formatting, adapts to our screen width
dplyr::glimpse(flights)

#-----------------------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------------------------------------#
