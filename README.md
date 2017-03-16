# Tweets CSV convert html for import WordPress

Windows PowerShell script that Summarized Tweets CSV by day,
And convert to HTML for WordPress import.

### Prepare
Tweets.csv download from [your Twitter account](https://twitter.com/settings/account).  
Put Tweets.csv and TweetConvertWP.ps1 same folder.

### Args
StartDate : yyyy-MM-dd
EndDate : yyyy-MM-dd
TwitterUserName : ScreenName inclue URL

### Example

```
TweetsConvertWP.ps1 -StartDate 2011-07-11 -EndDate 2011-10-25 -TwitterUserName K_akiya
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
  <li>Tweets1 <a href ="Twitter unique URL" target="_blank">-></a></li>
  <li>Tweets2 <a href ="Twitter unique URL" target="_blank">-></a></li>
</ul>
```

Without Reply tweet.
Sort time acsend.
