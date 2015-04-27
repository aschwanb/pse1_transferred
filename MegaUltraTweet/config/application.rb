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

    # Global Variables
    DEFAULT_STARTING_VALUES = %w[ Technology Smartphone Phone Tablet Mobile Wireless PC TV Bluetooth WiFi Notebook Laptop Computer Web Electronics VR Watch Portable Processor Internet Robotics Drone CPU GSM LTE LCD Nano LED OLED HD Cmos Digital SLR DSLR Smart Screen Microphone Speaker ]
    POPULARITY_SHORT_INTERVAL = 1
    POPULARITY_LONG_INTERVAL = 50
    TRENDING_HASHTAGS_NUMBER = 20
    HASHTAG_TO_START_NUMBER = 30
    QUERY_DEPTH = 5
    QUERY_DETAIL = 10
    GET_THIS_MANY = 400
    DELETE_OLDER_TWEETS = 3.days.ago
    PROVIDED_SEARCHES = 400 # Add some buffer for user input. Max searches is at 450

  end
end
