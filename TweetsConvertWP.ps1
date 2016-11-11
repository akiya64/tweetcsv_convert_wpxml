#Args
Param($StartDate, $EndDate)

#Declaration Functions

<#
Slice CSV by day used by "q" 
https://github.com/harelba/q

Example
Count record
q -d ',' "SELECT COUNT(*) FROM tweets"

Tweet text by Unique ID
q -E sjis -d ',' "SELECT c6 FROM tweets WHERE c1='763551255906004992'"
#>
Function Slice-Csv($Day) {

$DayString = $Day.ToString("yyyy-MM-dd")

# Select by Column No.Cutoff header. And timstamp is string, so use "like" syntax
$Query = "`"SELECT c1,c6 FROM ./tweets.csv WHERE c4 LIKE `'$DayString%`' AND c6 NOT Like `'@%`'`""

$ResultQ = q -d ',' $Query

return $ResultQ
}

#create ul list from SQL result 
Function Build-List($Tweets){
    <# Array Data set
                        id , text
    ResultQ[0] = 1234567890, tweet 
    ResultQ[1]   1234678099, tweet2
        :
    #>

    $TwLi = "<ul>"

    foreach($Row in $Tweets){
    
        $Tweets = $Row.Split(",")

        $TwText = $Tweets[1]

        # make permanent URI
        $TwUrL = "https://twitter.com/K_akiya/status/" + $Tweets[0]

$Tw = @"
<li>$TwText <a href=`"$TwUrl`" target=`"_blank`">-&gt;</a></li>
"@

        $TwLi += "$tw"

}

$TwLi += "</ul>"

return $TwLi
}

# build single entry node as Plaintext
Function Build-Itemnode($EntryText ,[DateTime]$Day){

    [String]$Item = "  <item>`n"

    # Add WordPress Status node
    $Item += "    <pubDate>" + $Day.AddDays(1).ToString("yyyy-MM-dd") + " 00:30:00 +0900</pubDate>`n"
    $Item += "    <wp:post_date>" + $Day.AddDays(1).ToString("yyyy-MM-dd") + " 00:30:00</wp:post_date>`n"
    $Item += "    <wp:post_type>post</wp:post_type>`n"
    $Item += "    <wp:status>publish</wp:status>`n"
    $Item += "    <category domain=`"category`" nicename=`"tweets`">Tweets</category>`n"

    # Add Contents
    $Item += "    <title>Twitter Updates for " + $Day.ToString("yyyy-MM-dd") + "</title>`n"
    $Item += "    <content:encoded>" + $EntryText + "</content:encoded>`n"

    # Close Item Node
    $Item += "  </item>"

    return $Item
}


#Main

#set path & set WPS use UTF-8

chcp 65001

$ThisPath = Split-Path $MyInvocation.MyCommand.Path -parent
Set-Location $ThisPath


echo "Get Records Count ..."

$c = q -d ',' "SELECT COUNT(*) FROM tweets.csv"

echo "$c Tweets."`r`r

$StartDay = Get-Date -Date $StartDate
$EndDay = Get-Date -Date $EndDate


Set [String]REDIRECT_FILE_NAME "wp_import.html" -Option Constant

echo "Create wp_import.html. For import to WordPress"

echo '<wp:wxr_version>1.2</wp:wxr_version>`n' | Out-File wp_import.html -Encoding UTF8

for ($i = 0 ;  (New-TimeSpan ($StartDay.AddDays($i)) ($EndDay)).Days -cge 0 ; $i++){ 

    $Day = $StartDay.AddDays($i)

    $Sliced = Slice-Csv($Day)

    If ($Sliced.Count -eq 0){ continue }

    $TwList = Build-List $Sliced
    
    $Item = Build-Itemnode $TwList $Day
    
    echo $Item | Out-File wp_import.html -Encoding UTF8 -Append

    $AppendingMess = "append " + $Day.Tostring("yyyy-MM-dd") + " Tweets."

    echo $AppendingMess
}

Echo "Completed."