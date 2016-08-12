<#
trial create ul list from SQL result 
#>

$StartDay =  Get-Date(Get-Date -Date 2009-07-03)
$EndDay = Get-Date(Get-Date -Date 2011-07-03)

$Day = $StartDay.AddDays(7).ToString("yyyy-MM-dd")
    
echo $Day
    
$Title = "Twitter Updates for " + $Day

$ResultQ = q -d ',' "`"SELECT c1,c6 FROM tweets.csv WHERE c4 LIKE `'$day%`' AND c6 NOT Like `'@%`'`""

<# Data set
                    id , text
ResultQ[0] = 1234567890, tweet 
ResultQ[1]   1234678099, tweet2
    :
#>

foreach($Row in $ResultQ){
    
    $TwArr = $Row.Split(",")

    $TwText = $TwArr[1]

    # make permanent URI
    $TwUrL = "https://twitter.com/K_akiya/status/" + $TwArr[0]

$Tw = @"
<li>$TwText <a href=`"$TwUrl`" target=`"_blank`">-></a></li>
"@

    echo $Tw

}