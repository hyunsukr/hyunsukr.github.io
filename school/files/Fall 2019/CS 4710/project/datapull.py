import requests
import pandas as pd
import numpy as np
import os
import sys
# url = sys.argv[1]
res = requests.get('https://rabi.phys.virginia.edu/mySIS/CS2/page.php?Semester=1202&Type=Group&Group=CompSci')

html_output = res.text
array = html_output.split("<td class='CourseNum'>")
classnum = []
professor = []
days = []
start_time = []
end_time = []
credit = []
class_types = []
for classes in array:
    testing = classes.split("<tr class='Section")[2::]
    for entry in testing:
        print("*****")
        if "Title" in entry or "Topic" in entry:
            continue
        else:
            temp_class_num = entry.split(" ")[2].split("'")[0]
            # print("Class: ", temp_class_num)
            classnum.append(temp_class_num)
            if 'AUTOSTATUS, WRAP);" onmouseout="nd();">+1</span>' in entry:
                # <span class="InRed" onmouseover="return overlib('Instructors: Mike Ferguson, Rich Nguyen',AUTOSTATUS, WRAP);" onmouseout="nd();">+1</span>
                # print(entry.split("<span class='InRed'")[1].split('onmouseover="return overlib(')[1].split("',AUTOSTATUS, WRAP);")[0].split(' ')[1::])
                instructor_many = entry.split("<span class='InRed'")[1].split('onmouseover="return overlib(')[1].split("',AUTOSTATUS, WRAP);")[0].split(' ')[1::]
                instructor_string = instructor_many[0] + ' ' + instructor_many[1] + ' & ' + instructor_many[2] + ' ' + instructor_many[3]
                # print("Professor: ", instructor_string)
                professor.append(instructor_string)
            else:
                instructor_string = entry.split('<span onclick="InstructorTip(')[1].split("');")[0].replace("'","")
                # print("Professor: ", entry.split('<span onclick="InstructorTip(')[1].split("');")[0].replace("'",""))
                professor.append(instructor_string)
            
            creditnumber = entry.split("Units)")[0].split("</strong> (")[1]
            class_type = entry.split("Units)")[0].split("<td><strong>")[1].split("</strong>")[0]
            class_types.append(class_type)
            credit.append(creditnumber)
            temp = entry.split(',AUTOSTATUS, WRAP);" onmouseout="nd();">')
            class_info = temp[len(temp) - 1]
            specifics = class_info.split("</td>")[0].split(" ")
            if specifics == ["TBA"]:
                # print("Days: ", "TBA")
                # print("start_time: ", "TBA")
                # print("End: ", "TBA")
                days.append(["TBA"])
                start_time.append("TBA")
                end_time.append("TBA")
            else:
                days_temp = specifics[0]
                start_temp_time = specifics[1]
                end_temp_time = specifics[3]
                # print("Days: ", days_temp)
                # print("start_time: ",start_temp_time)
                # print("End: ", end_temp_time)
                # print(len(days_temp))
                day_list = []
                if len(days_temp) == 2:
                    print(days_temp)
                    day_list.append(days_temp)
                if len(days_temp) == 4:
                    day_list.append(days_temp[0:2])
                    day_list.append(days_temp[2:4])
                if len(days_temp) == 6:
                    day_list.append(days_temp[0:2])
                    day_list.append(days_temp[2:4])
                    day_list.append(days_temp[4:6])
                days.append(days_temp)
                start_time.append(start_temp_time)
                end_time.append(end_temp_time)
            # print("Credits: ", creditnumber)

data = {'Course Number':classnum, 'Professor':professor, 'Meeting Days': days, 'Start Time': start_time, 'End Time':end_time, 'Credits':credit, 'Class Type': class_types} 
# Create DataFrame 
df = pd.DataFrame(data) 
df = df[pd.Series(data["Start Time"]) != 'TBA']
df = df[df["Course Number"].str.contains('CS6') == False]
df = df[df["Course Number"].str.contains('CS7') == False]
df = df[df["Course Number"].str.contains('CS8') == False]
df = df[df["Course Number"].str.contains('CS9') == False]


org_time = df["Start Time"]
end_org_tim = df["End Time"]

new_time = []
for time in org_time:
    hours = int(time.split(":")[0])
    left_min = int(time.split(":")[1][0:2])
    minutes = hours * 60 + left_min
    if 'pm' in time:
        minutes = minutes + (12*60)
    new_time.append(minutes)

new_end_time = []
for time in end_org_tim:
    hours = int(time.split(":")[0])
    left_min = int(time.split(":")[1][0:2])
    minutes = hours * 60 + left_min
    if 'pm' in time:
        minutes = minutes + (12*60) 
    new_end_time.append(minutes)

df["Start Time"] = new_time 
df["End Time"] = new_end_time
cwd = os.getcwd()
df = df.sort_values(by=["Meeting Days",'Start Time'])

export_csv = df.to_csv (cwd + "/data/full.csv", index = True, header=True) #Don't forget to add '.csv' at the end of the path
# Print the output. 
# print(df)
print(len(df))

# dict_prereq = {
#     'CS2102': ['CS111x'],
#     'CS2110': ['CS111x'],
#     'CS2150': ['CS2110', 'CS2102']
#     'CS1501' : ['CS111x'],
#     'etc' : ['CS2150']
# }

# dict_haslab = ['CS1110', 'CS2110', 'CS2150', 'CS3240', 'CS3330', 'CS4730']

