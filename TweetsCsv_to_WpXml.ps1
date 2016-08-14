<#
Args 
    Required ---currently hard coding
    StartDay
    EndDay
    Twitter ScreenName

    optional
    Month / Day Switch
    Author
    Category slug

Post meta 
    1. publish date ... tweet +1 day AM 00:00
    2. author ... empty is allowed
    3. post-entry ... ul> li> "tweet text"
    4. category ... tweet
#>

#0. Check file exist And execute q 

$ThisPath = Split-Path $MyInvocation.MyCommand.Path -parent
Set-Location $ThisPath

echo "Get Records Count ..."

$c = q -d ',' "SELECT COUNT(*) FROM tweets.csv"

echo "$c Tweets."`r`r


$StartDay =  Get-Date -Date 2009-07-02
$EndDay = Get-Date -Date 2009-07-04

#1. new xml object
$WpXml = New-Object System.Xml.XmlDocument
[void]$WpXml.CreateXmlDeclaration("1.0","UTF-8","no")

$Channel = $WpXml.CreateElement( 'channel' )
[void]$WpXml.AppendChild($Channel)

for ($i = 0 ;  (New-TimeSpan ($StartDay.AddDays($i)) ($EndDay)).Days -cge 0 ; $i++){ 

    $Day = $StartDay.AddDays($i).ToString("yyyy-MM-dd")

    #include tweets_slice.ps1
    . .\tweets_slice.ps1 $Day

    If ($ResultQ.Count -eq 0){ continue }

    . .\build_list.ps1 $ResultQ
    
    . .\create_item_node.ps1 $TwLi $Day
    
    #4. add node to xml template
    [void]$Channel.AppendChild($Item)

    echo "append $day Tweets."

}

$WpXml.Save($ThisPath + "\wp.xml")