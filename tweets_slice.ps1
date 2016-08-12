<#
Slice CSV by day used by "q" 
https://github.com/harelba/q

Example
Count record
q -d ',' "SELECT COUNT(*) FROM tweets"

Tweet text by Unique ID
q -E sjis -d ',' "SELECT c6 FROM tweets WHERE c1='763551255906004992'"
#>

Set-Location (Split-Path $MyInvocation.MyCommand.Path -parent)

echo "Get Records Count ..."

$c = q -d ',' "SELECT COUNT(*) FROM tweets.csv"

echo "$c Tweets."`r`r

$StartDay =  Get-Date(Get-Date -Date 2009-07-03)
$EndDay = Get-Date(Get-Date -Date 2011-07-03)

for ($i = 10 ;  $i -lt 15 ; $i++){ 
    $Day = $StartDay.AddDays($i).ToString("yyyy-MM-dd")

    $Title = "Twitter Updates for " + $Day
    
    echo $Title

    # Select by Column No.Cutoff header. And timstamp is string, so use "like" syntax
    $Query = "`"SELECT c1,c6 FROM ./tweets.csv WHERE c4 LIKE `'$day%`' AND c6 NOT Like `'@%`'`""

    $DaysTweet = q -d ',' $Query

    echo $DaysTweet
    echo `r

    Get-TypeData($DaysTweet)
        }