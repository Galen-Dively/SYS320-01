function gatherClasses(){
    $page = Invoke-WebRequest -TimeoutSec 2 "http://127.0.0.1/Courses2026SP.html"
    $trs = $page.ParsedHTML.body.getElementsByTagName("tr")

    $FullTable = @()
    for($i=1; $i -lt $trs.length; $i++){
        $tds = $trs[$i].getElementsByTagName("td")
        $times = $tds[5].innerText.split("-")

        $FullTable += [pscustomobject]@{"Class Code" = $tds[0].innerText;
                                        "Title" = $tds[1].innerText;
                                         "Days" = $tds[4].innerText;
                                         "Time Start" = $times[0];
                                         "Time End" = $times[1];
                                         "Instructor" = $tds[6].innerText;
                                         "Location" = $tds[9].innerText;
                                         }

  
    }
  return $FullTable
}


function daysTranslator($FullTable){
    for($i=0; $i -lt $FullTable.length; $i++){

        $Days = @()

        if ($FullTable[$i].Days -ilike "M*") {$Days += "Monday"}
        if($FullTable[$i].Days -ilike "*[TWF]*") {$Days += "Tuesday"}
        elseif($FullTable[$i].Days -ilike "T") {$Days += "Tuesday"}
        if($FullTable[$i].Days -ilike "W") {$Days += "Wednesday"}
        if($FullTable[$i].Days -ilike "*TH*") {$Days += "Thursday"}
        if($FullTable[$i].Days -ilike "*F") {$Days += "Friday"}

        $FullTable[$i].Days = $Days

    }
    return $FullTable
}
