import os
import pandas as pd
import calendar

# When you start service, please use the second line below -> # year_month = '202105'
year_month = input("Please enter MONTH and YEAR : YYYYMM")
# year_month = '202105'

# get names list of all files
file_list = os.listdir('./INOUT_forStudents')
to_extract_file_list = [file for file in file_list if year_month in file]
print(to_extract_file_list)

# extract year and month -> str
year = year_month[:4]
month = year_month[-2:]

# get the last day of the input month
last_day_of_month = calendar.monthrange(int(year), int(month))[-1]

# Make the blank DF to append datas in the for loop below
final_df = pd.DataFrame(columns=["Date", "In Time", "Out Time", "Token ID"])
print(final_df)

# for loop to extract, merge, append
for i in range(last_day_of_month):
    try:
        day = i+1
        print(day)
        if day < 10:
            day = str("0")+str(day)
        else:
            day = str(day)
        filename = year+month+day

        df1 = pd.read_csv('./INOUT_forStudents/IN_{}.csv'.format(filename)).rename(columns = {"Time": "In Time"})
        df2 = pd.read_csv("./INOUT_forStudents/OT_{}.csv".format(filename)).rename(columns = {"Time": "Out Time"})

        merged_df = pd.merge(df1, df2, on="Token ID")
        merged_df = merged_df[["Date_x", "In Time", "Out Time", "Token ID"]].rename(columns={"Date_x": "Date"})
        final_df = pd.concat([final_df, merged_df], ignore_index=True)

    except:
        pass

# to calculate the Hrs and Mins columns using DATETIME, DATEDELTA
InTime_Array = pd.to_datetime(final_df["Out Time"])
OutTime_Array = pd.to_datetime(final_df["In Time"])
time_diff = InTime_Array - OutTime_Array
hours = [time_diff[i].seconds//3600 for i in range(len(time_diff))]
minutes = [(time_diff[i].seconds//60)%60 for i in range(len(time_diff))]

# make new columns with the Series of hours and minues below
final_df["Hrs"] = hours
final_df["Mins"] = minutes

# put out
output_filename = "MG_"+year+month+".csv"
final_df.to_csv(output_filename)
