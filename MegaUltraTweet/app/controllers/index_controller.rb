require 'rubygems'
require 'twitter'
require 'uri'

class IndexController < ApplicationController

  def start
  end

  def search
    @topics = TopicsStart.new.getTopics
  end

  def finde
    @query = params[:query]
    if !@query.blank?
      twitterClient = TwitterClient.new(10, @query)
      @tweets = twitterClient.getTweets
      @countsHashtags = twitterClient.getHashtags
      @countsTwitterHandles = twitterClient.getTwitterHandles
      @countsWebpages = twitterClient.getURLs
    end
  end

  def about
  end
end



