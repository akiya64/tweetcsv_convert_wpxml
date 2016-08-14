<#
create ul list from SQL result 
#>


<# Data set
                    id , text
ResultQ[0] = 1234567890, tweet 
ResultQ[1]   1234678099, tweet2
    :
#>

param([array] $TwArr)

$TwLi = "`r<ul>`r"

foreach($Row in $TwArr){
    
    $TwArr = $Row.Split(",")

    $TwText = $TwArr[1]

    # make permanent URI
    $TwUrL = "https://twitter.com/K_akiya/status/" + $TwArr[0]

$Tw = @"
    <li>$TwText <a href=`"$TwUrl`" target=`"_blank`">-></a></li>
"@

    $TwLi += "$tw`r"

}

$TwLi += "</ul>`r"