<#
Args 
    StartDay
    EndDay

#>

Param($StartDate, $EndDate) 

#0. set path & set WPS use UTF-8

chcp 65001

$ThisPath = Split-Path $MyInvocation.MyCommand.Path -parent
Set-Location $ThisPath


echo "Get Records Count ..."

$c = q -d ',' "SELECT COUNT(*) FROM tweets.csv"

echo "$c Tweets."`r`r

$StartDay = Get-Date -Date $StartDate
$EndDay = Get-Date -Date $EndDate

#1. new xml object
#. .\prepare_wp_xml.ps1

Set [String]REDIRECT_FILE_NAME "wp_import.html" -Option Constant


echo "Create wp_import.html. For import to WordPress"

echo '<wp:wxr_version>1.2</wp:wxr_version>`n' | Out-File wp_import.html -Encoding UTF8

for ($i = 0 ;  (New-TimeSpan ($StartDay.AddDays($i)) ($EndDay)).Days -cge 0 ; $i++){ 

    $Day = $StartDay.AddDays($i)

    #include tweets_slice.ps1
    . .\tweets_slice.ps1 $Day

    If ($ResultQ.Count -eq 0){ continue }

    . .\build_list.ps1 $ResultQ
    
    . .\create_item_node.ps1 $TwLi $Day
    
    echo $Item | Out-File wp_import.html -Encoding UTF8 -Append

    $AppendingMess = "append " + $Day.Tostring("yyyy-MM-dd") + " Tweets."

    echo $AppendingMess
}

Echo "Completed."