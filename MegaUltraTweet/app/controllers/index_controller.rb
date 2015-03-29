class IndexController < ApplicationController

  def start
  end

  def search
    @topics = TopicsStart.new.getTopics
  end

  def finde
    @query = params[:query]
    if !@query.blank?
      twitterClient = TwitterClient.new
      twitterClient.simpleSearch(@query, 10)
      @tweets = twitterClient.getTweetsAsArray
      @countsHashtags = twitterClient.getHashtagsAsHash
      @countsTwitterHandles = twitterClient.getTwitterHandlesAsHash
      @countsWebpages = twitterClient.getURLsAsHash
    end
  end

  def about
  end

  def db_search
    @q = params[:q]
    if !@q.blank?
      dbsearch = DbSearch.new
      @sobj = dbsearch.parseQuery(@q)
    end
  end

end



