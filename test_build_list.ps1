<#
test
#>

$StartDay =  Get-Date(Get-Date -Date 2009-07-03)
$EndDay = Get-Date(Get-Date -Date 2011-07-03)

$Day = $StartDay.AddDays(7).ToString("yyyy-MM-dd")
    
echo $Day
    
$Title = "Twitter Updates for " + $Day
    
$ResultQ = q -d ',' "`"SELECT c1,c6 FROM tweets.csv WHERE c4 LIKE `'$day%`' AND c6 NOT Like `'@%`'`""

foreach($Row in $ResultQ){
    
    $TwArr = $Row.Split(",")

    $TwText = $TwArr[1]
    $TwUrL = "https://twitter.com/K_akiya/status/" + $TwArr[0]

$Tw = @"
<li>$TwText <a href=`"$TwUrl`" target=`"_blank`">-></a></li>
"@

    echo $Tw

}