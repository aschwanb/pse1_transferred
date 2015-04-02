require 'search_object'
class DbSearch

  @limit

  def initialize
    @limit = 30
  end

  def parse_query(query)
    query = query.to_s.downcase

    # Create array with the search terms
    search_terms = query.scan(/\w+/).flatten

   # if search_terms.length == 1
   #   term = search_terms[0].to_s
   # end

    # hashtags = query.scan(/#\w+/).flatten
    # authors = query.scan(/@\w+/).flatten
    # search_terms = hashtags + authors
    # search_object = SearchObject.new(search_terms)
    # dbe_hashtag = []
    # dbe_hashtag.append(Hashtag.find_by_text(hashtags[0]))
    #
    # if !dbe_hashtag.first.nil?
    #   search_object.set_hashtags(dbe_hashtag)
    #   search_object.set_tweets(dbe_hashtag.first.get_tweets)
    #   search_object.set_search_successful
    # end

    # if hashtags.length == 1
    #   sobj = SearchObject.new(hashtags)
    #   hashtag_id = Hashtag.find_by_text(hashtags[0]).id
    #   tweets = Tweet.joins(:hashtags_tweets).where(hashtag_id: hashtag_id)
    #   tweet_text = []
    #   tweets.find_each do |tweet|
    #     tweet_text += tweet.text
    #   end
    #   sobj.addTweets(tweet_text)
    # end

    search_object = multi_search(search_terms, SearchObject.new(search_terms))
    search_object = evaluate(search_object)
    return search_object
  end

  # private

  def single_search(search_term, search_object)
    # search_object = SearchObject.new(search_term)
    # some authors have hashtags as screen name but no hashtag starts with '@'...

    # screen names are saved without '@' in the DB
    search_term.chr =~ /@/ ? term = search_term.slice(1, search_term.length) : term = search_term
    # author = Author.by_screen_name(term)
    author = Author.find_by_screen_name(term)

    # hashtags are saved with '#' in the DB
    search_term.chr =~ /#/ ? term = search_term : term = "#".concat(search_term)
    # hashtag = Hashtag.by_hashtag(term)
    hashtag = Hashtag.find_by_text(term)

    search_object.add_criterion_author(author) unless author.nil?
    search_object.add_criterion_hashtag(hashtag) unless hashtag.nil?


    return search_object
  end

  def multi_search(search_terms, search_object)
    return search_object unless search_object.is_valid?
    sobj = search_object
    search_terms.each do |term|
      sobj = single_search(term.to_s, sobj)
    end
    return sobj
  end

  def evaluate(search_object)
    return search_object unless search_object.is_valid?
    authors = search_object.get_criteria_authors
    hashtags = search_object.get_criteria_hashtags
    tweets = []

    # only hashtags as search criteria, AND relation condition between hashtags
    if authors.empty?
      tweets = retrieve_tweets_by_hashtags(hashtags, @limit)
    # only authors as search criteria, OR relation condition
    elsif hashtags.empty?
      tweets = retrieve_tweets_by_authors(authors, @limit)
    # both hashtags and authors as search criteria, (AND{hashtags}) AND (OR{authors})
    else
      tweets_by_hashtags = retrieve_tweets_by_hashtags(hashtags, @limit)
      tweets_by_authors = retrieve_tweets_by_authors(authors, @limit)
      # get common elements between the arrays (Intersection)
      tweets = tweets_by_hashtags & tweets_by_authors
    end

    #Get relevant records and sort them by popularity (rank)
    rel_authors = []
    rel_hashtags = []
    tweets.each do |tweet|
      rel_authors.append(tweet.get_author)
      rel_hashtags.concat(tweet.get_hashtags)
    end

    sorter = Sorter.new
    tweets = sorter.sort_by_rank(tweets)
    rel_authors = sorter.sort_by_rank(rel_authors)
    rel_hashtags = sorter.sort_by_occurrence(rel_hashtags)

    search_object.set_tweets(tweets)
    search_object.set_authors(rel_authors)
    search_object.set_hashtags(rel_hashtags)
    return search_object
  end

  # given an array of hashtags, returns the tweets containing all given hashtags
  def retrieve_tweets_by_hashtags(hashtags, limit)
    return Array.new if hashtags.empty?
    tweets = hashtags.first.get_tweets(limit)
    hashtags.each do |hashtag|
      # does not work for some reason..
      # tweets.each do |tweet|
      #   if !tweet.get_hashtags.include?(hashtag)
      #     tweets.delete(tweet)
      #     if !tweets.include?(tweet)
      #     end
      #   end
      #   # tweets.delete(tweet) unless tweet.get_hashtags.include?(hashtag)
      # end
      tweets.delete_if { |tweet| !tweet.get_hashtags.include?(hashtag)}
    end
    return tweets
  end

  # given an array of authors, returns the tweets they wrote
  def retrieve_tweets_by_authors(authors, limit)
    return Array.new if authors.empty?
    tweets = []
    authors.each do |author|
      tweets.concat(author.get_tweets(limit))
    end
    return tweets
  end

  # private_class_method :simple_search

end