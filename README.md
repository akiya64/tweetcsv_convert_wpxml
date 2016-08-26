# Tweets CSV convert html for import WordPres

Windows PowerShell script that Summarized Tweets CSV by day,    
And convert to HTML for WordPress import.


### Require

Execute SQL to CSV Tool [q](https://github.com/harelba/q)

### Prepare
Cut-off CSV header.

### Args
StartDate/EndDate format 2015-08-01

### Example

```
TweetsCsv_to_WpXml.ps1 -StartDay 2011-07-11 -EndDay 2011-10-25
```

### Import HTML
* Category : Tweets  
* Author : Current Login Author  
* Publish Date : 01:00 The Day after Tweets Summarized day.
