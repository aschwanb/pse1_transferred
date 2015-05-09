class SearchObject
  @search_successful
  @search_valid
  @search_deprecated
  @search_terms
  @search_criteria_hashtags
  @search_criteria_authors
  @paired_hashtags_popular
  @paired_hashtags_trending
  @authors
  @webpages

  def initialize(query)
    @search_terms = query
    @search_terms.empty? ? @search_valid = false : @search_valid = true
    @search_successful = false
    @search_deprecated = false
    @search_criteria_authors = Array.new
    @search_criteria_hashtags = Array.new
    @webpages = Array.new
    @paired_hashtags_popular = Hash.new
    @paired_hashtags_trending = Hash.new
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

  # TODO: Comment what is depication in this contect?
  def set_search_deprecated
    @search_deprecated = true
  end

  def is_deprecated?
    return @search_deprecated
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

  # TODO: Could you comment on the anchor ?
  def set_paired_hashtags_popular(anchor, paired_hash)
    @paired_hashtags_popular.store(anchor, paired_hash) if @search_criteria_hashtags.include?(anchor)
  end

  def get_paired_hashtags_popular
    return @paired_hashtags_popular
  end

  def set_paired_hashtags_trending(anchor, paired_hash)
    return if paired_hash.blank?
    @paired_hashtags_trending.store(anchor, paired_hash) if @search_criteria_hashtags.include?(anchor)
  end

  def get_paired_hashtags_trending
    return @paired_hashtags_trending
  end

  def set_authors(authors)
    @authors = authors
  end

  def get_authors
    return @authors
  end

  def set_webpages(webpages)
    @webpages = webpages
  end

  def get_webpages
    return @webpages
  end
end