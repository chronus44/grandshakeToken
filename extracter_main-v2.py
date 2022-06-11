##############################
#GrandShake Extractor Script
#Author - Neeraj Nair
#Version 1.0
##############################


#Import the required libs for this script.
import gspread
from oauth2client.service_account import ServiceAccountCredentials
from pprint import pprint
from datetime import datetime
import datetime as dt
import random

## This part handles the access to the Google Sheet
scope = ["https://spreadsheets.google.com/feeds",'https://www.googleapis.com/auth/spreadsheets',"https://www.googleapis.com/auth/drive.file","https://www.googleapis.com/auth/drive"]
creds = ServiceAccountCredentials.from_json_keyfile_name("/root/node/genesisfiles/files/test-project-1-349705-bf9bfec03f61.json", scope)
client = gspread.authorize(creds)

## Here we point to the worksheets that we need
firstSheet = client.open("Algo Grandshake database").worksheet('Sheet1')
secondSheet = client.open("Algo Grandshake database").worksheet('Sheet2')

#This part acts as the timekeeper for the time this script was last run.
txt_file = open("/root/node/genesisfiles/files/timekeeper.txt", "r")
last_run_1 = txt_file.read()
last_run = last_run_1.strip()
last_check = datetime.strptime(last_run,"%m/%d/%Y %H:%M:%S")
print("Last Checked at - ", last_check.strftime("%m/%d/%Y %H:%M:%S")) #This line can be removed

# This part is just to retrieve the current time
now = dt.datetime.now()
current_time = now.strftime('%m/%d/%Y %H:%M:%S')
print("Current Time - ", current_time) #This line can be removed


# #This part handles the generation of the token assignment request 
for i in secondSheet.col_values(4)[1:]:
    current_value = datetime.strptime(i, '%m/%d/%Y %H:%M:%S')
    if last_check < current_value :
        cell = str(secondSheet.find(str(i)))
        location = cell.split(' ')[1]
        cellCord = location.split('R')[1].split('C')[0]
        enrollId = str(secondSheet.cell(cellCord, 1).value)
        job_id = random.randint(0,100000)
        filename = (f'txn_req_job_{job_id}.txt')
        recorder = str(enrollId) + "-5-" + str(job_id)
        with open(f'{filename}', 'w') as f:
            f.writelines(recorder)


#This part updates the timekeeper file so that the last_checked value can be updated
txt_file = open("timekeeper.txt", "w")
txt_file.write(current_time)

### End of Script Processing.