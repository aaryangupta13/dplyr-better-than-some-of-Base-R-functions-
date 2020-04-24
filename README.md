# dplyr-better-than-some-of-Base-R-functions-
I have shown and compared here some functions of dplyr package which is an external package with some of the base R functions, to show its rapid execution, better readability and easy formatting than the Base R functions itself.


Some functions which I have included from the package dplyr are as follows:

1) filter()         - Filter out the extraction of rows by satisfying a condition.
2) select()         - Extracts the columns mentioned which are present in the data.frame.
3) mutate()         - Add n number of columns in data.frame.
4) arrange()        - Sorts the column in ascending order by default and in descending order with arrange(desc()).
5) summarise()      - Reduces multiple values down to a single value, like only mean, or only median and more.
6) summarise_each() - Reduces multiple values down to multiple values, like min and max and more together.
7) tally()          - Count the number of rows by group and returns a number under a column name "n" as default.
8) top_n()          - It replaces filter(min_rank()) and shows the top n number of rows.

These all combine naturally with group_by() which allows you to perform any operation "by group".

I have also covered few convenient functions of dplyr which might come handy as per your requirement, these are:

1) sample_n()    - Randomly sample a fixed number of rows, without replacement.
                      *with replacement, we can do - sample_frac(,replace = TRUE)*
2) sample_frac() - Randomly sample a fraction of rows, without replacement.
                      *with replacement, we can do - sample_frac(,replace = TRUE)*
3) glimpse()     - dplyr approach to view the structure of the table, with better formatting and also it adapts to our screen.

Also covered few examples and extractions with few other functions of dplyr, and also provided a better format to present your code
which is more readable and not to mention, much faster to code and for execution.
