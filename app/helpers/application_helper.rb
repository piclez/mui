module Merb::MerbInterface::ApplicationHelper

  def gecko?
    request.user_agent.include? 'Gecko/'
  end

  def msie?
    request.user_agent.include? 'MSIE'
  end

  def webkit?
    request.user_agent.include? 'AppleWebKit'
  end

  # The bastard child
  def self.humanize(lower_case_and_underscored_word)
    lower_case_and_underscored_word.to_s.gsub(/_id$/, "").gsub(/_/, " ").capitalize
  end

  def self.pluralize(string)
    string.pluralize
  end

  def truncate(text, length = 30, truncate_string = "...") #:nodoc:
    if text
      l = length - truncate_string.length
      (text.length > length ? text[0...l] + truncate_string : text).to_s
    end
  end

  def simple_format(text, html_options={})
    start_tag = tag('p', html_options, true)
    text = text.to_s.dup
    text.gsub!(/\r\n?/, "\n")                    # \r\n and \r -> \n
    text.gsub!(/\n\n+/, "</p>\n\n#{start_tag}")  # 2+ newline  -> paragraph
    text.gsub!(/([^\n]\n)(?=[^\n])/, '\1<br />') # 1 newline   -> br
    text.insert 0, start_tag
    text << "</p>"
  end

  def link_to(*args, &block)
    if block_given?
      url, options = args[0..1]
      concat(link_to(capture(&block), url, options), block.binding)
    else
      name, url = args[0], args[1] || '#'
      options = Mash.new(:href => url).merge(args[2] || {})
      %{<a #{ options.to_xml_attributes }>#{name}</a>}
    end
  end

  def mail_to(email_address, name = nil, html_options = {})
    html_options = html_options.stringify_keys
    encode = html_options.delete("encode").to_s
    cc, bcc, subject, body = html_options.delete("cc"), html_options.delete("bcc"), html_options.delete("subject"), html_options.delete("body")

    string = ''
    extras = ''
    extras << "cc=#{CGI.escape(cc).gsub("+", "%20")}&" unless cc.nil?
    extras << "bcc=#{CGI.escape(bcc).gsub("+", "%20")}&" unless bcc.nil?
    extras << "body=#{CGI.escape(body).gsub("+", "%20")}&" unless body.nil?
    extras << "subject=#{CGI.escape(subject).gsub("+", "%20")}&" unless subject.nil?
    extras = "?" << extras.gsub!(/&?$/,"") unless extras.empty?

    email_address = email_address.to_s

    email_address_obfuscated = email_address.dup
    email_address_obfuscated.gsub!(/@/, html_options.delete("replace_at")) if html_options.has_key?("replace_at")
    email_address_obfuscated.gsub!(/\./, html_options.delete("replace_dot")) if html_options.has_key?("replace_dot")

    if encode == "javascript"
      "document.write('#{tag("a", name || email_address, html_options.merge({ "href" => "mailto:"+email_address+extras }))}');".each_byte do |c|
        string << sprintf("%%%x", c)
      end
      "<script type=\"#{Mime::JS}\">eval(unescape('#{string}'))</script>"
    elsif encode == "hex"
      email_address_encoded = ''
      email_address_obfuscated.each_byte do |c|
        email_address_encoded << sprintf("&#%d;", c)
      end

      protocol = 'mailto:'
      protocol.each_byte { |c| string << sprintf("&#%d;", c) }

      email_address.each_byte do |c|
        char = c.chr
        string << (char =~ /\w/ ? sprintf("%%%x", c) : char)
      end
      tag "a", name || email_address_encoded, html_options.merge({ "href" => "#{string}#{extras}" })
    else
      tag "a", name || email_address_obfuscated, html_options.merge({ "href" => "mailto:#{email_address}#{extras}" })
    end
  end

  def image_path(*segments)
    public_path_for(:image, *segments)
  end

  def public_path_for(type, *segments)
    ::MerbInterface.public_path_for(type, *segments)
  end

  def app_path_for(type, *segments)
    ::MerbInterface.app_path_for(type, *segments)
  end

  def slice_path_for(type, *segments)
    ::MerbInterface.slice_path_for(type, *segments)
  end
  
end