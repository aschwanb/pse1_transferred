
# TODO: refactor this!
class SearchObject
  @search_successful
  @search_valid
  @search_terms
  @search_criteria_hashtags
  @search_criteria_authors
  @tweets
  @authors
  @link_previews

  def initialize(query)
    @search_terms = query
    @search_terms.empty? ? @search_valid = false : @search_valid = true
    @search_successful = false
    @search_criteria_authors = Array.new
    @search_criteria_hashtags = Array.new
    @link_previews = Array.new
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

  def set_tweets(tweets)
    set_search_successful unless tweets.empty?
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

  def set_preview(link_previews)
    @link_previews = link_previews
  end

  def get_preview
    return @link_previews
  end
end