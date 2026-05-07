import sqlite3
import pandas as pd
import requests
import json
import numpy as np

url = "https://api.github.com/repos/CSSEGISandData/COVID-19/contents/csse_covid_19_data/csse_covid_19_daily_reports"
list_downloaded_files = []
url_Data = requests.get(url)
for data in url_Data.json():
    if data['name'].endswith(".csv"):
         list_downloaded_files.append(data['download_url'])

#Data Transformation
#Changing the column names for better readablity
reframing_columns = {
'Country/Region': 'Country_Region',
'Province/State': 'Province_State'
}
def transform_data_frame(df):
    #remaining labels
    for label in df:
        if label in reframing_columns:
            df = df.rename(columns = {label: reframing_columns[label]})
     ## desired column names
    column_labels = ['Country_Region', 'Province_State', 'Confirmed', 'Deaths', 'Recovered', 'Active', 'Incident_Rate', 'Case_Fatality_Ratio']
    for label in column_labels:
        if label not in df:
            df[label] = np.nan
    return df[column_labels]

# Load the data
def load_to_database( filenames, db_name):
    # make connection to database
    connection = sqlite3.connect(db_name)
    # enumerate over each url to index them
    for i , filename in list(enumerate(filenames)):
        read_each_url = pd.read_csv(filename)
        data_to_upload = transform_data_frame(read_each_url)
        #for the first url replace if it exists
        if i ==0 :
            data_to_upload.to_sql(db_name, connection, if_exists='replace', index=False)
        else :
            data_to_upload.to_sql(db_name, connection, if_exists = 'append', index=False)
#call the function to load data to sqlite
load_to_database(list_downloaded_files, 'test_db')




