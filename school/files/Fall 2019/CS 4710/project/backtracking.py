import pandas as pd
import sys

input_class = input("Please enter the courses you have taken : ")
if input_class == '':
    input_class = '0'

classes_taken = input_class.split(',')
highest_class = max(classes_taken)

set_haslab = set(['CS1110', 'CS2110', 'CS2150', 'CS3240', 'CS3330', 'CS4730'])

df = pd.read_csv('data.csv')

def split_twos(line):
    return [line[i:i+2] for i in range(0, len(line), 2)]

def build_lists():
    courses = []
    labs = []
    for i in range(0,len(df)):
        if (not df.iloc[i]['Course Number'][2:] in classes_taken and int(highest_class) >= 2150):
            if int(df.iloc[i]['Course Number'][2:]) > 2150:
                tuple = (df.iloc[i]['Course Number'], split_twos(df.iloc[i]["Meeting Days"]), df.iloc[i]["Start Time"], df.iloc[i]["End Time"], df.iloc[i]["Credits"])
                if df.iloc[i]['Class Type'] == 'Lecture':
                    courses.append(tuple)
                else:
                    labs.append(tuple)
        elif (not df.iloc[i]['Course Number'][2:] in classes_taken and int(highest_class) <= 2150):
            if int(df.iloc[i]['Course Number'][2:]) > int(highest_class) and int(df.iloc[i]['Course Number'][2:]) <= 2150 and abs(int(df.iloc[i]['Course Number'][2:]) - int(highest_class)) > 2:
                tuple = (df.iloc[i]['Course Number'], split_twos(df.iloc[i]["Meeting Days"]), df.iloc[i]["Start Time"], df.iloc[i]["End Time"], df.iloc[i]["Credits"])
                if df.iloc[i]['Class Type'] == 'Lecture':
                    courses.append(tuple)
                else:
                    labs.append(tuple)
    return courses, labs

def backtracking_search(courses):
    return recursive_backtracking([], courses)

def recursive_backtracking(assignment, courses):
    global max_credits
    global max_assignment

    num_of_credits = num_credits(assignment)
    if num_of_credits >= 15:
        return "Pass"

    if num_of_credits > max_credits:
        max_credits = num_of_credits
        max_assignment = assignment

    for course in courses:
        if not has_course_number(course, assignment) and not has_time_overlap(course, assignment):
            if course[0] in set_haslab:
                lab_added = False
                assignment.append(course)
                for labs in valid_labs:
                    if labs[0] == course[0] and not has_time_overlap(labs, assignment):
                        lab_added = True
                        assignment.append(labs)
                        break
                if not lab_added:
                    assignment.pop()
            else:
                assignment.append(course)

            result = recursive_backtracking(assignment, courses)

            if result != 'Fail':
                return result

            assignment.pop()
    return 'Fail'


# assignment = list(class number, start time, end time, credit hours)
def num_credits(assignment):
    credit_hours = 0
    for course in assignment:
        credit_hours += course[4]

    return credit_hours

def has_course_number(course, assignment):
    for assigned in assignment:
        if assigned[0] == course[0]:
            return True

    return False

def has_time_overlap(course, assignment):
    for assigned in assignment:
        for day in assigned[1]:
            if day in course[1]:
                # after the assigned start time and before the assigned end time
                if course[3] >= assigned[2] and course[3] <= assigned[3]:
                    return True
                if course[2] >= assigned[2] and course[2] <= assigned[3]:
                    return True

    return False

# --------------------------------------------------------

valid_courses, valid_labs = build_lists()

max_credits = 0
max_assignment = []

answer = backtracking_search(valid_courses)

if answer == 'Pass':
    print("Found 15 credits of CS courses")
else:
    print("Didn't find 15 credits of CS courses")

# print(max_assignment)
final_list = []
for course in max_assignment:
    hours = int(course[2] / 60)
    hours_end = int(course[3] / 60)
    minutes = course[2] % 60
    minutes_end = course[3] % 60
    if minutes_end < 10:
        minutes_end = '0' + str(minutes_end)
    if minutes < 10:
        minutes = '0' + str(minutes)
    if hours > 12:
        time = str(hours - 12) + ':' + str(minutes) + 'pm'
        time_end = str(hours_end - 12) + ':' + str(minutes_end) + 'pm'
    else:
        time = str(hours) + ':' + str(minutes) + 'am'
        time_end = str(hours_end) + ':' + str(minutes_end) + 'am'
    classes = (course[0], course[1], time, time_end, course[4])
    final_list.append(classes)
print('----------------------------------------------------------')
df_final = pd.DataFrame(final_list)
df_final.columns = ['Course Number', 'Meeting Days', 'Start Time', 'End Time', 'Credits']
print(df_final.sort_values(by=['Start Time']))
# print(backtracking_search(valid_courses))
