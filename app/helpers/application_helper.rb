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

  def button(title, link, options)
    css = "btn gradient round raised btn-xs"
    css += " btn-#{options[:type]}" if !options[:type].blank?
    klass = options.merge!(class: css)
    return link_to(title, link, klass)
  end


end
