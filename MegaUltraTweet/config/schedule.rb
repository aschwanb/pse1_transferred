# Update crontab: "whenever --update-crontab MegaUltraTweet"
# Check crontab: "crontab -l"

# define environment
root = File.expand_path(File.dirname(File.dirname(__FILE__)))
set :environment, "development"
set :output, "%s/tmp/cron.log" % [ root ]


# Define cron jobs
every 15.minutes do
  command '/usr/bin/date'
  command '/usr/bin/echo "Running cron job for TwitterScraper"'
  runner 's = Startingpoint.first; r = DBRollover.new; r.rollover'
end
