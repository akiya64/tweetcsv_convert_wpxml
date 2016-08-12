<#
q を使ったCSVの日別抽出
https://github.com/harelba/q

件数取得
q -d ',' "SELECT COUNT(*) FROM tweets"
特定IDの投稿本文取得
q -E sjis -d ',' "SELECT c6 FROM tweets WHERE c1='763551255906004992'"
#>
cd D:\

echo 行数カウント
echo "q -d `',`' `"SELECT COUNT(*) FROM tweets.`""

q -d ',' "SELECT COUNT(*) FROM tweets.csv"

echo `r

$StartDay =  Get-Date(Get-Date -Date 2009-07-03)
$EndDay = Get-Date(Get-Date -Date 2011-07-03)

for ($i = 10 ;  $i -lt 15 ; $i++){ 
    $Day = $StartDay.AddDays($i).ToString("yyyy-MM-dd")

    $Title = "Twitter Updates for " + $Day
    
    echo $Title

    $Query = "`"SELECT c1,c6 FROM tweets.csv WHERE c4 LIKE `'$day%`' AND c6 NOT Like `'@%`'`""

    $DaysTweet = q -d ',' $Query

    echo $DaysTweet
    echo "`r"

    Get-TypeData($DaysTweet)
        }