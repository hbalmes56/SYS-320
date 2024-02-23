# Calling the function

$FullTable = gatherClasses

$FullTable = daysTranslator $FullTable

#$FullTable | Format-List

# List all the classes of Instructor Furkan Paligu
#$FullTable | Where-Object { $_.Instructor -eq "Furkan Paligu" }

# List all the classes of Joyce310 on Mondays, only Display class code and time
# Sort by start time
#$FullTable | Where-Object { ($_.Location -eq "JOYC 310") -and ($_.days -eq "Monday") } | `
#             Sort-Object "Time Start" | `
#             Select-Object "Time Start", "Time End", "Class Code"

# Make a list of all the instructors that teach at least 1 course in 
# SYS, SEC, NET, FOR, CSI, DAT
# Sort by name, and make it unique
#$ITSInstructors = $FullTable | Where-Object {
#                              ($_."Class Code" -like "SYS*") -or `
#                              ($_."Class Code" -like "SEC*") -or `
#                              ($_."Class Code" -like "NET*") -or `
#                              ($_."Class Code" -like "FOR*") -or `
#                              ($_."Class Code" -like "CSI*") -or `
#                              ($_."Class Code" -like "DAT*") } ` | Sort-Object "Instructor" -Unique `
#                               | Select-Object -ExpandProperty "Instructor"

#$ITSInstructors

# Group all of the instructors by the number of classes they are teaching
$FullTable | Where-Object { $_.Instructor -in $ITSInstructors } `
           | Group-Object "Instructor" | Select-Object Count,Name | Sort-Object Count -Descending