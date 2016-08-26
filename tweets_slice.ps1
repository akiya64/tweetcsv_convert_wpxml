<#
Slice CSV by day used by "q" 
https://github.com/harelba/q

Example
Count record
q -d ',' "SELECT COUNT(*) FROM tweets"

Tweet text by Unique ID
q -E sjis -d ',' "SELECT c6 FROM tweets WHERE c1='763551255906004992'"
#>

Param($Day)

$DayString = $Day.ToString("yyyy-MM-dd")

Set-Location (Split-Path $MyInvocation.MyCommand.Path -parent)

# Select by Column No.Cutoff header. And timstamp is string, so use "like" syntax
$Query = "`"SELECT c1,c6 FROM ./tweets.csv WHERE c4 LIKE `'$DayString%`' AND c6 NOT Like `'@%`'`""

$ResultQ = q -d ',' $Query