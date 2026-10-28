# download-jcmb-aws

One small script, `download_jcmb_aws.sh`, that downloads the daily weather station files from the geos.ed.ac.uk weather station page. The pressure data for the EM27 processing is made from these files.

## Using it

```
./download_jcmb_aws.sh -d 14 -o /path/to/output
```

- `-d` is how many days back to go, counting from today. The default is 1.
- `-o` is the folder to save to. It is created if it doesn't exist. The default is the current folder.
- `-u` is the url pattern, if the site ever moves. The default is the current one, with the date filled in.

Each day is saved as `YYYY-MM-DD_minute_data.csv`. If a download fails, the script says so and deletes the empty or partial file, so a missing file means the download didn't work.

## In the pipeline

`download_jcmb_wxt536_1540027.sh` in edatmo-automation runs this every night at 02:45 for the last 14 days, and the backfill script uses it for older dates. They find it through the WEATHER_DOWNLOAD_DIR setting in config.sh, so clone this repo into `$EDATMO_ROOT/git` and set that in `config.local.sh`.

Some days on the site are empty files. The pressure script can't make a pressure file for those days, so PROFFAST gets nothing for them.

If you can't open this repo, email sophierowen@outlook.com with your GitHub username.
