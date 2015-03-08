class IndexController < ApplicationController

  def start
  end

  def search
  end

  def hashtag
  end

  def twitterHandle
  end

  def twitterUser
  end

  def about
  end
end

require 'rubygems'
require 'twitter'
require 'uri'

# Client needs to be authenticated in order to access twitter api
client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "tTrNPGMT8S1d3qK3LMlnZV1XP"
  config.consumer_secret     = "olUHmGtYlh6dx3ztWqa6ExLLek7Vb76vGEi5p5BMd2LiFWWHPD"
  config.access_token        = "3062227378-HaWeilWyykpsDQvwZmaGUUSHDmlOFlHxpHpC9RY"
  config.access_token_secret = "etP0a6eCI0q1FwfMJYUO0VsTWyrhbYKRvuvUS8YKH2kC3"
end
