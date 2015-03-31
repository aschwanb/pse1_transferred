class IndexController < ApplicationController

  def start
  end

  def search
    @topics = Startingpoint.first.get_start
  end

  def find
    @query = params[:query]
    if !@query.blank?
      client = TwitterClient.new
      client.search_simple(@query, 10)
      @tweets = client.get_tweets_to_a
      @counts_hashtags = client.get_hashtags_to_h
      @counts_twitterhandles = client.get_twitterhandles_to_h
      @counts_webpages = client.get_urls_to_h
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



