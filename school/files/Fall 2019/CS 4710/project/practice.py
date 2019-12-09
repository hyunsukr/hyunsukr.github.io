import pandas as pd


string = 'MoWeFr'
list_days = []
if len(string) == 6:
    list_days.append(string[0:2])
    list_days.append(string[2:4])
    list_days.append(string[4:6])
print(list_days)