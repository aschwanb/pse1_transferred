require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MegaUltraTweet
  class Application < Rails::Application
    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # Autoload lib/ folder including all subdirectories
    config.autoload_paths += Dir["#{config.root}/lib/**/"]

    # Add fonts to the asset pipeline
    config.assets.paths << Rails.root.join("app", "assets", "fonts")

    # Rspec setup
    config.generators do |g|
      g.test_framework :rspec,
          :fixtures => true,
          :view_specs =>false,
          :helper_specs => false,
          :routing_specs => false,
          :controller_specs => true,
          :request_specs => true
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
    end

    # Config for custom error pages
    config.exceptions_app = self.routes

    # Global Variables
    # These values will be initiated as the first hashtags
    # They are always part of the first Startingpoint object
    DEFAULT_STARTING_VALUES = %w[ Technology Smartphone Phone Tablet Mobile Wireless PC TV Bluetooth WiFi Notebook Laptop Computer Web Electronics VR Watch Portable Processor Internet Robotics Drone CPU GSM LTE LCD Nano LED OLED HD Cmos Digital SLR DSLR Smart Screen Microphone Speaker ]
    # Only tweets since this date are taken into account when searching twitter
    TWEETS_SINCE_STRING = 2.days.ago.strftime("%Y-%m-%d")
    # Short rollover is performed every n minutes
    INTERVAL_SHORT_TIME = 15.minutes
    # Long rollover is performed every n days
    INTERVAL_LONG_TIME = 2.days
    # Popularity class returns times of usage of an object for this many short rollover entries
    # Time interval should be consistent with INTERVAL_SHORT_TIME
    POPULARITY_SHORT_INTERVAL = 1
    # Popularity class returns times of usage of an object for this many short rollover entries
    # Time interval should be consistent with INTERVAL_LONG_TIME
    POPULARITY_LONG_INTERVAL = 192
    # This many hashtags are included in the top/bottom statistic
    # used by the Trending object
    TRENDING_HASHTAGS_NUMBER = 20
    # This many hashtags are added to the Startingpoint object
    HASHTAG_TO_START_NUMBER = 30
    # Maximum number of hashtags in Startingpoint object
    HASHTAG_TO_START_MAX = 80
    # Recursive steps taken during search
    QUERY_DEPTH = 5
    # Number of hashtags to start a new query during search
    QUERY_DETAIL = 10
    # Get this many tweets from twitter for each search
    GET_THIS_MANY = 400
    # All tweets older than this are removed during rollover
    DELETE_OLDER_TWEETS = 3.days.ago
    # Search during rollover will stop after this many searches
    # Add some buffer for user input. Max searches provided by twitter is at 450
    PROVIDED_SEARCHES = 400
    # This is the limit as how many tweets in the DB are to be considered. Set to nil to disable.
    DB_SEARCH_LIMIT = 3000

  end
end
