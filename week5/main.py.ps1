.  C:\Users\champuser\SYS320-01\week5\webscrape.ps1

#daysTranslator(gatherClasses) | 
    #Select-Object "Class Code", Instructor, Location, Days, "Time Start", "Time End" | 
    #Where-Object {$_.Instructor -ilike "*Furkan*"}


$FullTable = daysTranslator(gatherClasses)

#$FullTable | Where-Object {($_.Location -ilike "FREE 105") -and ($_.Days -ilike "Wednesday") } | 
 #   Sort-Object "Time Start" |
  #  Select-Object "Time Start", "Time End", "Class Code"


$ITSInstructors = $FullTable | Where-Object {($_."Class Code" -ilike "SYS*") -or 
                                             ($_."Class Code" -ilike "NET*") -or
                                             ($_."Class Code" -ilike "SEC*") -or
                                             ($_."Class Code" -ilike "FOR*") -or
                                             ($_."Class Code" -ilike "CSI*") -or
                                             ($_."Class Code" -ilike "DAT*")} |
                                             Select-Object "Instructor" -Unique |
                                             Sort-Object "Instructor"

# $ITSInstructors

$FullTable | Where {$_.Instructor -in $ITSInstructors.Instructor } | Group "Instructor" | Select Count,Name | Sort-Object Count -Descending
    