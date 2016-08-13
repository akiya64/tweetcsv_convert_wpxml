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

Set-Location (Split-Path $MyInvocation.MyCommand.Path -parent)

echo "Get Records Count ..."

$c = q -d ',' "SELECT COUNT(*) FROM tweets.csv"

echo "$c Tweets."`r`r


$StartDay =  Get-Date(Get-Date -Date 2009-07-01)
$EndDay = Get-Date(Get-Date -Date 2011-07-03)

#1. new xml object
$WpXml = New-Object System.Xml.XmlDocument
$WpXml.CreateXmlDeclaration("1.0","UTF-8","no")

$Channel = $WpXml.CreateElement( 'channel' )
$WpXml.AppendChild($Channel)

for ($i = 0 ;  $i -lt 3 ; $i++){ 

    $Day = $StartDay.AddDays($i).ToString("yyyy-MM-dd")

    #2. get post entry = ul list include tweets.

    #include tweets_slice.ps1
    . .\tweets_slice.ps1 $Day

    If ($ResultQ.Count -eq 0){ continue }

    $PostEntry = . .\build_list.ps1 $ResultQ

    # 3. build single entry node
    # 3.1 Title Node
    $Item = $WpXml.CreateElement( 'item' )

    $Title = $WpXml.CreateElement( 'title' )
    $Item.AppendChild($Title)

    $Title.InnerText = "Twitter Updates for " + $Day

    # 3.2Content Node
    $Content = $WpXml.CreateCDataSection( 'content:encoded' )
    $Content.Data = $PostEntry

    $Item.AppendChild($Content)

    $Channel.AppendChild($Item)

    #$item.InsertAfter($Contet,$Title)

    #4. add node to xml template

}

$WpXml.Save('D:\wp.xml')