<!-- Strong-->
# Pewlett-Hackard-Analysis

<!-- Horizontal Rule-->

## Overview and Background of Project
The CEO (V. Isualize) has requested that a DataFrame summary be created for the ride-sharing data by city type of the recently completed PyBer analysis exercise. The CEO has asked Omar to assist with the project. The deliverables for this project were discussed with Omar, and the understanding is that Python scripting will be utilized within the Jupyter Notebook environment. This will include the aid of libraries such as Pandas, Matplotlib and Numpy to deliver the results for this exercise. The following are the deliverables:

*  Deliverable 1: A ride-sharing summary DataFrame by city type;
*  Deliverable 2: A multiple-line chart of total fares for each city type and;
*  Deliverable 3: A written report for the PyBer analysis, thus:
      
## Purpose
The purpose of this Data Analytic exercise is to use the combined power of Python, Pandas and Matplotlib to assist the CEO with a detailed analysis of a large csv dataset comprising over 2,300 records of ride-sharing data categorized by Urban, Suburban and Rural city types and to determine, ultimately, the profitability and distribution of fare by city type.

## Analysis and Challenges
The challenge of this exercise is to create a summary DataFrame of the ride-sharing data by city type using Pandas. And further, to display the results in a multiple-line graph, using Matplotlib, which shows the total weekly fares for each city type. 

### Initial Review of Dataset:
<!--UL-->
* First, a high-level inspection and review were done to get a sense of the data regarding the dataset's number of columns and rows. This was done to understand the data types and to determine whether the data was readable or would need to be converted before progressing further with the analysis. Upon inspection of the dataset, it was determined that the two files (city_data and ride_data) were in csv format, which contained information stored in what appeared to be columns, separated by commas, with headings for city, date, fare, ride_id, type and driver_count respectively, which included 2,375 rows of data in 4 columns in the ride_data dataset and comparatively; 120 rows in 3 columns in the city_data dataset.  

<!--Links-->
<!--UL-->
* Because the ride_data dataset was so large, an investigation was done to precisely establish the number of columns and rows. This was done by opening the file in excel and utilizing various keyboard shortcuts, combining keyboard keys such as CTRL/right or down arrow keys to get a quick idea of the dataset's number of rows and columns. It was established that ride data was stored in 2,375 rows and in 4 columns. 
  
* Next, it was necessary to determine whether Python was installed correctly on the machine to permit Python scripting to progress. This was achieved by scripting a simple program to print "Hello World" to the terminal. This was proven to be favourable. The data was then imported into Jupyter Notebook for further inspection and stored in a folder called Resources as the first step towards performing the PyBer analysis.  
  
<!--UL-->
### Initial analysis to test data before deep dive:

* This was achieved by utilizing the pseudocode method, which helps to facilitate the code scripting process by creating models or flowcharts for a high-level understanding and roadmap for the project. Hence a list of actions was written down. For example; to read the csv data file into Jupyter Notebook using Pandas, to open the data file; to write down the city types, read the city data file and store in a pandas DataFrame, thus:

#### Pseudocode:
   * The data we need to retrieve
   * The data types of each column. 
   * The city data file and store it in a pandas DataFrame.
   * The ride data file and store it in a pandas DataFrame.
   * The columns and the rows that are not null
   * The columns and the rows that are not null.
   * Combine the data into a single dataset
   * Display the DataFrame for inspection
   * Create the Urban, Suburban and Rural city DataFrames
   * The total rides for each city type
   * The total amount of fares for each city type
   * The average fare per driver for each city type.

1. Files Loaded:
   city_data_to_load = "Resources/city_data.csv"
   ride_data_to_load = "Resources/ride_data.csv"
   
2. Combine the data into a single dataset:
   pyber_data_df = pd.merge(ride_data_df, city_data_df, how="left", on=["city", "city"])

<!--Links-->
3. Next,  [Stockoverflow](https://stackoverflow.com/questions/46555819/months-as-axis-ticks
"Adding monthly ticks to a plot") was consulted for assistance with a code string to add monthly ticks to an axis.  

4.  Next,  [Matplotlib 3.5 documentation](https://matplotlib.org/stable/index.html "general guidance with Matplotlib") was consulted for assistance with general code string to charts.
  
## Deliverable 1: Getting the Summary DataFrame:
### Performing the analysis.
1. Get the total rides for each city type:
  Total_Rides = pyber_data_df.groupby(["type"]).count()["ride_id"]
  
    * Rural = 125
    * Suburban = 625
    * Urban = 1625

2. Get the total drivers for each city type:
   Total_Drivers = city_data_df.groupby(["type"]).sum()["driver_count"]
    * Rural = 78
    * Suburban = 490
    * Urban = 2405

3. Get the total amount of fares for each city type: 
   Total_Fare = pyber_data_df.groupby(["type"]).sum()["fare"]

    * Rural = 4327.93
    * Suburban = 19356.33
    * Urban = 39854.38

4. Get the average fare per ride for each city type:
   Average_Fare = pyber_data_df.groupby(["type"]).mean()["fare"]
    
    * Rural = 34.623440
    * Suburban = 30.970128
    * Urban = 24.525772
  
5. Get the average fare per driver for each city type:
   Avg_Fare_per_Driver = pyber_data_df.groupby(["type"]).sum()["fare"] /city_data_df.groupby(["type"]).sum()["driver_count"]

    * Rural = 55.486282
    * Suburban = 39.502714
    * Urban =   16.571468

6. Create a PyBer summary DataFrame: 

pyber_summary_df = pd.DataFrame({
             "Total Rides": Total_Rides,
             "Total Drivers": Total_Drivers,
             "Total Fares": Total_Fare,
             "Average Fare per Ride": Average_Fare,
             "Average Fare per Driver": Avg_Fare_per_Driver})

7. Cleaning up the DataFrame. Delete the index name:
    * pyber_summary_df.index.name = None

8. Format the columns:
    * pyber_summary_df["Total Fares"] = pyber_summary_df["Total Fares"].map("${:,.2f}".format)

    * pyber_summary_df["Average Fare per Ride"] = pyber_summary_df["Average Fare per Ride"].map("${:.2f}".format)

    * pyber_summary_df["Average Fare per Driver"] = pyber_summary_df["Average Fare per Driver"].map("${:.2f}".format)

 <!--UL--> 
## Deliverable 2. Create a multiple-line plot that shows the total weekly fares for each type of city.
### Multiple Line Plot Results 

1. Read the merged DataFrame: 
   
    * pyber_data_df = pd.merge(ride_data_df, city_data_df, how="left", on=["city", "city"])

2. Using groupby() to create a new DataFrame showing the sum of the fares and for each date where the indices are the city type and date:

    df = pyber_data_df.groupby(["date","type"]).sum()[["fare"]]
  
3. Reset the index on the DataFrame you created in #1. This is needed to use the 'pivot()' function:

    df = df.reset_index()

4. Create a pivot table with the 'date' as the index, the columns =' type,' and values='fare'to get the total fares for each type of city by the date:

  pyber_data_pivot=df.pivot(index="date",columns="type", values ="fare")

5. Create a new DataFrame from the pivot table DataFrame using loc on the given dates, '2019-01-01':'2019-04-29':

  pyber_data_pivot_dates=pyber_data_pivot.loc['2019-01-01':'2019-04-29']

6. Set the "date" index to datetime data type. This is necessary to use the resample()

    pyber_data_pivot_dates.index=pd.to_datetime(pyber_data_pivot_dates.index)

7. Check that the datatype for the index is datetime using df.info():

    pyber_data_pivot_dates.info()

8. Create a new DataFrame using the "resample()" function by week 'W' and get the sum of the fares for each week:

    pyber_data_pivot_week=pyber_data_pivot_dates.resample("W").sum()

 <!--UL-->
 <!--Strong--> 
 <!--Images-->
### Results from multiple-line chart:

Incomplete
   
 <!--OL--> 
### Challenges and Solutions Encountered

1.  Learning and developing the various data series for the Pyber summary DataFrame including the formatting of the DataFrame. Preparing and plotting the graph using the object-oriented interface method was a major challenge for me which I was unable to complete. However, over time, I will grasp key concepts of these commands to produce the desired results.

2.  Stockoverflow and the Matplotlib documentation continue to be a fantastic resource with a considerable repertoire of codes and other valuable resources. Both resources were consulted extensively during this exercise. 

## Conclusions:
<!--OL-->
### Outcomes based on Python Analysis of the PyBer Ride Sharing Summary DataFrame:
1.  Python scripting continues to be a powerful data analytic tool in performing the PyBer ride-sharing analysis for the CEO. As can be seen from the results, we were able to accurately determine, by way of python scripting, matplotlib and pandas, the total number of rides per city type, the total drivers per city, including the total amount of fares for each city type and the corresponding rides. These individual Data Series were then combined to produce the Pyber Summary DataFrame. This allowed us to determine other interesting facts about the ride-sharing data; for example, we were able to establish what the average fare per ride in rural cities was, i.e. as much as $34.62, while in the Suburban and Urban cities, the average cost per ride was $30.97 and $24.53 respectively. This corresponds to the average fare per driver, which was $55.49, $39.50 and $16.57 dollars in the Rural, Suburban and Urban cities, respectively, with a total ride per city of 125 in Rural cities 625 in the Suburban cities and 1625 in the Urban cities.

