
# TODO: refactor this!
class SearchObject
  @search_successful
  @search_valid
  @search_terms
  @search_criteria_hashtags
  @search_criteria_authors
  @tweets
  @authors
  @hashtags

  def initialize(query)
    @search_terms = query
    @search_terms.empty? ? @search_valid = false : @search_valid = true
    @search_successful = false
    @search_criteria_authors = Array.new
    @search_criteria_hashtags = Array.new
  end

  def is_valid?
    return @search_valid
  end

  def set_search_successful
    @search_successful = true
  end

  def is_successful?
    return @search_successful
  end

  def add_search_terms(terms)
    @search_terms += terms
  end

  def get_search_terms
    return @search_terms
  end

  def add_criterion_hashtag(hashtag)
    @search_criteria_hashtags.append(hashtag)
  end

  def get_criteria_hashtags
    return @search_criteria_hashtags
  end

  def add_criterion_author(author)
    @search_criteria_authors.append(author)
  end

  def get_criteria_authors
    return @search_criteria_authors
  end

  # def add_tweets(tweets)
  #   @tweets.append(tweets)
  # end

  def set_tweets(tweets)
    set_search_successful unless tweets.empty?
    # # create an sorted array with author names (string)
    # author_names = []
    # hashtags = []
    # hashtag_text = []
    # tweets.each do |tweet|
    #   author_names.append(tweet.get_author.get_name)
    #   hashtags.concat(tweet.get_hashtags)
    # end
    # count = Hash.new(0)
    # author_names.each {|element| count[element] += 1}
    # author_names = author_names.uniq.sort {|x,y| count[y] <=> count[x]}
    # self.set_authors_sorted(author_names)
    #
    # # create an sorted array with hashtags (string)
    # hashtags = hashtags.flatten
    # hashtags.each do |hashtag|
    #   hashtag_text.append(hashtag.get_text)
    # end
    # count = Hash.new(0)
    # hashtag_text.each {|element| count[element] += 1}
    # hashtag_text = hashtag_text.uniq.sort {|x,y| count[y] <=> count[x]}
    # self.set_hashtags_sorted(hashtag_text)
    #
    # count = Hash.new(0)
    # tweets.each {|element| count[element] += 1}
    # tweets = tweets.uniq.sort {|x,y| count[y] <=> count[x]}
    @tweets = tweets
  end

  def get_tweets
    return @tweets
  end

  def set_hashtags(hashtags)
    @hashtags = hashtags
  end

  def get_hashtags
    return @hashtags
  end

  def set_authors(authors)
    @authors = authors
  end

  def get_authors
    return @authors
  end

  # def set_hashtags(hashtags)
  #   @search_criteria_hashtags = hashtags
  # end

  # def set_authors(authors)
  #   @search_criteria_authors = authors
  # end

  # # takes an unique array of strings sorted by occurrence
  # def set_authors_sorted(authors)
  #   @authors_sorted = authors
  # end

  # # returns an unique array of strings containing author names sorted by occurrence
  # def get_authors_sorted
  #   return @authors_sorted
  # end
  #
  # def set_hashtags_sorted(hashtags)
  #   @hashtags_sorted = hashtags
  # end
  #
  # def get_hashtags_sorted
  #   return @hashtags_sorted
  # end

end