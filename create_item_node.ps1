# 3. build single entry node
    
param($EntryText, [DateTime]$Date)

$Item = $WpXml.CreateElement( 'item' )

$Title = $WpXml.CreateElement( 'title' )
[void]$Item.AppendChild($Title)

$Title.InnerText = "Twitter Updates for " + $Date.ToString("yyyy-MM-dd")

$PubDate = $WpXml.CreateElement( 'pubDate' )
[void]$Item.AppendChild( $PubDate )

$PubDate.InnerText = Get-date -Date $Date.AddDays(1) -Format "f"

$Content = $WpXml.CreateCDataSection( 'content:encoded' )
$Content.Data = $EntryText

[void]$Item.AppendChild($Content)
