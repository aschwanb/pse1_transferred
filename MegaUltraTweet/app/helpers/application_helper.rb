module ApplicationHelper
  def link_preview_content(page)
    page.get_title.blank? ? title = page.get_url : title = page.get_title
    descr = page.get_description
    descr.blank? ? content_tag(:p, title, class: "link-preview-title"):
        content_tag(:p, title, class: "link-preview-title").concat(content_tag(:p, page.get_description, class: "link-preview-descr"))
  end

end
