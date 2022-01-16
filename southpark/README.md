# SouthParkData

All-seasons.csv.gz was obtained from https://github.com/BobAdamsEE/SouthParkData. It contains the script information including: season, episode, character, and line. It was captured by downloading html files from http://southpark.wikia.com/wiki/Portal:Scripts and then pulling the relevant data from the script table.  Some manual clean up has been done (ex. fixing typos and formatting issues).

South Park characters use a lot of profanity in their speech. All-seasons-clean.csv.gz was created by using the `gsub()` function in R to replace dozens of cuss words with the word "BLEEP".