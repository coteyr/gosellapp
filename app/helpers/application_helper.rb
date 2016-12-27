module ApplicationHelper

  def avatar_url(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      default_url = "#{root_url}images/guest.png"
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{CGI.escape(default_url)}"
    end
  end


  # Returns the full title on a per-page basis.
  def full_title(page_title = "")
    base_title = "GoSell"
    if page_title.empty?
      base_title
    else
      base_title + " | " + page_title
    end
  end

  def button(title, link, options={})
    size = 'xs'
    size = options.delete :size if options[:size]
    css = "btn round gradient raised btn-#{size}"
    css += " btn-#{options[:type]}" if !options[:type].blank?
    css += " #{options[:class]}" if options[:class]
    klass = options.merge!(class: css)
    return link_to(title, link, klass)
  end
  def data_pair(title, objekt, method)
    to_return = '<div class="row" style="margin-top: 0px">'
    unless objekt.send(method).blank?
      to_return += "#{title}"
      to_return += '&nbsp;'
      to_return += objekt.send(method).to_s
    end
    to_return += '</div>'
    to_return.html_safe
  end
end
