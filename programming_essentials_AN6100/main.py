#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import pandas as pd
import datetime as dt
from datetime import datetime
import os
import csv


def main():
    MENU = """***** Factory Attendance ***** 
                    S: Scan Token
                    T: Set Token Profile
                    M: Merge Input/ Output Files
                    O: Over Time Report
                    A: Absent Report
                    Q: Quit"""

    print(MENU)
    selection = input("Please input the menu option: ")
    selection = selection.upper().replace(" ", "")
    if selection in ['S', 'T', 'M', 'O', 'A', 'Q']:
        pass
    else:
        print("Invalid selection... Please key in again")

    while True:
        if selection == "S":
            ScanToken()
        elif selection == "T":
            SetTokenProfile()
            main()
        elif selection == "M":
            MergeFiles()
            main()
        elif selection == "O":
            OverTimeReport()
        elif selection == "A":
            AbsentReport()
        elif selection == "Q":
            print("Quit the program.")
            break
        else:
            print("Invalid selection, please try again")
            break
        break


TokenID = 0
def ScanToken():
    # global variable for usage in both ScanToken() and SetTokenProfile()
    global TokenID

    # to make sure working directory is correct, to append csv files
    # os.getcwd()
    # path = os.getcwd() + "/INOUT"
    # os.chdir(path)

    while True:
        TokenID = str(input(
            "Please enter your Token ID or enter Q to quit: "))  # assume the token ID will be automatically retrieved when scanning the QR code
        TokenID = TokenID.strip().upper()

        if TokenID == "Q":
            break
        else:
            current_date = dt.datetime.now().date()  # data value
            reformatted_current_date = current_date.strftime("%Y%m%d")  # To name the file
            current_time = dt.datetime.now().time()
            reformatted_current_time = current_time.strftime("%H:%M")  # To remove the seconds for data value

            OnePM = dt.time(13, 00)

            if current_time < OnePM:
                outputFilename = "./INOUT/IN_" + reformatted_current_date + ".csv"
            elif current_time > OnePM:
                outputFilename = "./INOUT/OT_" + reformatted_current_date + ".csv"

            if outputFilename not in os.listdir():
                fp = open(outputFilename, "w")
                colName = ["Date", "Time", "TokenID"]
                writer = csv.writer(fp)
                writer.writerow(colName)
                fp.close()
            fp = open(outputFilename, "a")
            writer = csv.writer(fp)
            dataList = [current_date, reformatted_current_time, TokenID]
            writer.writerow(dataList)
            fp.close()
            print(f"File {outputFilename} saved")
    main()


def SetTokenProfile():
    global TokenID


    df = pd.read_csv('./INOUT/employee.csv')
    dictionary = df.to_dict(orient='list')

    # Input employee ID
    while True:
        EmployeeID = str(input("Please enter your Employee ID: "))
        EmployeeID = EmployeeID.strip().upper()

        if EmployeeID.isdigit() == False:
            print("Wrongly entered. Please enter your Employee ID again.")  # token ID to contain only integer
            continue
        else:
            break

    # List comprehension to check if ID exists in employee.csv file
    if any([True for k, v in dictionary.items() if v == EmployeeID]):
        print("Already in system.")
        exit
    else:
        # Request personal information if employee ID does not exist in employee.csv file
        print("ID is not in directory. Key in your particulars")

        # isalpha() to make sure all alphabets for name
        # isdigit() to make sure all alphabets for mobile number
        while True:
            Name = str(input("Please enter your name: "))
            if Name.isalpha() == False:
                print("Wrongly entered.")  # token ID to contain only integer
                (f"{Name}")
            else:
                MobileNo = str(input("Please enter your mobile number: "))
                if MobileNo.isdigit() == False:
                    print("Wrongly entered.")  # token ID to contain only integer
                    (f"{MobileNo}")
                else:
                    Email = str(input("Please enter your email: "))
                    from email.utils import parseaddr
                    if parseaddr(Email) == ('', ''):
                        print("Wrongly entered.")  # token ID to contain only integer
                        (f"{Email}")
                    break

    print(""" 
          *** Scan the trace together token QR code ***
          """)

    # Append particulars to file

    with open('./INOUT/employee.csv', mode='a+', newline='') as file_pointer:
        employee_writer = csv.writer(file_pointer, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
        dataList = [EmployeeID, Name, MobileNo, Email, TokenID]
        employee_writer.writerow(dataList)

        # append employee.csv into INOUT folder


def MergeFiles():
    import calendar
    # When you start service, please use the second line below -> # year_month = '202105'
    year_month = input("Please enter month and year (YYYYMM): ")
    while True:
        if (len(year_month) == 6) or (year_month[:4] in range(1990, 2100)) or (year_month[:4] in range(1, 13)):
            break
        else:
            print("Please enter the right month and year (YYYYMM):")

    # extract year and month -> str
    year = year_month[:4]
    month = year_month[-2:]

    # get the last day of the input month
    last_day_of_month = calendar.monthrange(int(year), int(month))[-1]

    # Make the blank DF to append datas in the for loop below
    final_df = pd.DataFrame(columns=["Date", "In Time", "Out Time", "Token ID"])

    # for loop to extract, merge, append
    for i in range(last_day_of_month):
        try:
            day = i + 1
            if day < 10:
                day = str("0") + str(day)
            else:
                day = str(day)

            filename = year + month + day

            df1 = pd.read_csv('./INOUT/IN_{}.csv'.format(filename)).rename(columns={"Time": "In Time"})
            df2 = pd.read_csv("./INOUT/OT_{}.csv".format(filename)).rename(columns={"Time": "Out Time"})

            merged_df = pd.merge(df1, df2, on="Token ID")
            merged_df = merged_df[["Date_x", "In Time", "Out Time", "Token ID"]].rename(columns={"Date_x": "Date"})
            final_df = pd.concat([final_df, merged_df], ignore_index=True)

        except:
            pass

    # to calculate the Hrs and Mins columns using DATETIME, DATEDELTA
    InTime_Array = pd.to_datetime(final_df["Out Time"])
    OutTime_Array = pd.to_datetime(final_df["In Time"])
    time_diff = InTime_Array - OutTime_Array
    hours = [time_diff[i].seconds // 3600 for i in range(len(time_diff))]
    minutes = [(time_diff[i].seconds // 60) % 60 for i in range(len(time_diff))]

    # make new columns with the Series of hours and minues below
    final_df["Hrs"] = hours
    final_df["Mins"] = minutes

    # put out
    if final_df.empty:
        print("There is no data of {}".format(year + month))
    else:
        output_filename = "/MG_" + year + month + ".csv"
        final_df.to_csv("./INOUT/"+output_filename, index=False)


def OverTimeReport():
    Date = input("Please enter the date in DD-MM-YYYY: ")
    if (len(Date) != 10) or (Date.count("-") != 2):
        print("Please enter the date in the correct format in DD-MM-YYYY")
        OverTimeReport()
    else:
        reformated_date = Date[-4:] + "-" + Date[3:5] + "-" + Date[0:2]

        inputFilename = "./INOUT/MG_" + Date[6:10] + Date[3:5] + ".csv"
        print(inputFilename)
        df = pd.read_csv(inputFilename)
        df["Hrs numeric"] = pd.to_numeric(df["Hrs"])
        df["Mins numeric"] = pd.to_numeric(df["Mins"])

        reformated_date = str(reformated_date)
        date_filtered = df.loc[df["Date"] == reformated_date]
        date_filtered["Duration"] = (date_filtered.loc[:, "Hrs numeric"] * 60) + date_filtered.loc[:,"Mins numeric"]  # converting to numeric to do mathematical function


        minimum_duration = 555  # converting 9h15mins to 555mins
        nine_hours_in_mins = 540  # converting 9h into mins

        ot_mask= date_filtered["Duration"] >= minimum_duration
        people_who_ot = date_filtered.loc[ot_mask]  # locating people who OT


        newdf = pd.DataFrame()  # create new data frame
        newdf["TokenID"] = df["Token ID"]  # write new column for Token ID
        # empty
        people_who_ot["Work"] = people_who_ot["Hrs"].astype(str) + " Hours " + people_who_ot["Mins"].astype(
            str) + " Mins"  # converting back to string from numeric

        # empty
        people_who_ot["Overtime in mins"] = people_who_ot["Duration"] - nine_hours_in_mins

        employeeFilename = "employee.csv"
        dfEmployees = pd.read_csv("./INOUT/"+employeeFilename)



        people_who_ot = people_who_ot[["Token ID", "Work", "Overtime in mins"]]
        dfEmployees = dfEmployees[["EmployeeID", "Name", "TokenID"]]

        people_who_ot["TokenID"] = people_who_ot["Token ID"].astype("str")
        people_who_ot["Work"] = people_who_ot["Work"].astype("str")
        people_who_ot["Overtime in mins"] = people_who_ot["Overtime in mins"].astype("str")

        dfEmployees["Name"] = dfEmployees["Name"].astype("str")
        dfEmployees["EmployeeID"] = dfEmployees["EmployeeID"].astype("str")
        dfEmployees["TokenID"] = dfEmployees["TokenID"].astype("str")



        df_merged = pd.merge(left=people_who_ot, right=dfEmployees, how="inner", on="TokenID")
        print(df_merged.columns)

        merged_df = df_merged.drop(["TokenID"], 1)
        merged_df.to_csv("test_file_overtime")
        df_merge = merged_df.dropna(inplace=False)  # drop NAN
        df_merge = df_merge[["EmployeeID", "Name", "Work", "Overtime in mins"]]

        if df_merge.empty:
            print("No information available")  # allow user to know that there is no OT on that day
        else:
            df_merge = df_merge.to_string(index=False)
            print("Over Time List for:" + Date[-4: ] + "-" + Date[3:5] + "-" + Date[0:2])
            print(df_merge)


def AbsentReport():
    while True:
        Date = input("Please enter the date in DD-MM-YYYY: ")
        if Date.count('-') != 2 or len(Date.strip()) != 10:
            print("Please write the right format")
            continue
        else:
            break

    date_list = Date.split("-")
    date_list.reverse()
    date = "".join(date_list)
    # print(date)
    in_df = pd.read_csv('./INOUT/IN_{}.csv'.format(date))
    in_df = pd.DataFrame(in_df["Token ID"].astype("str"))


    employee_df = pd.read_csv("./INOUT/employee.csv").loc[:, ["EmployeeID", "Name", "TokenID"]]
    employee_df["EmployeeID"] = employee_df["EmployeeID"].astype("str")
    employee_df["Name"] = employee_df["Name"].astype("str")
    employee_df["TokenID"] = employee_df["TokenID"].astype("str")

    df_OUTER_JOIN = pd.merge(in_df, employee_df, left_on='Token ID', right_on='TokenID', how='outer')

    null_mask = df_OUTER_JOIN["Token ID"].isnull()
    absent = df_OUTER_JOIN[null_mask][["EmployeeID", "Name"]]
    print("Absent List For ".format("-".join(date_list)))
    print(absent[["EmployeeID", "Name"]].to_string(index=False))


main()