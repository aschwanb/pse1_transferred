module ApplicationHelper
  def link_preview_content(page)
    page.get_title.blank? ? title = page.get_url : title = page.get_title
    descr = page.get_description
    descr.blank? ? content_tag(:p, title, class: "link-preview-title"):
        content_tag(:p, title, class: "link-preview-title").concat(content_tag(:p, page.get_description, class: "link-preview-descr"))
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

end
