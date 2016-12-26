# @Author: Robert D. Cotey II <coteyr@coteyr.net>
# @Date:   2016-12-22 13:22:09
# @Last Modified by:   Robert D. Cotey II <coteyr@coteyr.net>
# @Last Modified time: 2016-12-24 17:51:50
module ContentHelper
  def row(options={}, &block)
    to_return = '<div class="row container-fluid">' if !options[:pad] or options[:pad] == true
    to_return = '<div class="row">' if options[:pad] == false
    to_return += with_output_buffer(&block)
    to_return += '</div>'
    to_return.html_safe
  end
  def panel(options={}, &block)
    size = options[:size] || 6
    offset = options[:offset] || 3
    to_return = '<div class="panel panel-default '
    to_return += "col-md-#{size} "
    to_return += "col-md-offset-#{offset}"
    to_return += '">'
    to_return += with_output_buffer(&block)
    to_return += '</div>'
    to_return.html_safe
  end
  def panel_footer(options={}, &block)
    to_return = '<div class="col-xs-12 panel-footer">'
    to_return += with_output_buffer(&block)
    to_return += '</div>'
    to_return.html_safe
  end
  def menu_button(title, url, options={})
    options.merge!(class: 'btn btn-default raised btn-block')
    to_return =  '<div class="panel center"><div class="row"><div class="col-xs-6 col-xs-offset-3">'
    to_return += link_to title, url, options
    to_return += '</div></div></div>'
    to_return.html_safe
  end
  def menu_panel(id, &block)
    to_return = '<div id="'
    to_return += id
    to_return += '" class="panel-collapse collapse"><div class="panel-body"><div class="row center">'
    to_return += with_output_buffer(&block)
    to_return += '</div></div></div>'
    to_return.html_safe
  end
  def menu_toggle(title, id, &block)
    to_return = menu_button title, "##{id}", data: {toggle: 'collapse', parent: '#accordion'}, role: 'button'
    to_return += menu_panel id, &block
    to_return.html_safe
  end
  def collapseable_well(title, id, options={}, &block)
    to_return = "<div id='#{id}' class='collapse'>"
    to_return += well(title, link: "<a href='##{id}' data-toggle='collapse' class='btn btn-default btn-xs pull-right' type='button' ><span class='fa fa-close'></span></a>", &block)
    to_return += '</div>'
    to_return.html_safe
  end
  def well(title, options={}, &block)
    size = 12 || options[:size]
    to_return =  "<div class='panel panel-default col-md-#{size}'>"
    to_return += '<div class="panel-heading">'

    to_return += '<h2 class="panel-title">'
    if options[:subheading]
      to_return += '<h6 class="pull-right" style="position: relative;top: 50%;transform: translateY(-50%);">'
      to_return += options[:subheading]
      to_return += '</h6>'
    end
    if options[:link]
      to_return += options.delete :link
    end
    to_return += title
    to_return += '</h2>'

    to_return += '</div>'
    to_return += with_output_buffer(&block)
    to_return += '</div>'
    to_return.html_safe
  end
end
