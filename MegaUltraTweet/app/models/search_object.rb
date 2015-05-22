class SearchObject
  @search_successful
  @search_valid
  @search_deprecated
  @search_terms
  @search_criteria_hashtags
  @paired_hashtags
  @webpages

  def initialize(query)
    @search_terms = query
    @search_terms.empty? ? @search_valid = false : @search_valid = true
    @search_successful = false
    @search_deprecated = false
    @search_criteria_hashtags = Array.new
    @webpages = Array.new
    @paired_hashtags = Hash.new
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

  # The search is in the state deprecated if the following conditions are met:
  # - Hashtag or Hashtag pair was found in the DB
  # - There are no associated tweets in the DB (because they were deleted)
  # This state indicates that the hashtag was once used but finds now little to no usage in tweets
  def set_search_deprecated
    @search_deprecated = true
  end

  def is_deprecated?
    return @search_deprecated
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

  # The anchor is a hashtag the others are relative to
  def set_paired_hashtags(anchor, paired_hash, trending_short_partners, trending_long_partners)
    sub_hash = { popular_partners: paired_hash, trending_short_partners: trending_short_partners,
                trending_long_partners: trending_long_partners }
    @paired_hashtags.store(anchor, sub_hash)
  end

  def get_paired_hashtags
    return @paired_hashtags
  end

  def set_webpages(webpages)
    @webpages = webpages
  end

  def get_webpages
    return @webpages
  end
end