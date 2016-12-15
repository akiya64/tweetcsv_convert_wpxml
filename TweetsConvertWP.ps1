#Args
Param($StartDate, $EndDate, $TwitterUserName)

#Declaration Functions

# Slice CSV by day used by
Function Slice-Csv($Day) {

[string]$DayString = $Day.ToString("yyyy-MM-dd") + "*"

# Select by Column No.Cutoff header. And timstamp is string, so use "like" syntax
#./tweets.csv WHERE c4 LIKE `'$DayString%`' AND c6 NOT Like `'@%`'`""

$ResultWhere = Import-Csv './tweets.csv' | Where-Object {$_.timestamp -like $DayString -and $_.text -notlike '@*'} 

Return $ResultWhere

}

#create ul list
Function Build-List($Tweets){
    $TwLi = "<ul>"

    $Tweets | ForEach-Object{
    

        $TwText = $_.text

        # make permanent URI
        $TwUrL = "https://twitter.com/"+ $TwitterUserName +"/status/" + $_.tweet_id

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

[String]$c = (Import-Csv './tweets.csv').Count.tostring() + "  Tweets.`n`n"

echo $c

$StartDay = Get-Date -Date $StartDate
$EndDay = Get-Date -Date $EndDate


Set [String]REDIRECT_FILE_NAME "wp_import.html" -Option Constant

echo "Create wp_import.html. For import to WordPress"

echo '<wp:wxr_version>1.2</wp:wxr_version>`n' | Out-File wp_import.html -Encoding UTF8

for ($i = 0 ;  (New-TimeSpan ($StartDay.AddDays($i)) ($EndDay)).Days -cge 0 ; $i++){ 

    $Day = $StartDay.AddDays($i)

    $Sliced = Slice-Csv $Day

    If ($Sliced.Count -eq 0){ continue }

    $TwList = Build-List $Sliced
    
    $Item = Build-Itemnode $TwList $Day
    
    echo $Item | Out-File wp_import.html -Encoding UTF8 -Append

    $AppendingMess = "append " + $Day.Tostring("yyyy-MM-dd") + " Tweets."

    echo $AppendingMess
}

Echo "Completed."