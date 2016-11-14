# Tweets CSV convert html for import WordPress

Windows PowerShell script that Summarized Tweets CSV by day,
And convert to HTML for WordPress import.


### Require

Execute SQL for CSV Tool "[q](https://github.com/harelba/q)"

### Prepare
1. Install "[q](https://github.com/harelba/q)"
1. Cut-off CSV header.
2. Put same folder CSV and TweetsConvertWP.ps1 script.

### Args
StartDate : yyyy-MM-dd
EndDate : yyyy-MM-dd

### Example

```
TweetsConvertWP.ps1 -StartDay 2011-07-11 -EndDay 2011-10-25
```

Output wp_import.html in Same folder

### Import HTML
You can import by WordPress "import".

WordPress Post
* Category : Tweets
* Title : Tweets Update yyyy-MM-dd
* Author : Current Login Author
* Publish Date : 01:00 The Day after Tweets Summarized day.

#### Content 

```
<ul>
  <li>Tweets1 <a href ="Twitter unique URL" target="_blank"> -></a></li>
  <li>Tweets2 <a href ="Twitter unique URL" target="_blank"> -></a></li>
</ul>
```

Without Reply tweet.
