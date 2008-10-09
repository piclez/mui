module MuiPage::MuiPages

  def mui_page?
    controller_name == 'mui_page/pages'
  end

  def mui_page_truncate(options = {})
    limit = options[:limit] || 50
    title = options[:title] || '...continued'
    page_parsed = options[:body].gsub(/<\/?[^>]*>/, '')
    page_split = page_parsed.split(/ /)
    if page_split.size > limit
      page_split.first(limit).join(' ') + tag(:i, title, :class => 'mui_truncate')
    else
      page_split
    end
  end

end

include MuiPage::MuiPages
