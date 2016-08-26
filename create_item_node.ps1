# 3. build single entry node as Plaintext
    
param($EntryText, [DateTime]$Date)

[String]$Item = "  <item>`n"

# Add WordPress Status node
$Item += "    <pubDate>" + $Date.AddDays(1).ToString("yyyy-MM-dd") + " 00:30:00 +0900</pubDate>`n"
$Item += "    <wp:post_date>" + $Date.AddDays(1).ToString("yyyy-MM-dd") + " 00:30:00</wp:post_date>`n"
$Item += "    <wp:post_type>post</wp:post_type>`n"
$Item += "    <wp:status>publish</wp:status>`n"
$Item += "    <category domain=`"category`" nicename=`"tweets`">Tweets</category>`n"

# Add Contents
$Item += "    <title>Twitter Updates for " + $Date.ToString("yyyy-MM-dd") + "</title>`n"
$Item += "    <content:encoded>" + $EntryText + "</content:encoded>`n"

# Close Item Node
$Item += "  </item>"