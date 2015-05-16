
module ApplicationHelper

  def fetch_trending_short
    return Trending.first.get_popular_short
  end

  def fetch_trending_long
    return Trending.second.get_popular_long
  end

  def fetch_hashtags
    return Hashtag.take(20)
  end

  def fetch_authors
    return Author.take(20)
  end

  def fetch_tweets
    return Tweet.take(5)
  end

  def link_preview_content(page)
    page.get_title.blank? ? title = page.get_url : title = page.get_title
    descr = page.get_description
    descr.blank? ? content_tag(:p, title, class: "link-preview-title"):
        content_tag(:p, title, class: "link-preview-title").concat(content_tag(:p, page.get_description, class: "link-preview-descr"))
  end

  def is_multi_search?(search_object)
    return search_object.get_criteria_hashtags.size > 1 ? true : false
  end

  def switch_trifold(anchor)
    symbol = create_symbol(anchor)
    id = create_id(anchor)
    switch = content_tag(:div, class: ["switch-wrapper", "trifold"]) do
      radio_button(symbol, "switch", "opt1", {class: "hide-radio", checked: true})
      .concat label_tag(create_symbol(anchor+"-switch-opt1"),
                        content_tag(:span, content_tag(:p, "Popular"), class: "label-text"),
                        {class: "switch-label", data: {opt: "opt1", target: id}})
      .concat radio_button(symbol, "switch", "opt2", {class: "hide-radio"})
      .concat label_tag(create_symbol(anchor+"-switch-opt2"),
                        content_tag(:span, content_tag(:p, "Trending 15min"), class: "label-text"),
                        {class: "switch-label", data: {opt: "opt2", target: id}})
      .concat radio_button(symbol, "switch", "opt3", {class: "hide-radio"})
      .concat label_tag(create_symbol(anchor+"-switch-opt3"),
                        content_tag(:span, content_tag(:p, "Trending 48h"), class: "label-text"),
                        {class: "switch-label", data: {opt: "opt3", target: id}})
    end
    return switch
  end

  def embedded_svg(filename, options = {})
    assets = Rails.application.assets
    file = assets.find_asset(filename).body.force_encoding("UTF-8")
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css "svg"
    if options[:class].present?
      svg["class"] = options[:class]
    end
    raw doc
  end

  private

  def create_symbol(str)
    return str.parameterize.underscore.to_sym
  end

  def create_id(str)
    return "js-htg-"+str.slice(1, str.length)
  end

end
