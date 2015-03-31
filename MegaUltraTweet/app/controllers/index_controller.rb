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
      twitterClient.search_simple(@query, 10)
      @tweets = twitterClient.get_tweets_to_a
      @countsHashtags = twitterClient.get_hashtags_to_h
      @countsTwitterHandles = twitterClient.get_twitterhandles_to_h
      @countsWebpages = twitterClient.get_urls_to_h
    end
  end

  def about
  end

  def db_search
    @q = params[:q]
    if !@q.blank?
      dbsearch = DbSearch.new
      @sobj = dbsearch.parse_query(@q)
    else
      redirect_to(root_path)
    end

  end

end



